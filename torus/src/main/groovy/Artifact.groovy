class ArtifactRef {
    String ref
    String version
    List<String> providers
    boolean unique
}

class ArtifactDependency {
    String name
    List<ArtifactRef> refs
}

class Artifact {
    String version
    String name
    String icon
    String description
    List<String> tags
    List<String> paths
    List<String> providers
    List<ArtifactDependency> dependencies

    String ref
    boolean visited = false
}
