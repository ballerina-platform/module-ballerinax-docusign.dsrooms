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

import ballerinax/docusign.dsrooms as rooms;
import ballerina/io;
import ballerina/os;

configurable string authorization = os:getEnv("AUTHORIZATION");
configurable string accountId = os:getEnv("ACCOUNT_ID");

// The main function that demonstrates the usage of DSRooms APIs
public function main() returns error? {
    // Create a new client for interacting with Docusign DSRooms APIs
    rooms:Client docuSignClient = check new (
        apiKeyConfig = {
            authorization: "Bearer " + authorization
        },
        config = {
            auth: {
                token: authorization
            }
        }
    );

    // Get the list of countries
    rooms:GlobalCountries countriesResponse = check docuSignClient->/v2/countries();
    io:println(countriesResponse);

    // Get the closing statuses
    rooms:GlobalClosingStatuses closingStatusesResponse = check docuSignClient->/v2/closing_statuses();
    io:println(closingStatusesResponse);

    // Get the list of contact sides
    rooms:GlobalContactSides contactSidesResponse = check docuSignClient->/v2/contact_sides();
    io:println(contactSidesResponse);

    // Get the list of room contact types
    rooms:GlobalRoomContactTypes roomContactTypesResponse = check docuSignClient->/v2/room_contact_types();
    io:println(roomContactTypesResponse);

    // Get the list of seller decision types
    rooms:GlobalSellerDecisionTypes sellerDecisionTypesResponse = check docuSignClient->/v2/seller_decision_types();
    io:println(sellerDecisionTypesResponse);

    // Get the list of special circumstance types
    rooms:GlobalSpecialCircumstanceTypes specialCircumstanceTypesResponse = check docuSignClient->/v2/special_circumstance_types();
    io:println(specialCircumstanceTypesResponse);

    // Get the list of task date types
    rooms:GlobalTaskDateTypes taskDateTypesResponse = check docuSignClient->/v2/task_date_types();
    io:println(taskDateTypesResponse);

    // Get the list of task responsibility types
    rooms:GlobalTaskResponsibilityTypes taskResponsibilityTypesResponse = check docuSignClient->/v2/task_responsibility_types();
    io:println(taskResponsibilityTypesResponse);

    // Get the list of transaction sides
    rooms:GlobalTransactionSides transactionSidesResponse = check docuSignClient->/v2/transaction_sides();
    io:println(transactionSidesResponse);

    // Get the list of states
    rooms:GlobalStates statesResponse = check docuSignClient->/v2/states();
    io:println(statesResponse);

    // Get the list of valid currencies
    rooms:GlobalCurrencies currenciesResponse = check docuSignClient->/v2/currencies();
    io:println(currenciesResponse);

    // Get the list of time zones
    rooms:GlobalTimeZones timeZonesResponse = check docuSignClient->/v2/time_zones();
    io:println(timeZonesResponse);

    // Get the list of offices
    rooms:OfficeSummaryList officesResponse = check docuSignClient->/v2/accounts/[accountId]/offices();
    io:println(officesResponse);
}
