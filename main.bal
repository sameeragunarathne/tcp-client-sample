import ballerina/io;
import ballerina/log;
import ballerina/tcp;

configurable string host = "localhost";
configurable int port = 9090;

public function main() returns error? {

    // Create a new TCP client by providing the `remoteHost` and `remotePort`.
    // Optionally, you can provide the interface that the socket needs to bind 
    // and the timeout in seconds, which specifies the read timeout value.
    // tcp:Client client = check new ("localhost", 3000, localHost = "localhost", timeout = 5);
    tcp:Client socketClient = check new (host, port);

    // Send the desired content to the server.
    do {
	
	    // Send the desired content to the server.
	    check socketClient->writeBytes("Hello Ballerina".toBytes());
    } on fail var e {
    	log:printError("Error occurred: " + e.message(), e);
    }

    // Read the response from the server.
    readonly & byte[] receivedData = check socketClient->readBytes();
    string|error fromBytes = string:fromBytes(receivedData);
    if fromBytes is string {
        log:printInfo("Received: " + fromBytes);
    }

    // Close the connection between the server and the client.
    check socketClient->close();
}