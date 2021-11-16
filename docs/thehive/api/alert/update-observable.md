# Update observable

update an *Alert* *Observable*.

## Query

```plain
PATCH /api/alert/artifact/{id}
```

With:

- `id`: Alert identifier

Updatable fields are: `tlp`, `ioc`, `sighted`, `tags`, `message`, `ignoreSimilarity`

##  Request Body Example

!!! Example "" 
    
    ```json
    {
        "ioc": True,
        "tags":["malicious"]
    }
    ```



## Response

### Status codes

- `200`: if *Alert* *observable* is updated successfully
- `401`: Authentication error
- `403`: Authorization error

### ResponseBody Example


!!! Example ""

    === "200" 

        ```json
        {
            "_id":"~1564784",
            "id":"~1564784",
            "createdBy":"analyst@soc",
            "updatedBy":"analyst@soc",
            "createdAt":1637091448338,
            "updatedAt":1637092980667,
            "_type":"case_artifact",
            "dataType":"ip",
            "data":"1.2.3.4",
            "startDate":1637091448338,
            "tlp":2,
            "tags":["malicious"],
            "ioc":true,
            "sighted":true,
            "message":"sample description",
            "reports":{},
            "stats":{},
            "ignoreSimilarity":false
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
            "message": "Your are not authorized to create custom field, you haven't the permission manageCustomField"
        }
        ```