# Update

Update a *Custom Field*.

## Query

```plain
PATCH api/customField/{id}
```

with: 
`id`: id of the custom field.


## Request Body Example

```json
{
    "name": "Business Unit",
    "reference": "businessUnit",
    "description": "Targetted business unit",
    "type": "string",
    "options": [
        "Sales",
        "Marketing",
        "VIP",
        "Security",
        "Sys admins",
        "HR",
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


## Response

### Status codes

- `201`: if *Custom Fields* is created successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example


```json
{
  "id": "~32912",
  "name": "Business Unit",
  "reference": "businessUnit",
  "description": "Targetted business unit",
  "type": "string",
  "options": [
    "HR",
    "Legal",
    "Marketing",
    "Procurement",
    "Sales",
    "Security",
    "Sys admins",
    "VIP"
  ],
  "mandatory": false
}
```