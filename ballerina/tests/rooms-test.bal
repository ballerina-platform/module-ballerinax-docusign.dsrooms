// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
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

import ballerina/test;

Client docuSignClient = test:mock(Client);

@test:BeforeSuite
function initializeClientsForMockServer() returns error? {
    docuSignClient = check new(
        {
            authorization: "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        },
        serviceUrl = "http://localhost:9095/restapi"
    );
}

@test:Config {
    groups: ["account"]
}
function testGetAccountDetails() returns error? {
    string account_id = "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    AccountSummary expectedPayload = {
            companyId: 123,
            name: "ABC Company",
            companyVersion: "v6",
            docuSignAccountGuid: "abc123",
            defaultFieldSetId: "def456",
            requireOfficeLibraryAssignments: true
    };
    AccountSummary response = check docuSignClient->/v2/accounts/[account_id];
    test:assertEquals(response, expectedPayload);
}

@test:Config {
    groups: ["account"]
}
function testGetAccountInformation() returns error? {
    string account_id = "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    AccountSummary expectedPayload = {
        companyId: 123,
        name: "ABC Company",
        companyVersion: "v6",
        docuSignAccountGuid: "abc123",
        defaultFieldSetId: "def456",
        requireOfficeLibraryAssignments: true
    };
    AccountSummary response = check docuSignClient->/v2/accounts/[account_id];
    test:assertEquals(expectedPayload, response);
    
}

@test:Config {
    groups: ["account"]
}
function testGetDocument() returns error? {
    Document expectedPayload = {
        documentId: 123,
        name: "example.docx",
        roomId: 456,
        ownerId: 789,
        size: 1024,
        folderId: 987,
        createdDate: "2022-01-01T10:00:00.000Z",
        isSigned: true,
        contentType: "application/msword",
        base64Contents: "SGVsbG8gd29ybGQh"
    };
    string account_id = "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    Document response = check docuSignClient->/v2/accounts/[account_id]/documents/[123]();
    test:assertEquals(expectedPayload, response);
}

@test:Config {
    groups: ["account"]
}
function testDeleteDocument() returns error? {
    string account_id = "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    error? response = check docuSignClient->/v2/accounts/[account_id]/documents/[12345].delete();
    test:assertEquals(response, ());
}

@test:Config {
    groups: ["account"]
}
function testGrantUserAccessToDocument() returns error? {
    DocumentUser expectedPayload = {
        userId: 123,
        documentId: 456,
        name: "example.docx",
        hasAccess: true,
        canApproveTask: false,
        canAssignToTaskList: true,
        canCopy: false,
        canDelete: true,
        canRemoveFromTaskList: false,
        canRemoveApproval: true,
        canRename: false,
        canShare: true,
        canViewActivity: false
    };
    string account_id = "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    DocumentUser response = check docuSignClient->/v2/accounts/[account_id]/documents/[12345]/users.post({userId: 0});
    test:assertEquals(expectedPayload, response);
}

@test:Config {
    groups: ["account"]
}
function testGetESignPermissionProfiles() returns error? {
    ESignPermissionProfileList expectedPayload = {
        permissionProfiles: [
            {
                name: "Agent01",
                eSignPermissionProfileId: "123"
            },
            {
                name: "Agent02",
                eSignPermissionProfileId: "124"
            }
        ]
    };
    string account_id = "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    ESignPermissionProfileList response = check docuSignClient->/v2/accounts/[account_id]/esign_permission_profiles();
    test:assertEquals(expectedPayload, response);
    
}

@test:Config {
    groups: ["account"]
}
function testCreateExternalFormFillSession() returns error? {
    ExternalFormFillSession expectedPayload = {
        url: "https://example.com"
    };
    string account_id = "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    ExternalFormFillSession response = check docuSignClient->/v2/accounts/[account_id]/external_form_fill_sessions.post({roomId: 0});
    test:assertEquals(expectedPayload, response);
    
}

@test:Config {
    groups: ["account"]
}
function testGetFieldSet() returns error? {
    string account_id = "de0d6e8d-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
    string field_set_id = "4aef602b-xxxx-xxxx-xxxx-08d76696f678";
    FieldSet expectedPayload = {
        fieldSetId: "4aef602b-xxxx-xxxx-xxxx-08d76696f678",
        title: "Example Field Set",
        fields: [
            {
                fieldId: "4aef602b-xxxx-xxxx-xxxx-08d76696f678",
                title: "Title1"
            },
            {
                fieldId: "4aef602b-xxxx-xxxx-xxxx-08d76696f689",
                title: "Title2"
            }
        ]
    };
    FieldSet response = check docuSignClient->/v2/accounts/[account_id]/field_sets/[field_set_id]([]);
    test:assertEquals(expectedPayload, response);
}
