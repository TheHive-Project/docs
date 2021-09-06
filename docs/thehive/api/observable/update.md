# Update

Update a case or alert *Observable* by its id
## Query

```plain
PATCH /api/v0/case/artifact/{observableId}
```

```plain
PATCH /api/v0/alert/artifact/{observableId}
```

## Request Body Example

!!! Example ""

    ```json
    {
        "sighted": true,
        "ioc": true,
        "message": "This observable was sighted"
    }
    ```

Fields that can be updated:

- `ioc`
- `sighted`
- `ignoreSimilarity`
- `tags`
- `message`
- `tlp`

Once an observable is created, it is not possible to change its type or data

## Response Body Example

```json
{
  "_id": "~122884120",
  "id": "~122884120",
  "createdBy": "jerome@strangebee.com",
  "updatedBy": "lydia@strangebee.com",
  "createdAt": 1630509659446,
  "updatedAt": 1630511666911,
  "_type": "case_artifact",
  "dataType": "hostname",
  "data": "server.local",
  "startDate": 1630509659446,
  "tlp": 2,
  "tags": [],
  "ioc": true,
  "sighted": true,
  "message": "This observable was sighted",
  "reports": {},
  "stats": {}
}
```
