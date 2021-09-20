# Export Case to MISP

Export *Case* to a MISP server to create an event including the *Case* observables marked as IOC.

## Query

```plain
POST /api/connector/misp/export/{id}/{misp-server}
```

With:

- `id`: id of the *Case*
- `misp-server`: name of the MISP server as defined in the configuration

!!! note

    Only MISP servers with `purpose` equals to `ExportOnly` or `ImportAndExport` can recieve *Case* exports

## Response

### Status codes

- `204`: if *Case* is successfully exported
- `401`: Authentication error
- `404`: if *Case* or MISP server is not found.
