# Create

Create an *Alert*.

## Query

```plain
POST /api/alert
```


##  Request Body Example

```json
{
    "artifacts": [],
    "description": "Imported from MISP Event #1311.",
    "severity": 0,
    "source": "misp server",
    "sourceRef": "1311",
    "tags": [
        "tlp:white",
        "type:OSINT"
    ],
    "title": "CISA.gov - AA21-062A Mitigate Microsoft Exchange Server Vulnerabilities",
    "tlp": 0,
    "type": "MISP Event"
}
```

The following fields are required: 

- `title`: (String)
- `source`: (String)
- `sourceRef`:  (String)
- `type`:  (String)

##  Response 

### Status codes

- `201`: if *Alert* is created successfully
- `401`: Authentication error

### Response Body Example

```json
{
    "_id": "~987889880",
    "id": "~987889880",
    "createdBy": "jerome@strangebee.com",
    "updatedBy": null,
    "createdAt": 1630323713949,
    "updatedAt": null,
    "_type": "alert",
    "type": "misp event",
    "source": "misp server",
    "sourceRef": "1311-2",
    "externalLink": null,
    "case": null,
    "title": "CISA.gov - AA21-062A Mitigate Microsoft Exchange Server Vulnerabilities",
    "description": "Imported from MISP Event #1311.",
    "severity": 0,
    "date": 1630323713937,
    "tags": [
        "tlp:pwhite",
        "type:OSINT",
    ],
    "tlp": 0,
    "pap": 2,
    "status": "New",
    "follow": true,
    "customFields": {},
    "caseTemplate": null,
    "artifacts": [],
    "similarCases": []
}
```