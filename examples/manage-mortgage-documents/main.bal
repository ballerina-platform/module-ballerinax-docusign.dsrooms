// Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerinax/docusign.dsrooms as rooms;
import ballerina/io;
import ballerina/os;

configurable string authorization = os:getEnv("AUTHORIZATION");
configurable string accountId = os:getEnv("ACCOUNT_ID");

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
