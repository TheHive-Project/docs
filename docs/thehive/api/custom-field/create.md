# Create

Create an *Custom Field*.

## Query

```plain
POST /api/customField
```


##  Request Body Example

```json
{
  "name": "BusinesUnit",
  "reference": "businessunit",
  "description": "Targeted business unit",
  "type": "string",
  "mandatory": false,
  "options": [
    "VIP",
    "HR",
    "Security",
    "Sys Administrators",
    "Developers",
    "Sales",
    "Marketing",
    "Procurement",
    "Legal"
  ]
}
```

The following fields are required: 

- `name`: (String)
- `reference`: (String)
- `description`: (String)
- `type`: [string|integer|boolean|date|float]

##  Response 

### Status codes

- `201`: if *Custom Fields* is created successfully
- `401`: Authentication error
- `403`: Authorization error

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