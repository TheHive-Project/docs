# List

List *Task*s of a case.

## Query

```plain
POST /api/v0/query
```

##  Request Body Example

!!! Example ""

    List 15 waiting tasks in case ~25485360.

    ```json
    {
      "query": [
        {
          "_name": "getCase",
          "idOrName": "~25485360"
        },
        {
          "_name": "tasks"
        },
        {
          "_name": "filter",
          "status": "Waiting"
        },
        {
          "_name": "page",
          "from": 0,
          "to": 15
        }
      ]
    }
    ```

## Response

### Status codes

- `200`: if *Task* is updated successfully
- `401`: Authentication error

### ResponseBody Example

!!! Example ""

    === "201"

        ```json
        [
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
          },
          {
            "id": "~8360",
            "_id": "~8360",
            "createdBy": "jerome@strangebee.com",
            "updatedBy": "jerome@strangebee.com",
            "createdAt": 1630687291729,
            "updatedAt": 1630687323936,
            "_type": "case_task",
            "title": "Block malware URLs in proxy",
            "group": "containment",
            "description": "Add identified malicious URLs in proxy black list",
            "status": "Waiting",
            "flag": false,
            "order": 0
          }
        ```
    
    === "401" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Authentication failure"
        }
        ```
