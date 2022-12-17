import groovy.transform.SourceURI
import groovy.yaml.YamlSlurper

import java.nio.file.Path

class ArtifactsManager {
    Closure<String> beforeParse
    Closure<String> afterParse

    def parse() {
        @SourceURI
        URI scriptURI
        def scriptPath = Path.of(scriptURI)
        def artifactsPath = Path.of(scriptPath.toString(), '../../../../../').normalize()
        def artifactsFolder = new File(artifactsPath as String)
        def yamlSlurper = new YamlSlurper()

        def yamlList = []

        artifactsFolder.traverse {
            if (it.path.startsWith('.') || !it.path.endsWith('torus.yaml'))
                return

            this.beforeParse it

            def yamlArtifact = yamlSlurper.parse it

            if (yamlArtifact.dependencies == null)
                yamlArtifact.dependencies = List.of()

            assert yamlArtifact.version instanceof String, 'version is required'
            assert yamlArtifact.name instanceof String, 'name is required'
            assert yamlArtifact.tags instanceof List, 'tags is required'
            assert yamlArtifact.paths instanceof List, 'paths is required'
            assert yamlArtifact.providers instanceof List, 'providers is required'
            assert yamlArtifact.dependencies instanceof List, 'dependencies is optional'

            yamlList << yamlArtifact
        }

        return yamlList
    }
}
