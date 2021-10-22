# List

List *Task*s of a case.

## Query

```plain
GET /api/case/task/{id}
```

with: 

- `id`: id of the task.

## Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error
- `404`: The *Task* is not found

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

    === "404" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Task not found"
        }
        ```
