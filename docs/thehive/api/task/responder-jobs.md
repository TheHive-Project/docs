# List responder actions

List actions run on a task.

## Query

```plain
GET /api/connector/cortex/action/case_task/{id}
```

With:

- `id`: Task identifier

##  Response 

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error

### Response Body Example

!!! Example ""

    === "201" 

        ```json
          [
            {
              "responderId": "25dcbbb69d50dd5a5ae4bd55f4ca5903",
              "responderName": "reponderName_1_0",
              "responderDefinition": "reponderName_1_0",
              "cortexId": "local-cortex",
              "cortexJobId": "408-unsB3SwW9-eEPXXW",
              "objectType": "Task",
              "objectId": "~25313328",
              "status": "Success",
              "startDate": 1630917246993,
              "endDate": 1630917254406,
              "operations": "[]",
              "report": "{\"summary\":{\"taxonomies\":[]},\"full\":null,\"success\":true,\"artifacts\":[],\"operations\":[],\\\"message\\\":\\\"Ok\\\",\\\"parameters\\\":{\\\"organisation\\\":\\\"StrangeBee\\\",\\\"user\\\":\\\"jerome@strangebee.com\\\"},\\\"config\\\":{\\\"proxy_https\\\":null,\\\"cacerts\\\":null,\\\"check_tlp\\\":false,\\\"max_tlp\\\":2,\\\"check_pap\\\":false,\\\"max_pap\\\":2,\\\"jobTimeout\\\":30,\\\"proxy_http\\\":null}}\"}"
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
