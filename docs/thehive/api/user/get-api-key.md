# Get API key

Get the API key of a user. 

## Query

```plain
GET /api/v1/user/{id}/key
```

with: 

- `id`: id or login of the user

##  Response 

### Status codes

- `200`: if the API key have succesfully been generated
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    ```plain
      BOXTE+Cq0qrZcHhTK4j0LpT/TVW5auOz
    ``` 