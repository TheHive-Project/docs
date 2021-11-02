# Create

Create a case

## Query

```
POST /api/case
```

With:

- `title`: title of the *Case*
- `description`: description of the *Case*

## Request Body Example

```json
{
    "title": "my first case",
    "description": "my first case description"
}
```


## Response Body Example

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
    "permissions":["manageShare","manageAnalyse","manageTask","manageCaseTemplate","manageCase","manageUser","manageProcedure","managePage","manageObservable","manageTag","manageConfig","manageAlert","accessTheHiveFS","manageAction"]}
```

## Request Body Example with optional Details, CustomFields and Tasks

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