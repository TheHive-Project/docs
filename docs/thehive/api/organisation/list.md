# List/Search

List *Organisations*.

## Query

```plain
GET /api/v0/query
```

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


## Response

### Status codes

- `200`: if query is run successfully
- `401`: Authentication error

### ResponseBody Example

!!! Example ""

    === "200"

        ```json
        [
            {
                "_createdAt": 1630385478884,
                "_createdBy": "admin@thehive.local",
                "_id": "~204804296",
                "_type": "Organisation",
                "_updatedAt": 1630415216098,
                "_updatedBy": "admin@thehive.local",
                "description": "SOC level",
                "links": [
                    "cert"
                ],
                "name": "soc-level1"
            },
            {
                "_createdAt": 1606467059596,
                "_createdBy": "admin@thehive.local",
                "_id": "~4144",
                "_type": "Organisation",
                "description": "CERT",
                "links": [
                    "soc-level1"
                ],
                "name": "cert"
            },
            {
                "_createdAt": 1606464802479,
                "_createdBy": "system@thehive.local",
                "_id": "~8408",
                "_type": "Organisation",
                "description": "organisation for administration",
                "links": [],
                "name": "admin"
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