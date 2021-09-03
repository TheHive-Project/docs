# Revoke API key

Revoke the API key of a user

## Query

```plain
DELETE /api/v1/user/{id}/key
```

with:

- `id`: id or login of the user

##  Response 

### Status codes

- `204`: if API key is successfully revoked
- `401`: Authentication error
- `403`: Authorization error