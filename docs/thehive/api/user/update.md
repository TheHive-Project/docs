# Update

Update *User*'s information.

## Query

```plain
PATCH /api/v1/user/{id}
```

With:

- `id`: id of the user


##  Request Body Example

!!! Example "" 
    
    ```json
    {
      "name": "Jerome",
      "profile": "org-admin",
      "organisation": "StrangeBee"
    }
    ```

The following fields are required: 

- `name`: (String)
- `organisation`:  (String)
- `profile`:  [admin|org-admin|analyst|read-only|any customed profile]

##  Response 

### Status codes

- `204`: if *User* is updated successfully
- `401`: Authentication error
- `403`: Authorization error
