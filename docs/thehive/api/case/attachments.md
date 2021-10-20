# List related Alerts

List attachments added to task logs of a *Case*.

## Query

```plain
POST /api/v0/query
```

##  Request Body Example

!!! Example "" 
    
    List attachments added to task logs or a *Case* identified by `{id}`:

    ```json
      {
          "query": [
              {
                  "_name": "getCase",
                  "idOrName": "{id}"
              },
              {
                  "_name": "tasks"
              },
              {
                  "_name": "filter",
                  "_ne": {
                      "_field": "status",
                      "_value": "Cancel"
                  }
              },
              {
                  "_name": "logs"
              },
              {
                  "_contains": "attachment.id",
                  "_name": "filter"
              },
              {
                  "_name": "page",
                  "extraData": [
                      "taskId"
                  ],
                  "from": 0,
                  "to": 100
              }
          ]
      }
    ```

With:

- `id`: id of the *Case*

## Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error
- `404`: if the *Case* is not found

### Response Body Example

!!! Example ""

    ```json
      [
          ...
          {
            "_id": "~122892472",
            "id": "~122892472",
            "createdBy": "user@thehive.local",
            "createdAt": 1632124353194,
            "_type": "case_task_log",
            "message": "message",
            "startDate": 1632124353194,
            "attachment": {
              "name": "filename.png",
              "hashes": [
                "0b62003cb73578d9e738a70aa7a81e89d3683282ac393856a96ef364cd1038cb",
                "caa75ff1e33ee8bfba764c9a6139fb72e7f4e20a",
                "a3e41c32ff817fc759bafeb1a106a433"
              ],
              "size": 42213,
              "contentType": "image/png",
              "id": "0b62003cb73578d9e738a70aa7a81e89d3683282ac393856a96ef364cd1038cb"
            },
            "status": "Ok",
            "owner": "user@thehive.local"
          }
          ...
      ]
    ```
