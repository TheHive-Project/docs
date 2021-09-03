# Update

Update *User*'s information.

## Query

```plain
PATCH /api/v1/user/{id}
```

With:

- `id`: id or login of the user


##  Request Body Example

!!! Example "" 
    
    ```json
    {
      "name": "Jerome",
      "profile": "org-admin",
      "organisation": "StrangeBee",
      "locked": false
    }
    ```

The field `organisation` is used if the profile is updated (the profile of an user depends on the organisation). If not specified, the current organisation is  used.
No fields are required.

##  Response 

### Status codes

- `204`: if *User* is updated successfully
- `401`: Authentication error
- `403`: Authorization error
