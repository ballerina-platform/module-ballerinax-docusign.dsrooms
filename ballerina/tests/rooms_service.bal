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

import ballerina/http;

listener http:Listener ep0 = new (9095, config = {host: "localhost"});

service /restapi on ep0 {
    # Gets account information.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + return - returns can be any of following types
    # string (AccountSummary)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function get v2/accounts/[string accountId]() returns string|AccountSummary|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        AccountSummary accountSummary = {
            companyId: 123,
            name: "ABC Company",
            companyVersion: "v6",
            docuSignAccountGuid: "abc123",
            defaultFieldSetId: "def456",
            requireOfficeLibraryAssignments: true
        };
        return accountSummary;
    }

    # Gets information about or the contents of a document.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + documentId - The ID of the document. 
    # + includeContents - When **true,** includes the contents of the document in the `base64Contents` property of the response. The default value is **false.** 
    # + return - returns can be any of following types
    # string (Document)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function get v2/accounts/[string accountId]/documents/[int:Signed32 documentId](boolean includeContents = false) returns string|Document|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        Document documentPayload = {
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
        return documentPayload;
    }

    # Deletes a specified document.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + documentId - The ID of the document. 
    # + return - returns can be any of following types
    # http:NoContent (Document has been successfully deleted.)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function delete v2/accounts/[string accountId]/documents/[int:Signed32 documentId]() returns error? {
        return ();
    }

    # Grants a user access to a document.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + documentId - The ID of the document. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # string (DocumentUser)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function post v2/accounts/[string accountId]/documents/[int:Signed32 documentId]/users(@http:Payload DocumentUserForCreate|xml payload) returns string|DocumentUser|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        DocumentUser documentUserPayload = {
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
        return documentUserPayload;
    }

    # Gets eSignature Permission Profiles.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + return - returns can be any of following types
    # string (ESignPermissionProfileList)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function get v2/accounts/[string accountId]/esign_permission_profiles() returns string|ESignPermissionProfileList|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        ESignPermissionProfileList eSignPermissionProfileListPayload = {
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
        return eSignPermissionProfileListPayload;
    }

    # Creates an external form fill session.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # string (ExternalFormFillSession)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function post v2/accounts/[string accountId]/external_form_fill_sessions(@http:Payload ExternalFormFillSessionForCreate|xml payload) returns string|ExternalFormFillSession|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        ExternalFormFillSession externalFormFillSessionPayload = {
            url: "https://example.com"
        };
        return externalFormFillSessionPayload;
    }

    # Gets a field set.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + fieldSetId - The ID of the field set. Example: `4aef602b-xxxx-xxxx-xxxx-08d76696f678` 
    # + fieldsCustomDataFilters - An comma-separated list that limits the fields to return: - `IsRequiredOnCreate`: include fields that are required in room creation. - `IsRequiredOnSubmit`: include fields that are required when submitting a room for review. 
    # + return - returns can be any of following types
    # string (FieldSet)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function get v2/accounts/[string accountId]/field_sets/[string fieldSetId](("None"|"IsRequiredOnCreate"|"IsRequiredOnSubmit")[]? fieldsCustomDataFilters) returns string|FieldSet|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        FieldSet fieldSetPayload = {
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
        return fieldSetPayload;
    }

    # Gets form groups.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + count - The number of results to return. This value must be a number between `1` and `100` (default). 
    # + startPosition - The starting zero-based index position of the results set. The default value is `0`. 
    # + return - returns can be any of following types
    # string (FormGroupSummaryList)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function get v2/accounts/[string accountId]/form_groups(int:Signed32 count = 100, int:Signed32 startPosition = 0) returns string|FormGroupSummaryList|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        FormGroupSummaryList formGroupSummaryListPayload = {
            formGroups: [],
            resultSetSize: 2,
            startPosition: 0,
            endPosition: 1,
            nextUri: "https://example.com/next",
            priorUri: "https://example.com/previous"
        };
        return formGroupSummaryListPayload;
    }

    # Creates a form group.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # string (FormGroup)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function post v2/accounts/[string accountId]/form_groups(@http:Payload FormGroupForCreate|xml payload) returns string|FormGroup|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        FormGroup formGroupPayload = {
            formGroupId: "7b879c89-xxxx-xxxx-xxxx-819d6a85e0a1",
            name: "Example Form Group",
            officeIds: [1, 2, 3],
            forms: []
        };
        return formGroupPayload;
    }

    # Gets a form group.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + formGroupId - The ID of the form group. Example: `7b879c89-xxxx-xxxx-xxxx-819d6a85e0a1` 
    # + return - returns can be any of following types
    # string (FormGroup)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function get v2/accounts/[string accountId]/form_groups/[string formGroupId]() returns string|FormGroup|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        FormGroup formGroupPayload = {
            formGroupId: "7b879c89-xxxx-xxxx-xxxx-819d6a85e0a1",
            name: "Example Form Group",
            officeIds: [1, 2, 3],
            forms: []
        };
        return formGroupPayload;
    }

    # Renames a form group.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + formGroupId - The ID of the form group. Example: `7b879c89-xxxx-xxxx-xxxx-819d6a85e0a1` 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # string (FormGroup)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function put v2/accounts/[string accountId]/form_groups/[string formGroupId](@http:Payload xml|FormGroupForUpdate payload) returns string|FormGroup|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        FormGroup formGroupPayload = {
            formGroupId: "7b879c89-xxxx-xxxx-xxxx-819d6a85e0a1",
            name: "Example Form Group",
            officeIds: [1, 2, 3],
            forms: []
        };
        return formGroupPayload;
    }

    # Deletes a form group.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + formGroupId - The ID of the form group. Example: `7b879c89-xxxx-xxxx-xxxx-819d6a85e0a1` 
    # + return - returns can be any of following types
    # http:NoContent (Successfully deleted form group.)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function delete v2/accounts/[string accountId]/form_groups/[string formGroupId]() returns error? {
        return ();
    }

    # Gets the user's form group forms.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + formGroupId - The ID of the form group. Example: `7b879c89-xxxx-xxxx-xxxx-819d6a85e0a1` 
    # + count - The number of results to return.  Default value is 100 and max value is 100 
    # + startPosition - The starting point of the list. The default is 0. 
    # + return - returns can be any of following types
    # string (FormGroupFormList)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function get v2/accounts/[string accountId]/form_groups/[string formGroupId]/forms(int:Signed32 count = 100, int:Signed32 startPosition = 0) returns string|FormGroupFormList|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        FormGroupFormList formGroupFormListPayload = {
            forms: [],
            resultSetSize: 2,
            startPosition: 0,
            endPosition: 1,
            nextUri: "https://example.com/next",
            priorUri: "https://example.com/previous"
        };
        return formGroupFormListPayload;
    }

    # Updates a user's default office.
    #
    # + accountId - The globally unique identifier (GUID) for the account. 
    # + userId - The ID of the user to update. 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # string (User)
    # BadRequestStringApierrorXml (Bad request. See ErrorCode and Message for details)
    # UnauthorizedStringApierrorXml (Not authorized to make this request.)
    resource function put v2/accounts/[string accountId]/users/[int:Signed32 userId](@http:Payload UserForUpdate|xml payload) returns string|User|xml|BadRequestStringApierrorXml|UnauthorizedStringApierrorXml {
        return {
            userId: 1,
            email: "john.doe@example.com",
            firstName: "John",
            lastName: "Doe",
            isLockedOut: false,
            status: "Active",
            accessLevel: "Contributor",
            defaultOfficeId: 123,
            titleId: 456,
            roleId: 789,
            profileImageUrl: "https://example.com/profile.jpg",
            offices: [1, 2, 3],
            regions: [4, 5, 6],
            permissions: {}
        };
    }
}
