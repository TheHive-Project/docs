# Promote

Promote an *Alert* as a new *Case*.

## Query

```plain
POST /api/alert/{id}/createCase
```

With:

- `id`: id of the *Alert* to promote

## Request Body example

Specify a *Case template* applied with *Case* creation:

!!! Example "" 

    ```json
    {
      "caseTemplate": "SIEM_Alert"
    }
    ```

The following fields are optional: 

- `caseTemplate`: (String)

## Response

### Status codes

- `201`: if *Case* is successfully created
- `401`: Authentication error

### ResponseBody Example

!!! Example ""

    ```json
    {
      "_id": "~907709843",
      "id": "~907709843",
      "createdBy": "jerome@strangebee.com",
      "updatedBy": null,
      "createdAt": 1630416621805,
      "updatedAt": null,
      "_type": "case",
      "caseId": 126,
      "title": "User posted information on known phishing URL",
      "description": "SIEM automated alert: the user robb@training.org has posted information on a known phishing url. ",
      "severity": 2,
      "startDate": 1630416621797,
      "endDate": null,
      "impactStatus": null,
      "resolutionStatus": null,
      "tags": [
        "source:siem",
        "log-source:proxy"
      ],
      "flag": false,
      "tlp": 3,
      "pap": 2,
      "status": "Open",
      "summary": null,
      "owner": "jerome@strangebee.com",
      "customFields": {
        "businessUnit": {
          "string": "Finance",
          "order": 0
        },
        "location": {
          "string": "Sydney",
          "order": 1
        }
      },
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