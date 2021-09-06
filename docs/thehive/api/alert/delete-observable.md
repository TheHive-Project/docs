# Add observables

Delete an *Observable* from an *Alert*.

## Query

```plain
DELETE /api/alert/artifact/{id}
```

With:

- `id`: Observable identifier

## Response

### Status codes

- `204`: if *Observable* is deleted successfully
- `401`: Authentication error
