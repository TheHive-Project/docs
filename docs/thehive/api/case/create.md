# Create

Create a *Case*

## Query

```
POST /api/case
```

With mandatory fields:

- `title`: (String) title of the *Case*
- `description`: (String) description of the *Case*

## Request Body Example

### Basic request

```json
{
    "title": "my first case",
    "description": "my first case description"
}
```

### Request with more details, customFields and tasks

```json
{
    "title": "my first case",
    "description": "my first case description",
    "Severity": 3,
    "tlp": 2,
    "pap": 2,
    "startDate": 1635876967233,
    "tags": ["Test Tag", "Another Test Tag"],
    "flag": false,
    "owner": "username@org",
    "tasks": [{
        "title": "mytask",
        "description": "description of my task"
    }],
    "customFields":{
        "cvss": {
           "integer": 9
        },
        "businessUnit": {
            "string": "Sales"
        }
    }
}
```


## Response

### Status code

- `201`: if *Case* is created successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    === "201" 

        ```json
        {
            "_id":"~41644112",
            "id":"~41644112",
            "createdBy":"user@org",
            "updatedBy":null,
            "createdAt":1635876967235,
            "updatedAt":null,
            "_type":"case",
            "caseId":4,
            "title":"my first case",
            "description":"my first case description",
            "severity":2,
            "startDate":1635876967233,
            "endDate":null,
            "impactStatus":null,
            "resolutionStatus":null,
            "tags":[],
            "flag":false,
            "tlp":2,
            "pap":2,
            "status":"Open",
            "summary":null,
            "owner":"user@org",
            "customFields":{},
            "stats":{},
            "permissions":["manageShare","manageAnalyse","manageTask","manageCaseTemplate","manageCase","manageUser","manageProcedure","managePage","manageObservable","manageTag","manageConfig","manageAlert","accessTheHiveFS","manageAction"]
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