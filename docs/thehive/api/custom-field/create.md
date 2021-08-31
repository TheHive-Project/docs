# Create

Create a *Custom Field*.

## Query

```plain
POST /api/customField
```


##  Request Body Example

!!! Example ""

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

!!! Example ""

    === "201" 

        ```json
        {
          "id": "~32912",
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
          ],
          "mandatory": false
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