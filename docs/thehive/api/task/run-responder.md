# Run responder

Run a responder on a *Task* (requires `manageAction` permission).

## Query

```plain
POST /api/connector/cortex/action
```

##  Request Body Example

!!! Example ""

    ```json
    {
      "responderId": "25dcbbb69d50dd5a5ae4bd55f4ca5903",
      "cortexId": "local-cortex",
      "objectType": "case_task",
      "objectId": "~11123"
    }
    ```

The required fields are `responderId`, `objectType` and `objectId`.

##  Response 

### Status codes

- `201`: if responder is started successfully
- `401`: Authentication error
- `403`: Authorization error
- `404`: Task is not found

### Response Body Example

!!! Example ""

    === "201" 

        ```json
          {
            "responderId": "25dcbbb69d50dd5a5ae4bd55f4ca5903",
            "responderName": "reponderName_1_0",
            "responderDefinition": "reponderName_1_0",
            "cortexId": "local-cortex",
            "cortexJobId": "408-unsB3SwW9-eEPXXW",
            "objectType": "Task",
            "objectId": "~25313328",
            "status": "Waiting",
            "startDate": 1630917246993,
            "operations": "[]",
            "report": "{}"
          }
        ```

    === "401" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Authentication failure"
        }
        ```

    === "403"

        ```json
        {
          "type": "AuthorizationError",
          "message": "Your are not authorized to create action, you haven't the permission manageTask"
        }
        ```

    === "404" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Task not found"
        }
        ```
