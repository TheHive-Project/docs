# Use count

Get *Custom Field* use count by id.

## Query

```plain
GET /api/customField/{id}/use
```

with: 

- `id`: id or name of the custom field.

## Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error
- `403`: Authorization error

### ResponseBody Example

!!! Example ""

    === "200"

        ```json
        {
          "case": 12,
          "alert": 1,
          "case_artifact": 9,
          "total": 22
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
          "message": "Your are not authorized to create custom field, you haven't the permission manageCustomField"
        }
        ```