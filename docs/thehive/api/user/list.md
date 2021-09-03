# List

List users.


## Query

```plain
POST /api/v1/query
```


##  Request Body Example

!!! Example ""

    List last 15 users created.

    ```json
    {
      "query": [
        {
          "_name": "getOrganisation",
          "idOrName": "StrangeBee"
        },
        {
          "_name": "users"
        },
        {
          "_name": "page",
          "from": 0,
          "to": 15,
          "organisation": "StrangeBee"
        }
      ]
    }
    ```

##  Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    ```json
    [
      {
        "_id": "~947527808",
        "_createdBy": "admin@thehive.local",
        "_createdAt": 1630411433091,
        "login": "jerome@strangebee.com",
        "name": "Jerome",
        "hasKey": false,
        "hasPassword": false,
        "hasMFA": false,
        "locked": false,
        "profile": "analyst",
        "permissions": [
          "manageShare",
          "manageAnalyse",
          "manageTask",
          "manageCase",
          "manageProcedure",
          "managePage",
          "manageObservable",
          "manageAlert",
          "accessTheHiveFS",
          "manageAction"
        ],
        "organisation": "StrangeBee",
        "organisations": []
      }
    ]
    ```