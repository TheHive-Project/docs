# Mark as Read/Unread

Mark an *Alert* as read

## Query

### Mark as read

```plain
POST /api/alert/{id}/markAsRead
```

with:

- `id`: id of the Alert

### Mark as unread

```plain
POST /api/alert/{id}/markAsUnead
```

with:

- `id`: id of the Alert


##  Response 

### Status codes

- `200`: if *Alert* is updated successfully
- `401`: Authentication error

### Response Body Example

!!! Example ""

    ```json
    {
      "_id": "~911601872",
      "id": "~911601872",
      "createdBy": "florian@strangebee.com",
      "updatedBy": null,
      "createdAt": 1620333017135,
      "updatedAt": null,
      "_type": "alert",
      "type": "external",
      "source": "SIEM",
      "sourceRef": "8257b4",
      "externalLink": null,
      "case": null,
      "title": "User posted information on known phishing URL",
      "description": "SIEM automated alert: the user robb@training.org has posted information on a known phishing url",
      "severity": 2,
      "date": 1620333017000,
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
          "_id": "~624226312",
          "id": "~624226312",
          "createdBy": "florian@strangebee.com",
          "createdAt": 1620333017175,
          "_type": "case_artifact",
          "dataType": "mail",
          "data": "robb@training.org",
          "startDate": 1620333017175,
          "tlp": 2,
          "tags": [],
          "ioc": false,
          "sighted": false,
          "reports": {},
          "stats": {}
        },
        {
          "_id": "~788742360",
          "id": "~788742360",
          "createdBy": "florian@strangebee.com",
          "createdAt": 1620333017168,
          "_type": "case_artifact",
          "dataType": "url",
          "data": "https://moneyfornothing.pl-getbuys.icu/",
          "startDate": 1620333017168,
          "tlp": 2,
          "tags": [],
          "ioc": false,
          "sighted": false,
          "message": "http method: POST",
          "reports": {},
          "stats": {}
        },
        {
          "_id": "~870416536",
          "id": "~870416536",
          "createdBy": "florian@strangebee.com",
          "createdAt": 1620333017157,
          "_type": "case_artifact",
          "dataType": "ip",
          "data": "94.154.129.50",
          "startDate": 1620333017157,
          "tlp": 2,
          "tags": [],
          "ioc": false,
          "sighted": false,
          "reports": {},
          "stats": {}
        }
      ],
      "similarCases": []
    }
    ```