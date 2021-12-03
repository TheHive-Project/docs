# List waiting tasks

List all waiting *Task*s.

## Query

```plain
POST /api/v0/query
```

##  Request Body Example

!!! Example ""

    List 15 waiting tasks, sorted by `flag` and `startDate`.

    ```json
    {
      "query": [
        {
          "_name": "waitingTasks"
        },
        {
          "_name": "sort",
          "_fields": [
              {
                "flag": "desc"
              },
              {
                "startDate": "desc"
              }
            ]
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

- `200`: if query is run successfully
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
            "status": "Waiting",
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
