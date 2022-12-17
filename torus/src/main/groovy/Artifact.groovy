class ArtifactYamlReference {
    String ref
    String version
    List<String> providers
    boolean unique
}

class ArtifactYamlDependency {
    String name
    List<ArtifactYamlReference> refs
}

class Artifact {
    String version
    String name
    String description
    List<String> tags
    List<String> paths
    List<String> providers
    List<ArtifactYamlDependency> dependencies

    String ref
    boolean visited = false
}
