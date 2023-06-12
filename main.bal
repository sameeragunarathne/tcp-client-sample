// import ballerina/io;
import ballerina/log;
// import ballerina/tcp;
import ballerinax/health.hl7v2;
import ballerinax/health.hl7v23;

configurable string host = "localhost";
configurable int port = 9090;

public function main() returns error? {

     hl7v23:QRY_A19 qry_a19 = {
        msh: {
            msh3: {hd1: "ADT1"},
            msh4: {hd1: "MCM"},
            msh5: {hd1: "LABADT"},
            msh6: {hd1: "MCM"},
            msh8: "SECURITY",
            msh9: {cm_msg1: "QRY"},
            msh10: "MSG00001",
            msh11: {pt1: "P"},
            msh12: "2.3"
        },
        qrd: {
            qrd1: {ts1: "20220828104856+0000"},
            qrd2: "R",
            qrd3: "I",
            qrd4: "QueryID01",
            qrd7: {cq1: 5},
            qrd8: [{xcn1: "1", xcn2: "ADAM", xcn3: "EVERMAN"}],
            qrd9: [{ce1: "VXI"}],
            qrd10: [{ce1: "SIIS"}]    
        }
    };

    hl7v2:HL7Client hl7client = check new(host, port);
    hl7v2:Message msg = check hl7client.sendMessage(qry_a19);
    log:printInfo(string `Response : ${msg.toJsonString()}`);
}