# Update

Update a *Case Template* by its id.

## Query

```plain
PATCH /api/case/template/{id}
```

## Request Body Example

!!! Example

    ```json
    {
        "displayName": "New Display name",
        "tlp": 4,
        "tasks": [
            {
                "order": 0,
                "title": "Search for IOCs on Mail gateway logs",
                "group": "default",
                "description": "Run queries in Mail gateway logs and look for IOcs of type IP, email addresses, hostnames, free text. "
            }
        ]
    }
    ```

Fields that can be updated:

- `name`
- `displayName`
- `titlePrefix`
- `description`
- `severity`
- `tags`
- `flag`
- `tlp`
- `pap`
- `summary`
- `customFields`
- `tasks`

## Response Body Example

!!! Example

    ```json
    {
        "_id": "~910319824",
        "id": "~910319824",
        "createdBy": "florian@strangebee.com",
        "createdAt": 1630675267739,
        "_type": "caseTemplate",
        "name": "MISPEvent",
        "displayName": "New Display name",
        "titlePrefix": "[MISP]",
        "description": "Check if IOCs shared by the community have been seen on the network",
        "severity": 2,
        "tags": [
            "hunting"
        ],
        "flag": false,
        "tlp": 2,
        "pap": 2,
        "tasks": [
            {
                "id": "~122896536",
                "_id": "~122896536",
                "createdBy": "florian@strangebee.com",
                "createdAt": 1630675267741,
                "_type": "case_task",
                "title": "Search for IOCs on Mail gateway logs",
                "group": "default",
                "description": "Run queries in Mail gateway logs and look for IOcs of type IP, email addresses, hostnames, free text. ",
                "status": "Waiting",
                "flag": false,
                "order": 0
            }
        ],
        "status": "Ok",
        "customFields": {
        "hits": {
            "integer": null,
            "order": 1,
            "_id": "~122900632"
        }
        },
        "metrics": {}
    }
    ```
