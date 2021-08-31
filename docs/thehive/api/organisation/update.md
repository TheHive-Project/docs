# Update

## Query

```plain
PATCH /api/v0/organisation/{id}
```

with:

- `id`: id or name of the organisation.

## Authorization

This API requires a super admin user with `manageOrganisation` permission


## Request Body Example

!!! Example ""

    ```json
    {
        "description": "SOC level 1 team",
        "name": "soc-level1"
    }
    ```

## Fields

The following fields are editable:

- `name` (String)
- `description` (String)

## Response

- `204`: if the organisation is updated successfully
- `401`: Authentication error
- `403`: Authorization error