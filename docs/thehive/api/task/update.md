# Update

Update a *Task* (requires `manageTask` permission).

## Query

```plain
PATCH /api/case/task/{id}
```

with: 

- `id`: id of the task.


## Request Body Example

!!! Example ""

    ```json
    {
      "title": "Block malware URLs in proxy",
      "group": "containment",
      "description": "Add identified malicious URLs in proxy black list",
      "owner": "jerome@strangebee.com",
      "status": "Waiting",
      "flag": false,
      "startDate": 1630683608000,
      "endDate": 1630684608000,
      "order": 5,
      "dueDate": 1630694608000
    }
    ```

No fields are required.

## Response

### Status codes

- `200`: if *Task* is updated successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    === "201"

        ```json
        {
          "id": "~4264",
          "_id": "~4264",
          "createdBy": "jerome@strangebee.com",
          "createdAt": 1630684502715,
          "updatedBy": "jerome@strangebee.com",
          "updatedAt": 1630685486000,
          "_type": "case_task",
          "title": "Block malware URLs in proxy",
          "group": "containment",
          "description": "Add identified malicious URLs in proxy black list",
          "owner": "jerome@strangebee.com",
          "status": "Waiting",
          "flag": false,
          "startDate": 1630683608000,
          "endDate": 1630684608000,
          "order": 5,
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
          "message": "Your are not authorized to update Task, you haven't the permission manageTask"
        }
        ```