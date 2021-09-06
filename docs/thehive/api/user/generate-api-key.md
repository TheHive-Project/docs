# Generate API key

Generate an API key for a user. 

## Query

```plain
POST /api/v1/user/{id}/key/renew
```

with: 

- `id`: id or login of the user

##  Request Body Example

The body is empty.

## Response

### Status codes

- `200`: if the API key have succesfully been generated
- `401`: Authentication error
- `403`: Authorization error

### ResponseBody Example

The key in plain text.

!!! Example ""

    ```plain
      BOXTE+Cq0qrZcHhTK4j0LpT/TVW5auOz
    ``` 