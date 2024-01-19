import ballerinax/docusign.dsrooms as rooms;
import ballerina/io;

configurable string authorization = ?;
configurable string accountId = ?;

public function main() returns error? {
    rooms:Client docuSignClient = check new(
        apiKeyConfig = {
            authorization: "Bearer " + authorization
        },
        config = { 
            auth: {
                token: authorization
            }
        }
    );

    rooms:Room createdRoom = check docuSignClient->/v2/accounts/[accountId]/rooms.post({
        name: "new_room",
        roleId: 0
    });
    io:println(createdRoom);

    rooms:RoomSummaryList retrievedRoom = check docuSignClient->/v2/accounts/[accountId]/rooms;
    io:println(retrievedRoom);

    rooms:ESignPermissionProfileList permissionProfilesResponse = check docuSignClient->/v2/accounts/[accountId]/esign_permission_profiles;
    io:println(permissionProfilesResponse);

    rooms:Document documentPayload = {
        name: "new_document",
        base64Contents: ""
    };

    rooms:RoomDocument roomDocumentResponse = check docuSignClient->/v2/accounts/[accountId]/rooms/[<int:Signed32>createdRoom.roomId]/documents.post({
        ...documentPayload
    });
    io:println(roomDocumentResponse);

    rooms:RoomDocumentList roomDocumentsResponse = check docuSignClient->/v2/accounts/[accountId]/rooms/[<int:Signed32>createdRoom.roomId]/documents;
    io:println(roomDocumentsResponse);
}
