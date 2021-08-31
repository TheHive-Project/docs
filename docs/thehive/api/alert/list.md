# List / Search

List *Alerts*.

## Query

```plain
POST /api/v1/query?name=alerts
```

##  Request Body Example

!!! Example "" 
    
    List last 15 alerts:

    ```json
    {
      "query": [
        {
          "_name": "listAlert"
        },
        {
          "_name": "filter",
          "_field": "imported",
          "_value": false
        },
        {
          "_name": "sort",
          "_fields": [
            {
              "date": "desc"
            }
          ]
        },
        {
          "_name": "page",
          "from": 0,
          "to": 15,
          "extraData": [
            "importDate",
            "caseNumber"
          ]
        }
      ]
    }
    ```

##  Response 

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error

### Response Body Example

!!! Example ""

    ```json
    [
      ...
      {
        "_id": "~789196976",
        "_type": "Alert",
        "_createdBy": "florian@strangebee.com",
        "_createdAt": 1620393156944,
        "type": "external",
        "source": "MISP server",
        "sourceRef": "event_1576",
        "title": "Phishing list update 7.5.2021",
        "description": "A curated list of phishing IOCs",
        "severity": 2,
        "date": 1620393156000,
        "tags": [
          "source:MISP",
          "origin:CIRCL_LU"
        ],
        "tlp": 3,
        "pap": 2,
        "read": false,
        "follow": true,
        "customFields": [],
        "observableCount": 16,
        "extraData": {
          "importDate": null,
          "caseNumber": null
        }
      },
    ...
    ]
    ```