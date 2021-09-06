# Delete

Delete a *Custom Field* (requires `manageCustomField` permission).

## Query

```plain
DELETE /api/customField/{id}
```

with:

- `id`: id or name of the Custom Field.

## Response

### Status codes

- `204`: if *Custom Fields* is successfully deleted
- `401`: Authentication error
- `403`: Authorization error
