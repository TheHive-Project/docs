# Update links

Link *orgnisation* to one or many other organisations. It sets the list of organisation link to the list provided as input. It overrides the existing list of links.

## Query

```plain
PUT /api/v0/organisation/{idOrName}/links
```

with:

- `idOrName` id or name of the organisation

## Request


### Request Body Example

!!! Example ""
  ```json
  {
      "organisations": [
          "cert", "csirt"
      ]
  }
  ```

### Fields

- `organisations` (*required*): Array of organisation names

## Response

### Status codes

- `201` if the operation completed successfully