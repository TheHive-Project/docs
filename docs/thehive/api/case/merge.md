# Merge

Merge two *Cases* in a single *Case*. This APIs permanently removes the source *Cases* and creates a *Case* by merging all the data from the sources.

## Query

```plain
POST /api/v0/case/{id1}/_merge/{id2}
```

with:

- `id1`: id of the first *Case*
- `id2`: id of the second *Case*

## Response

### Status codes

- `204`: if the *Cases* are merged successfully
- `401`: Authentication error
- `404`: if at least one of the *Cases* is not found

### Response Body Example

```json
  {
    "_id": "~81928240",
    "id": "~81928240",
    "createdBy": "user@thehive.local",
    "updatedBy": null,
    "createdAt": 1632132365250,
    "updatedAt": null,
    "_type": "case",
    "caseId": 87,
    "title": "Case 1 / Case 2",
    "description": "test\n\ntest",
    "severity": 2,
    "startDate": 1632124020000,
    "endDate": null,
    "impactStatus": null,
    "resolutionStatus": null,
    "tags": [],
    "flag": false,
    "tlp": 2,
    "pap": 2,
    "status": "Open",
    "summary": null,
    "owner": "user@thehive.local",
    "customFields": {},
    "stats": {},
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
    ]
  }
```
