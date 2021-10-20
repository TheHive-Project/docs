# Create

Create a *Case Templates*.

## Query

```plain
POST /api/case/template
```

### Request Body Example

!!! Example ""

    ```json
    {
      "name": "MISPEvent",
      "titlePrefix": "",
      "severity": 2,
      "tlp": 2,
      "pap": 2,
      "tags": [
        "hunting"
      ],
      "tasks": [
        {
          "order": 0,
          "title": "Search for IOCs on Mail gateway logs",
          "group": "default",
          "description": "Run queries in Mail gateway logs and look for IOcs of type IP, email addresses, hostnames, free text. "
        },
        {
          "order": 1,
          "title": "Search for IOCs on Firewall logs",
          "group": "default",
          "description": "Run queries in firewall logs and look for IOcs of type IP, port"
        },
        {
          "order": 2,
          "title": "Search for IOCs on Web proxy logs",
          "group": "default",
          "description": "Run queries in web proxy logs and look for IOcs of type IP, domain, hostname, user-agent"
        }
      ],
      "customFields": {
        "hits": {
          "integer": null,
          "order": 1
        }
      },
      "description": "Check if IOCs shared by the community have been seen on the network",
      "displayName": "MISP"
    }
    ```

`name` should be unique. Otherwise an error `400 Bad Request` is returned

##  Response

### Status codes

- `201`: if template was created successfully
- `400`: in case of error in input
- `401`: Authentication error
- `403`: Authorization error

### ResponseBody Example

!!! Example ""

    === "201"

        ```json
        {
          "_id": "~910319824",
          "id": "~910319824",
          "createdBy": "florian@strangebee.com",
          "createdAt": 1630675267739,
          "_type": "caseTemplate",
          "name": "MISPEvent",
          "displayName": "MISP",
          "titlePrefix": "[MISP]",
          "description": "Check if IOCs shared by the community have been seen on the network",
          "severity": 2,
          "tags": [
            "hunting"
          ],
          "flag": false,
          "tlp": 2,
          "pap": 2,
          "tasks": [
            {
              "id": "~122896536",
              "_id": "~122896536",
              "createdBy": "florian@strangebee.com",
              "createdAt": 1630675267741,
              "_type": "case_task",
              "title": "Search for IOCs on Mail gateway logs",
              "group": "default",
              "description": "Run queries in Mail gateway logs and look for IOcs of type IP, email addresses, hostnames, free text. ",
              "status": "Waiting",
              "flag": false,
              "order": 0
            },
            {
              "id": "~81932320",
              "_id": "~81932320",
              "createdBy": "florian@strangebee.com",
              "createdAt": 1630675267743,
              "_type": "case_task",
              "title": "Search for IOCs on Firewall logs",
              "group": "default",
              "description": "Run queries in firewall logs and look for IOcs of type IP, port",
              "status": "Waiting",
              "flag": false,
              "order": 1
            },
            {
              "id": "~81928376",
              "_id": "~81928376",
              "createdBy": "florian@strangebee.com",
              "createdAt": 1630675267750,
              "_type": "case_task",
              "title": "Search for IOCs on Web proxy logs",
              "group": "default",
              "description": "Run queries in web proxy logs and look for IOcs of type IP, domain, hostname, user-agent",
              "status": "Waiting",
              "flag": false,
              "order": 2
            }
          ],
          "status": "Ok",
          "customFields": {
            "hits": {
              "integer": null,
              "order": 1,
              "_id": "~122900632"
            }
          },
          "metrics": {}
        }
        ```

    === "400"

        ```json
        {
          "type": "CreateError",
          "message": "The case template \"MISPEvent\" already exists"
        }
        ```

    === "401"

        ```json
        {
          "type": "AuthenticationError",
          "message": "Authentication failure"
        }
        ```
