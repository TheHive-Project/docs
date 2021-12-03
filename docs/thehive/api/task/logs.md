# List task logs

List *Task log*s of a *Case*.

## Query

```plain
POST /api/v1/query?name=case-task-logs
```

##  Request Body Example

!!! Example ""
    ```json
    {
        "query":[{
            "_name":"getTask",
            "idOrName":"id"
        },
        {
            "_name":"logs"
        },
        {
            "_name":"sort",
            "_fields":[{
                "date":"desc"
                }]
        },
        {
            "_name":"page",
            "from":0,
            "to":10,
            "extraData":["actionCount"]
        }]
    }
    ```

## Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error

### ResponseBody Example

!!! Example ""

    === "200"

        ```json
        [
            {
                "_id":"~1421384",
                "_type":"Log",
                "_createdBy":"analyst@soc",
                "_createdAt":1637090593968,
                "message":"42",
                "date":1637090593968,
                "owner":"analyst@soc",
                "extraData":{"actionCount":0}
            },
            {
                "_id":"~1429680",
                "_type":"Log",
                "_createdBy":"analyst@soc",
                "_createdAt":1637090578809,
                "message":"test sample",
                "date":1637090578809,
                "owner":"analyst@soc",
                "extraData":{"actionCount":0}
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
