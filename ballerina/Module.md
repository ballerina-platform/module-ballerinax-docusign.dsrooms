## Overview

The Ballerina DocuSign Rooms connector effectively manages and organizes agreements, particularly those related to mortgage and real estate transactions.

The Ballerina Docusign Rooms module supports [DocuSign Rooms API V2](https://github.com/docusign/OpenAPI-Specifications/blob/master/rooms.rest.swagger-v2.json).

## Set up Guide

To utilize the Rooms connector, you must have access to the DocuSign REST API through a DocuSign account.

### Step 1: Create a DocuSign Account

In order to use the DocuSign Rooms connector, you need to first create the DocuSign credentials for the connector to interact with DocuSign.

- You can [create an account](https://go.docusign.com/o/sandbox/) for free at the [Developer Center](https://developers.docusign.com/).

    <img src="https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsrooms/main/ballerina/resources/create-account.png" alt="Create DocuSign Account" width="50%">

### Step 2: Create Integration Key and Secret Key

1. **Create an Integration Key and Secret Key**: Visit the [Apps and Keys](https://admindemo.docusign.com/apps-and-keys) page on DocuSign. Click on "Add App and Integration Key", provide an App name, and click "Create App". This will generate an Integration Key.

    <img src="https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsrooms/main/ballerina/resources/app-and-integration-key.png" alt="Create Integration Key" width="50%">

2. **Generate a Secret Key**: Under the Authentication section, click on "Add Secret Key". This will generate a Secret Key. Make sure to copy and save both the Integration Key and Secret Key.

    <img src="https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsrooms/main/ballerina/resources/add-secret-key.png" alt="Add Secret Key" width="50%">

### Step 3: Generate Access Token

1. **Add a Redirect URI**: Click on "Add URI" and enter your redirect URI (e.g., <http://www.example.com/callback>).

    <img src="https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsrooms/main/ballerina/resources/add-redirect-uri.png" alt="Add Redirect URI" width="50%">

2. **Generate the Encoded Key**: The Encoded Key is a base64 encoded string of your Integration Key and Secret Key in the format `{IntegrationKey:SecretKey}`. You can generate this in your web browser's console using the `btoa()` function: `btoa('IntegrationKey:SecretKey')`. You can either generate the encoded key from an online base64 encoder.

3. **Get the Authorization Code**: Visit the following URL in your web browser, replacing `{iKey}` with your Integration Key and `{redirectUri}` with your Redirect URI:

    ```url
    https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature%20organization_read%20dtr.rooms.read%20dtr.rooms.write%20dtr.documents.read%dtr.documents.write&client_id={iKey}&redirect_uri={redirectUri}
    ```

    This will redirect you to your Redirect URI with a `code` query parameter. This is your Authorization Code.

4. **Get the Access Token**: Use the following `curl` command to get the Access Token, replacing `{encodedKey}` with your Encoded Key and `{codeFromUrl}` with your Authorization Code:

    ```bash
    curl --location 'https://account-d.docusign.com/oauth/token' \
    --header 'Authorization: Basic {encodedKey}' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'code={codeFromUrl}' \
    --data-urlencode 'grant_type=authorization_code'
    ```

    The response will contain your Access Token.

Remember to replace `{IntegrationKey:SecretKey}`, `{iKey}`, `{redirectUri}`, `{encodedKey}`, and `{codeFromUrl}` with your actual values.

Above is about using the DocuSign Rooms APIs in the developer mode. If your app is ready to go live, you need to follow the guidelines given [here](https://developers.docusign.com/docs/esign-rest-api/go-live/) to make it work.

## Quickstart

This sample demonstrates a scenario of creating an envelope with a document and sending it to respective recipients to add the e-signature using the Ballerina Google DocuSign eSignature connector.

### Step 1: Import the package

Import the `ballerinax/docusign.dsrooms` package into your Ballerina project.

```ballerina
import ballerinax/docusign.dsrooms;
```

### Step 2: Instantiate a new connector

Create a `dsrooms:ConnectionConfig` with the obtained OAuth2.0 tokens and initialize the connector with it.

```ballerina
configurable string accessToken = ?;

dsrooms:ConnectionConfig connectionConfig = {
    auth: {
        token: accessToken
    }
};

public function main() returns error? {
    dsrooms:Client docusignClient = check new(
        config = connectionConfig,
        serviceUrl = "https://demo.docusign.net/restapi/"
    );
}
```

### Step 3: Invoke the connector operation

You can now utilize the operations available within the connector.

```ballerina
public function main() returns error? {
    dsrooms:Client docusignClient = ...// Initialize the DocuSign Click connector;

    dsrooms:EnvelopeSummary envResult = check docusignClient->/accounts/[accountId]/envelopes.post(
    {
        documents: [
            {
                documentBase64: "base64-encoded-pdf-file",
                documentId: "1",
                fileExtension: "pdf",
                name: "document"
            }
        ],
        emailSubject: "Simple Signing Example",
        recipients: {
            signers: [
                {
                    email: "randomtester12@corp.com",
                    name: "randomtester12",
                    recipientId: "12"
                }
            ]
        },
        status: "sent"
    }
);
}
```

## Examples

The DocuSign Rooms connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsrooms/tree/main/examples).

1. [Manage Mortgage Documents with DocuSign Rooms](https://github.com/ballerina-platform/module-ballerinax-docusign.dsrooms/tree/main/examples/manage_mortgage_documents)
    This example shows how to use DocuSign Rooms APIs to efficiently manage mortage documents

2. [Manage Real Estate Documents with DocuSign Rooms](https://github.com/ballerina-platform/module-ballerinax-docusign.dsrooms/tree/main/examples/real-estate-documents)
    This example shows how to use DocuSign Rooms APIs to efficiently manage real estate documents
