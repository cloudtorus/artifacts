import groovy.transform.SourceURI
import groovy.yaml.YamlSlurper

import java.nio.file.Path

class ArtifactManager {
    Closure<Void> beforeParse = {}
    Closure<Void> afterParse = {}
    private List<Artifact> artifacts = []

    def getArtifacts() {
        return Collections.unmodifiableList(artifacts)
    }

    def populateFromDisk() {
        artifacts.clear()

        @SourceURI
        URI scriptURI
        // noinspection GroovyVariableNotAssigned
        def scriptPath = Path.of(scriptURI)
        def artifactsPath = Path.of(scriptPath.toString(), '../../../../../../').normalize()
        def artifactsFolder = new File(artifactsPath as String)
        def yamlParser = new YamlSlurper()
        def yamlMap = [:] as LinkedHashMap<String, Artifact>

        artifactsFolder.traverse {
            if (it.path.startsWith('.') || !it.path.endsWith('/torus.yaml'))
                return

            this.beforeParse it

            def yamlArtifact = yamlParser.parse it

            if (yamlArtifact.dependencies == null)
                yamlArtifact.dependencies = List.of()

            assert yamlArtifact.version instanceof String, 'version is required'
            assert yamlArtifact.name instanceof String, 'name is required'
            assert yamlArtifact.icon == null || yamlArtifact.icon instanceof String, 'icon must be a string'
            assert yamlArtifact.description  == null || yamlArtifact.description instanceof String, 'description must be a string'
            assert yamlArtifact.tags instanceof List, 'tags is required'
            assert yamlArtifact.paths instanceof List, 'paths is required'
            assert yamlArtifact.providers instanceof List, 'providers is required'
            assert yamlArtifact.dependencies instanceof List, 'dependencies is optional'

            def module = artifactsFolder.toPath().relativize(it.parentFile.toPath()) as String

            yamlArtifact.dependencies = (yamlArtifact.dependencies as List).stream().map {
                if (it instanceof String) {
                    return new ArtifactDependency(
                            name: it,
                            refs: List.of(new ArtifactRef(
                                    ref: it,
                                    version: null)),
                            constraints: null,
                            providers: null,
                    )
                }

                assert it.name instanceof String, 'dependencies.[].name is required'
                assert it.ref instanceof String || it.refs instanceof List, 'dependencies.[].refs is required'
                assert it.constraints == null || it.constraints instanceof Map, 'dependencies[].constraints must be a key-value map'
                assert it.providers == null || it.providers instanceof List, 'dependencies.[].providers must be a list'

                if (it.refs != null) {
                    (it.refs as List).each {
                        if (it instanceof String)
                            return

                        assert it.ref instanceof String, 'ref is required in refs'
                    }
                }

                return new ArtifactDependency(
                        name: it.name,
                        refs: it.ref != null ?
                                List.of(new ArtifactRef(ref: it.ref)) :
                                (it.refs as List).stream().map { ref ->
                                    if (ref instanceof String)
                                        return new ArtifactRef(ref: ref)

                                    return new ArtifactRef(
                                            ref: ref.ref,
                                            version: ref.version)
                                }.toList(),
                        constraints: it.constraints,
                        providers: it.providers
                )
            }.toList()

            def parsed = yamlMap[module] = new Artifact(
                    name: yamlArtifact.name,
                    icon: yamlArtifact.icon,
                    version: yamlArtifact.version,
                    description: yamlArtifact.description,
                    tags: yamlArtifact.tags,
                    paths: yamlArtifact.paths,
                    providers: yamlArtifact.providers,
                    dependencies: yamlArtifact.dependencies,

                    ref: module)

            afterParse(parsed)
        }

        populateFromUnsortedMap(yamlMap)
    }

    private populateFromUnsortedMap(Map<String, Artifact> yamlMap) {
        def sorted = new Stack<Artifact>()
        Closure<Void> visit
        visit = { Artifact it ->
            if (it.visited) return
            it.visited = true

            it.dependencies.each { dependency ->
                dependency.refs.each { ref ->
                    if (ref.ref == it.ref)
                        throw new IllegalStateException("${ref.ref} depends on itself")
                    def refYaml = yamlMap[ref.ref]
                    if (refYaml == null)
                        throw new IllegalArgumentException("Failed to resolve ref ${ref.ref} in ${it.ref}")

                    visit(refYaml)
                }
            }

            sorted << it
            return
        }

        yamlMap.each {
            visit(it.value)
        }

        artifacts = sorted.toList()
    }
}
