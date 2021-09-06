# List

List *Custom Fields*.

## Query

```plain
GET /api/customField
```


## Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error
- `403`: Authorization error

### ResponseBody Example

!!! Example ""

    === "200"

        ```json
        [
          {
            "id": "~28672",
            "name": "Number of Accounts",
            "reference": "Number of Accounts",
            "description": "Number of accounts leaked",
            "type": "integer",
            "options": [],
            "mandatory": true
          },
          {
            "id": "~53440",
            "name": "Nb of emails delivered",
            "reference": "Nb of emails delivered",
            "description": "Nb of emails delivered",
            "type": "integer",
            "options": [],
            "mandatory": true
          }
        ]
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