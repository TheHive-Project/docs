# List/Search

List *Organisations*.

## Query

```plain
GET /api/v0/query
```

## Authorisation



## Request

This is a Query API call, where:

- `listOrganisation` is the query name

!!! Example ""

  ```json
    {
      "query": [
          {
              "_name": "listOrganisation"
          },
          {
              "_fields": [
                  {
                      "updatedAt": "desc"
                  }
              ],
              "_name": "sort"
          },
          {
              "_name": "page",
              "from": 0,
              "to": 15
          }
      ]
  }
  ```


##  Response 

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error

### Response Body Example

!!! Example ""

    === "200"

        ```json
        [
          {
            "name": "soc-level1",
            "description": "SOC level1",
            "_id": "~204804296",
            "id": "~204804296",
            "createdAt": 1630385478884,
            "createdBy": "admin@thehive.local",
            "updatedAt": 1630415216098,
            "updatedBy": "admin@thehive.local",
            "_type": "organisation",
            "links": []
          },
          {
            "name": "cert",
            "description": "CERT",
            "_id": "~4144",
            "id": "~4144",
            "createdAt": 1606467059596,
            "createdBy": "admin@thehive.local",
            "_type": "organisation",
            "links": []
          },
          {
            "name": "admin",
            "description": "organisation for administration",
            "_id": "~8408",
            "id": "~8408",
            "createdAt": 1606464802479,
            "createdBy": "system@thehive.local",
            "_type": "organisation",
            "links": []
          }
        ]
        ```

    === "401" 

        ```json
        {
          "type": "AuthenticationError",
          "message": "Authentication failure"
        }
        ```