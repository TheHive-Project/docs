# List related Alerts

List alerts merged in a *Case*.

## Query

```plain
POST /api/v0/query
```

##  Request Body Example

!!! Example "" 
    
    List last 5 merged alerts in a *Case* identified by `{id}`:

    ```json
    {
      "query": [
        {
          "_name": "getCase",
          "idOrName": "{id}"
        },
        {
          "_name": "alerts"
        },
        {
          "_name": "sort",
          "_fields": [
            {
              "startDate": "desc"
            }
          ]
        },
        {
          "_name": "page",
          "from": 0,
          "to": 5
        }
      ]
    }
    ```

    With:

    - `id`: id of the *Case*

## Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error

### ResponseBody Example

!!! Example ""

    ```json
    [
      ...
      [
        {
          "_id": "~43618512",
          "id": "~43618512",
          "createdBy": "demo@thehive.local",
          "updatedBy": null,
          "createdAt": 1618344277475,
          "updatedAt": null,
          "_type": "alert",
          "type": "testing",
          "source": "create-alert.py",
          "sourceRef": "85a766ec",
          "externalLink": null,
          "case": "~122884120",
          "title": "Alert 85a766ec-060a-49a0-bc82-c672b6e51e6c",
          "description": "N/A",
          "severity": 1,
          "date": 1618344277000,
          "tags": [
            "sample"
          ],
          "tlp": 3,
          "pap": 2,
          "status": "Imported",
          "follow": true,
          "customFields": {
            "company": {
              "string": "Customer 1"
            }
          },
          "caseTemplate": null,
          "artifacts": [],
          "similarCases": []
        }
      ]
      ...
    ]
    ```