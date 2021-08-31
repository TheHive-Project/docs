# Get / List

List *Case Templates*.

## Query

```plain
POST /api/v1/query?name=organisation-case-templates
```

### Request Body Example

!!! Example ""

    ```json
    {
      "query": [
        {
          "_name": "getOrganisation",
          "idOrName": "{id}"
        },
        {
          "_name": "caseTemplates"
        },
        {
          "_name": "sort",
          "_fields": [
            {
              "displayName": "asc"
            }
          ]
        },
        {
          "_name": "page",
          "from": 0,
          "to": 15
        }
      ]
    }
    ```

    With:

    - `id`: Organisation identifier of Name

##  Response 

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    === "200"

        ```json
        [
          ...
          {
            "_id": "~910319824",
            "_type": "CaseTemplate",
            "_createdBy": "florian@strangebee.com",
            "_updatedBy": "florian@strangebee.com",
            "_createdAt": 1620297081745,
            "_updatedAt": 1620389292177,
            "name": "Phishing",
            "displayName": "Phishing",
            "titlePrefix": "Phishing -",
            "description": "Phishing attempt has succeed.",
            "severity": 2,
            "tags": [
              "category:Phishing"
            ],
            "flag": false,
            "tlp": 2,
            "pap": 2,
            "customFields": [],
            "tasks": [
              {
                "_id": "~677056528",
                "_type": "Task",
                "_createdBy": "florian@strangebee.com",
                "_createdAt": 1620389292172,
                "title": "Initial alert",
                "group": "default",
                "description": "-What happened?\n-When does it happened?\n-How did it happened?\n-How did we detected the anomaly/alert/incident?",
                "status": "Waiting",
                "flag": false,
                "order": 0,
                "extraData": {}
              },
              {
                "_id": "~677060624",
                "_type": "Task",
                "_createdBy": "florian@strangebee.com",
                "_createdAt": 1620389292173,
                "title": "Remediation",
                "group": "default",
                "description": "Explain here all the actions performed to contain and remediate the threat.",
                "status": "Waiting",
                "flag": false,
                "order": 3,
                "extraData": {}
              },
              {
                "_id": "~677064720",
                "_type": "Task",
                "_createdBy": "florian@strangebee.com",
                "_createdAt": 1620389292174,
                "title": "Lessons learnt",
                "group": "default",
                "description": "Write here the lessons learnt for the case.",
                "status": "Waiting",
                "flag": false,
                "order": 4,
                "extraData": {}
              },
              {
                "_id": "~706662512",
                "_type": "Task",
                "_createdBy": "florian@strangebee.com",
                "_createdAt": 1620389292171,
                "title": "Notification / Communication",
                "group": "default",
                "description": "Write here all the communications related to this case",
                "status": "Waiting",
                "flag": false,
                "order": 2,
                "extraData": {}
              },
              {
                "_id": "~789033176",
                "_type": "Task",
                "_createdBy": "florian@strangebee.com",
                "_createdAt": 1620389292174,
                "title": "Analysis",
                "group": "default",
                "description": "-Technical analysis of the incident\n-Current impact\n-Potential damages due to the incident\n-...",
                "status": "Waiting",
                "flag": false,
                "order": 1,
                "extraData": {}
              }
            ]
          }
        ...
        ]
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