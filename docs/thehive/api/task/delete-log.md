# Delete log

Delete a *Log* of an existing task (requires `manageTask` permission).

## Query

```plain
DELETE /api/case/task/log/{id}
```

With:

- `id`: Log identifier

##  Response 

### Status codes

- `204`: if *Log* is deleted successfully
- `401`: Authentication error
- `403`: Authorization error