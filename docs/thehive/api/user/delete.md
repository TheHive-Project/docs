# Delete

Delete a *User*.

## Query

```plain
DELETE /api/v1/user/{id}/force?organisation={ORG_NAME}
```

with:

- `id`: id or login of the user
- `ORG_NAME`: the organisation name from which the user is to be removed

##  Response 

### Status codes

- `204`: if *User* is successfully deleted
- `401`: Authentication error
- `403`: Authorization error