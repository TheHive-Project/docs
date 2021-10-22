# List related Cases

List similar *Cases* of a given *Case*. This API uses observable based similarity to find related *Cases*

## Query

```plain
GET /api/case/{id}/links
```

With:

- `id`: id of the *Case*

## Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error
- `404`: if the case doesn't exist

### ResponseBody Example

!!! Example ""

    ```json
      [
        {
            "_id": "~48144448",
            "_type": "case",
            "caseId": 66,
            "createdAt": 1618344529302,
            "createdBy": "user@thehive.local",
            "customFields": {},
            "description": "N/A",
            "endDate": null,
            "flag": false,
            "id": "~48144448",
            "impactStatus": null,
            "linkedWith": [
                {
                    "_id": "~122888216",
                    "_type": "case_artifact",
                    "createdAt": 1632114988895,
                    "createdBy": "user@strangebee.com",
                    "data": "google.com",
                    "dataType": "domain",
                    "id": "~122888216",
                    "ignoreSimilarity": false,
                    "ioc": false,
                    "message": "test",
                    "reports": {},
                    "sighted": false,
                    "startDate": 1632114988895,
                    "stats": {},
                    "tags": [],
                    "tlp": 2
                }
            ],
            "linksCount": 1,
            "owner": "nabil@thehive.local",
            "pap": 1,
            "permissions": [
                "manageShare",
                "manageAnalyse",
                "manageTask",
                "manageCaseTemplate",
                "manageCase",
                "manageUser",
                "manageProcedure",
                "managePage",
                "manageObservable",
                "manageTag",
                "manageConfig",
                "manageAlert",
                "accessTheHiveFS",
                "manageAction"
            ],
            "resolutionStatus": null,
            "severity": 4,
            "startDate": 1618344529000,
            "stats": {},
            "status": "Open",
            "summary": null,
            "tags": [
                "sample"
            ],
            "title": "Case a31acfad-8368-4395-bf1d-6d5c1675c0ba",
            "tlp": 1,
            "updatedAt": null,
            "updatedBy": null
        }
      ]
    ```