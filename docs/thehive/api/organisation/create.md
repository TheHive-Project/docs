# Create

API to create a new TheHive organisation.

## Query

```plain
POST /api/v0/organisation
```

## Authorization

This API requires a super admin user with `manageOrganisation` permission

## Request

### Request Body Example

!!! Example ""

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
- `403`: Authorization error

### Response Body Example

!!! Example ""

    === "200"

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

    === "401" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Authentication failure"
        }
        ```

    === "403"

        ```json
        {
            "type": "AuthorizationError",
            "message": "Unauthorized action"
        }
        ```
