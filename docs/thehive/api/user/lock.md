# Lock / Unlock

Lock a *User*.

## Query

```plain
PATCH /api/v1/user/{id}
```

With:

- `id`: id or login of the user


##  Request Body Example

!!! Example "" 

    === "Lock" 

        ```json
        {
          "locked": true
        }
        ```

    === "Unlock"

        ```json
        {
          "locked": false
        }
        ```

The following fields are required: 

- `locked`: (Boolean)

##  Response 

### Status codes

- `204`: if *User* is locked successfully
- `401`: Authentication error
- `403`: Authorization error
