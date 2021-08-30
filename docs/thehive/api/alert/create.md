# Create

Create an *Alert*.

## Query

```
POST /api/alert
```


## Example Request Body

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


## Example Response Body

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