def artifacts = new ArtifactsManager(beforeParse: { param ->
    println "Parsing ${param}"
})
artifacts.parse()
println 'Validated all artifacts'
