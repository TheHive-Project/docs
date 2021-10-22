# Set password

Set a *User*'s password.

The user making the query needs to be an admin of the platform

## Query

```plain
POST /api/v1/user/{id}/password/set
```

with:

- `id`: id of the user

##  Request Body Example

!!! Example ""

    ```json
    {
      "password": "thehive1234"
    }
    ```

The following fields are required:

- `password`: (String)

##  Response

### Status codes

- `204`: if password is set successfully
- `401`: Authentication error
- `403`: Authorization error
