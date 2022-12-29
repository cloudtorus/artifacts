import groovyjarjarantlr4.v4.runtime.misc.Nullable

class ArtifactRef {
    String ref
    String version
}

class ArtifactDependency {
    String name
    List<ArtifactRef> refs
    boolean unique
    @Nullable
    List<String> providers // providers for which this dependency is applicable
    @Nullable
    Map<String, String> constraints
}

class Artifact {
    String version
    String name
    String icon
    String description
    List<String> tags
    List<String> providers
    List<ArtifactDependency> dependencies

    String ref
    boolean visited = false
}
