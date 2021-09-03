# Get / List

get *Custom Fields*.

## Query

```plain
GET /api/customField/{id}
```

with: 

- `id`: id or name of the custom field.

##  Response 

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    === "200"

        ```json
        {
          "id": "~28672",
          "name": "Number of Accounts",
          "reference": "Number of Accounts",
          "description": "Number of accounts leaked",
          "type": "integer",
          "options": [],
          "mandatory": true
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