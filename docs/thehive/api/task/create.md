# Create

Create a *Task* (requires `manageTask` permission).

## Query

```plain
POST /api/case/{id}task
```

With:

- `id`: Case identifier

##  Request Body Example

!!! Example ""

    ```json
    {
      "title": "Malware analysis",
      "group": "identification",
      "description": "Analysis of the file to identify the malware",
      "owner": "jerome@strangebee.com",
      "status": "InProgress",
      "flag": false,
      "startDate": 1630683608000,
      "endDate": 1630684608000,
      "order": 3,
      "dueDate": 1630694608000
    }
    ```

The only required field is `title`.

The `status` can be `Waiting`, `InProgress`, `Completed` or `Cancel`.

## Response

### Status codes

- `201`: if *Tasks* is created successfully
- `401`: Authentication error
- `403`: Authorization error

### ResponseBody Example

!!! Example ""

    === "201" 

        ```json
        {
          "id": "~4264",
          "_id": "~4264",
          "createdBy": "jerome@strangebee.com",
          "createdAt": 1630684502715,
          "_type": "case_task",
          "title": "Malware analysis",
          "group": "identification",
          "description": "Analysis of the file to identify the malware",
          "owner": "jerome@strangebee.com",
          "status": "InProgress",
          "flag": false,
          "startDate": 1630683608000,
          "endDate": 1630684608000,
          "order": 3,
          "dueDate": 1630694608000
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
          "message": "Your are not authorized to create Task, you haven't the permission manageTask"
        }
        ```