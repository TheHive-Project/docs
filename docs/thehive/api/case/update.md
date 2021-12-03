# Update

Update a *Case*

## Query

```plain
PATCH /api/case/{id}
```


## Request Body Example

### Case details update

```json
{
    "severity":3,
    "tags": ["updated"]
}
```

### Case customFields update


To update specific *customFields*:

```json
{
    "customFields.business-unit.string": "VIP",
    "customFields.cvss.integer": 3
}
```

To patch *Case* *customFields*:

```json
  "customFields": {
      "business-unit": {
          "string": "VIP"
      }
  }
```

!!!DANGER
    *Case* *customFields* not mentionned in this request will be erased.


## Response

### Status codes

- `200`: *Case* has been updated successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    === "201" 

        ```json
        {
            "_id":"~311352",
            "id":"~311352",
            "createdBy":"analyst@soc",
            "updatedBy":"analyst@soc",
            "createdAt":1635879111239,
            "updatedAt":1637083041511,
            "_type":"case",
            "caseId":6,
            "title":"my first case",
            "description":"my first case description",
            "severity":3,
            "startDate":1635876967233,
            "endDate":null,
            "impactStatus":null,
            "resolutionStatus":null,
            "tags":["updated"],
            "flag":false,
            "tlp":2,
            "pap":2,
            "status":"Open",
            "summary":null,
            "owner":"analyst@soc",
            "customFields":{
                "business-unit":{
                    "string":"Sales",
                    "order":1
                },
                "cvss":{
                    "integer":9,
                    "order":0
                }
            },
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

