import com.mongodb.MongoCommandException
import com.mongodb.TransactionOptions
import com.mongodb.WriteConcern
import com.mongodb.client.MongoClients
import com.mongodb.client.model.UpdateOptions
import org.bson.Document

def connectionUri = System.getProperty('project.uri')

if (!connectionUri) {
    println "You didn't provide a database connection URI. Try passing it using -Puri"
    println "For example, gradle load -Puri=localhost:27017"
}

def client = MongoClients.create(connectionUri)
def database = client.getDatabase(System.getProperty('project.database', 'cloudtorus'))
def applications = database.getCollection('applications')
def manager = new ArtifactManager()

manager.populateFromDisk()

def applicationDocuments = manager.artifacts.stream().map {
    new Document()
        .append('name', it.name)
        .append('ref', it.ref)
        .append('icon', it.icon)
        .append('version', it.version)
        .append('repository', 'https://github.com/cloudtorus/artifacts')
        .append('description', it.description)
        .append('tags', it.tags)
        .append('paths', it.paths)
        .append('providers', it.providers)
        .append('primitive', it.ref.startsWith('primitives/'))
        .append('dependencies', it.dependencies.stream().map { dependency ->
            new Document()
                .append('name', dependency.name)
                .append('refs', dependency.refs.stream().map { ref ->
                    new Document()
                        .append('ref', ref.ref)
                        .append('version', ref.version)
                }.toList())
                .append('constraints', dependency.constraints)
                .append('providers', dependency.providers)
        }.toList())
}.toList()
def session = client.startSession()

try {
    session.startTransaction(
            TransactionOptions.builder()
                .writeConcern(WriteConcern.MAJORITY)
                .build())

    applicationDocuments.each {
        println it.get('ref')
        applications.updateOne(
                new Document().append('ref', it.get('ref')),
                new Document().append('$set', it),
                new UpdateOptions().upsert(true))
    }

    session.commitTransaction()
} catch (MongoCommandException e) {
    println "Failed to load applications because of an error: ${e.toString()}"
    session.abortTransaction()
} finally {
    session.close()
}

client.close()
