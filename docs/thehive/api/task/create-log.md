# Add log

Add a *Log* to an existing task (requires `manageTask` permission).

## Query

```plain
POST /api/case/task/{id}/log
```

With:

- `id`: Task identifier

##  Request Body Example

!!! Example ""

    ```json
    {
      "message": "The sandbox hasn't detected any suspicious activity",
      "startDate": 1630683608000,
    }
    ```

The only required field is `message`.


If you want to attach a file to the log, you need to use a multipart request

!!! Example ""


    ```
    curl -XPOST http://THEHIVE/api/v0/case/task/{taskId}/log -F attachment=@report.pdf -F _json='
    {
        "message": "The sandbox report"
    }
    '
    ```

##  Response 

### Status codes

- `201`: if *Log* is created successfully
- `401`: Authentication error
- `403`: Authorization error

### Response Body Example

!!! Example ""

    === "201" 

        ```json
        {
          "id": "~4264",
          "_id": "~4264",
          "createdBy": "jerome@strangebee.com",
          "createdAt": 1630684502715,
          "_type": "case_taskçlog",
          "message": "The sandbox hasn't detected any suspicious activity",
          "startDate": 1630683608000
        }
        ```

    === "401" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Authentication failure"
        }
        ```

    === "403"

        ```json
        {
          "type": "AuthorizationError",
          "message": "Your are not authorized to create Log, you haven't the permission manageTask"
        }
        ```