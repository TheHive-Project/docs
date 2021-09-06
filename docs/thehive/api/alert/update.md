# Update

Update an *Alert*.

## Query

```plain
PATCH /api/alert/{id}
```

with:

- `id`: id of the Alert

##  Request Body Example

!!! Example "" 
    
    ```json
    {
      "description": "SIEM automated alert: the user robb@training.org has posted information on a known phishing url. "
    }
    ```

## Response

### Status codes

- `200`: if *Alert* is updated successfully
- `401`: Authentication error

### ResponseBody Example

!!! Example ""

    ```json
      {
        "_id": "~624443400",
        "id": "~624443400",
        "createdBy": "florian@strangebee.com",
        "updatedBy": null,
        "createdAt": 1620373264377,
        "updatedAt": null,
        "_type": "alert",
        "type": "external",
        "source": "SIEM",
        "sourceRef": "47e379",
        "externalLink": null,
        "case": null,
        "title": "User posted information on known phishing URL",
        "description": "SIEM automated alert: the user robb@training.org has posted information on a known phishing url. ",
        "severity": 2,
        "date": 1620373264000,
        "tags": [
          "source:siem",
          "log-source:proxy"
        ],
        "tlp": 3,
        "pap": 2,
        "status": "Ignored",
        "follow": true,
        "customFields": {
          "businessUnit": {
            "string": "Finance"
          },
          "location": {
            "string": "Sydney"
          }
        },
        "caseTemplate": null,
        "artifacts": [
          {
            "_id": "~665772152",
            "id": "~665772152",
            "createdBy": "florian@strangebee.com",
            "createdAt": 1620373264410,
            "_type": "case_artifact",
            "dataType": "username",
            "data": "robb@training.org",
            "startDate": 1620373264410,
            "tlp": 2,
            "tags": [],
            "ioc": false,
            "sighted": false,
            "reports": {},
            "stats": {}
          },
          {
            "_id": "~677015568",
            "id": "~677015568",
            "createdBy": "florian@strangebee.com",
            "createdAt": 1620373264398,
            "_type": "case_artifact",
            "dataType": "domain",
            "data": "pl-getbuys.icu",
            "startDate": 1620373264398,
            "tlp": 2,
            "tags": [],
            "ioc": false,
            "sighted": false,
            "reports": {},
            "stats": {}
          },
          {
            "_id": "~677019664",
            "id": "~677019664",
            "createdBy": "florian@strangebee.com",
            "createdAt": 1620373264405,
            "_type": "case_artifact",
            "dataType": "mail",
            "data": "robb@training.org",
            "startDate": 1620373264405,
            "tlp": 2,
            "tags": [],
            "ioc": false,
            "sighted": false,
            "reports": {},
            "stats": {}
          },
          {
            "_id": "~706650224",
            "id": "~706650224",
            "createdBy": "florian@strangebee.com",
            "createdAt": 1620373264391,
            "_type": "case_artifact",
            "dataType": "url",
            "data": "https://poczta.pl-getbuys.icu/",
            "startDate": 1620373264391,
            "tlp": 2,
            "tags": [],
            "ioc": false,
            "sighted": false,
            "message": "http method: POST",
            "reports": {},
            "stats": {}
          }
        ],
        "similarCases": []
      }
    ```