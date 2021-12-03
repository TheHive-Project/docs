# List responder actions

List actions run on an *Alert*.

## Query

```plain
GET /api/connector/cortex/action/responder/alert/{id}
```

With:

- `id`: *Alert* identifier

##  Response 

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error

### Response Body Example

!!! Example ""

    === "200" 

        ```json
          [
            {
              "responderId": "25dcbbb69d50dd5a5ae4bd55f4ca5903",
              "responderName": "reponderName_1_0",
              "responderDefinition": "reponderName_1_0",
              "cortexId": "local-cortex",
              "cortexJobId": "408-unsB3SwW9-eEPXXW",
              "objectType": "Alert",
              "objectId": "~25313328",
              "status": "Success",
              "startDate": 1630917246993,
              "endDate": 1630917254406,
              "operations": "[]",
              "report": "{\"summary\":{\"taxonomies\":[]},\"full\":null,\"success\":true,\"artifacts\":[],\"operations\":[],\\\"message\\\":\\\"Ok\\\",\\\"parameters\\\":{\\\"organisation\\\":\\\"StrangeBee\\\",\\\"user\\\":\\\"user@thehive.local\\\"},\\\"config\\\":{\\\"proxy_https\\\":null,\\\"cacerts\\\":null,\\\"check_tlp\\\":false,\\\"max_tlp\\\":2,\\\"check_pap\\\":false,\\\"max_pap\\\":2,\\\"jobTimeout\\\":30,\\\"proxy_http\\\":null}}\"}"
            }
          ]
        ```

    === "401" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Authentication failure"
        }
        ```

## List available Responders

### Request

To get the list of Responders available for an *Alert*, based on its TLP and PAP, you can call the following API:

```plain
GET /api/connector/cortex/responder/alert/{id}
```

With:

- `id`: *Alert* identifier

### Response

!!! Example ""

    === "200" 

        ```json
        [
            {
                "id": "e33d63082066c739c07d2bbc199bfe7e",
                "name": "MALSPAM_Reply_to_user_1_0",
                "version": "1.0",
                "description": "Reply to user with an email. Applies on tasks",
                "dataTypeList": [
                    "thehive:Alert"
                ],
                "cortexIds": [
                    "Demo"
                ]
            }
        ]
        ```

    === "401" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Authentication failure"
        }
        ```
