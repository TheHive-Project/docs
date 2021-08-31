# Merge

Merge an *Alert* into an existing *Case*.

## Query

```plain
POST /api/alert/{id1}/merge/{id2}
```

With:

- `id1`: id of the *Alert* to merge
- `id2`: id of the destination *Case*

##  Response 

### Status codes

- `200`: if *Alert* is successfully merged
- `401`: Authentication error

### Response Body Example

!!! Example ""

    ```json
    {
      "_id": "~6658533455",
      "id": "~6658533455",
      "createdBy": "florian@strangebee.com",
      "updatedBy": "florian@strangebee.com",
      "createdAt": 1620397519028,
      "updatedAt": 1624373852175,
      "_type": "case",
      "caseId": 114,
      "title": "User connected to known malicious IP over Telnet / Malicious payload detected",
      "description": "EDR automated alert: the user robb@training.org has connected to known malicious IP over Telnet\n\nEDR automated alert: malicious payload detected on computer PC-Robb\n  \n#### Merged with alert #90e044 User posted information on known phishing URL\n\nSIEM automated alert: the user robb@training.org has posted information on a known phishing url",
      "severity": 2,
      "startDate": 1620396059728,
      "endDate": null,
      "impactStatus": null,
      "resolutionStatus": null,
      "tags": [
        "log-source:proxy",
        "source:edr",
        "log-source:endpoint-protection",
        "source:siem",
        "protocol: telnet",
        "ex2"
      ],
      "flag": false,
      "tlp": 3,
      "pap": 2,
      "status": "Open",
      "summary": null,
      "owner": "florian@strangebee.com",
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