# Create

API to create a new TheHive organisation.

## Query

```plain
POST /api/v0/organisation
```

## Request

### Request Body

!!! Example

    ```json
    {
        "description": "SOC team",
        "name": "soc"
    }
    ```

### Fields

The following fields are required:

- `name`: (String)
- `description`: (String)

## Response

### Status codes

- `201`: if organisation creation completed successfully
- `401`: Authentication error

### Response Body

!!! Example

    ```json
    {
        "_id": "~204804296",
        "_type": "organisation",
        "createdAt": 1630385478884,
        "createdBy": "admin@thehive.local",
        "description": "SOC team",
        "id": "~204804296",
        "links": [],
        "name": "soc"
    }
    ```
