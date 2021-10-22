# Delete

Permanently delete a *Case*.

## Query

```plain
DELETE /api/case/{id}?force=1
```

With:

- `id`: id of the *Case*

## Response

### Status codes

- `204`: if *Case* is deleted successfully
- `401`: Authentication error
- `404`: if *Case* is not found
