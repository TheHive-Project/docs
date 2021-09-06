# List / Search

## Query

```plain
POST /api/v1/query
```

##  Request Body Example

!!! Example ""

    List last 30 observables for a case:

    ```json
    {
      "query": [
        {
          "_name": "getCase",
          "idOrName": "{caseId}"
        },
        {
          "_name": "observables"
        },
        {
          "_name": "sort",
          "_fields": [
            { "startDate": "desc"}
          ]
        },
        {
          "_name": "page",
          "from": 0,
          "to": 30
        }
      ]
    }
    ```

## Response Example

!!! Example ""

    ```json
    [
      {
        "_id": "~122884120",
        "_type": "Observable",
        "_createdBy": "foo@local.io",
        "_updatedBy": "foo@local.io",
        "_createdAt": 1630509659446,
        "_updatedAt": 1630511666911,
        "dataType": "hostname",
        "data": "server.local",
        "startDate": 1630509659446,
        "tlp": 2,
        "tags": [],
        "ioc": true,
        "sighted": false,
        "reports": {},
        "message": "myMessage",
        "extraData": {}
      },
      {
        "_id": "~4104",
        "_type": "Observable",
        "_createdBy": "foo@local.io",
        "_createdAt": 1630508511351,
        "dataType": "file",
        "startDate": 1630508511351,
        "attachment": {
          "_id": "~40964280",
          "_type": "Attachment",
          "_createdBy": "foo@local.io",
          "_createdAt": 1630508511313,
          "name": "server.log",
          "hashes": [
            "ccbda6ed6aac6cde57ebac1f011bdf1f58bf61c40c759dc4f7fccb729de10147",
            "a09531845b3b26d5707cdf50a8bb11aa507dd88c",
            "1f08c024363568d6eb4e18ee97618acc"
          ],
          "size": 37165,
          "contentType": "application/octet-stream",
          "id": "ccbda6ed6aac6cde57ebac1f011bdf1f58bf61c40c759dc4f7fccb729de10147"
        },
        "tlp": 2,
        "tags": [],
        "ioc": true,
        "sighted": false,
        "reports": {},
        "message": "foo",
        "extraData": {}
      }
    ]
    ```
