# Create

Create a *User*.

## Query

```plain
POST /api/v1/user
```


##  Request Body Example

!!! Example "" 
    
    ```json
    {
      "login" : "jerome@strangebee.com",
      "name" : "Jerome",
      "organisation": "StrangeBee",
      "profile": "org-admin"
    }
    ```

The following fields are required: 

- `login`: (String - email address)
- `name`: (String)
- `organisation`:  (String)
- `profile`:  [admin|org-admin|analyst|read-only|any customed profile]

##  Response 

### Status codes

- `201`: if *User* is created successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    ```json
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
    ```