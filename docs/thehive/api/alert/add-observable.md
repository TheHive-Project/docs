# Add observables

Add *Observable* to an *Alert*.

## Query

```plain
POST /api/alert/{id}/artifact
```

With:

- `id`: Alert identifier

##  Request Body Example

!!! Example "" 
    
    ```json
    {
        "dataType":"ip",
        "ioc":True,
        "sighted":True,
        "ignoreSimilarity":False,
        "tlp":2,
        "message":"sample description",
        "tags":["test","Another Test Tag"],
        "data":["1.2.3.4"]
    }
    ```



## Response

### Status codes

- `201`: if *Alert* is created successfully
- `401`: Authentication error
- `403`: Authorization error

### ResponseBody Example


!!! Example ""

    === "201" 

        ```json
        [
            {
                "_id":"~1564784",
                "id":"~1564784",
                "createdBy":"analyst@soc",
                "createdAt":1637091448338,
                "_type":"case_artifact",
                "dataType":"ip",
                "data":"1.2.3.4",
                "startDate":1637091448338,
                "tlp":2,
                "tags":["test","Another Test Tag"],
                "ioc":true,
                "sighted":true,
                "message":"sample description",
                "reports":{},
                "stats":{},
                "ignoreSimilarity":false
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

    === "403"

        ```json
        {
            "type": "AuthorizationError",
            "message": "Your are not authorized to create custom field, you haven't the permission manageCustomField"
        }
        ```