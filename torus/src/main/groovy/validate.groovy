def manager = new ArtifactManager(beforeParse: { param ->
    println "Parsing ${param}"
}, afterParse: {
    println "Parsed ${it.ref}"
    println "--------------------------"
})
manager.populateFromDisk()

println()
println "=========================="
println()

manager.artifacts.each {
    print "${it.ref} ->"
    it.dependencies.each { dependency ->
        print ' ('
        print dependency.refs.stream()
                .map(ref -> ref.ref)
                .toList()
                .join(', ')
        print ')'
    }
    println()
}

println()
println "=========================="
println()

println 'Validated all artifacts'
