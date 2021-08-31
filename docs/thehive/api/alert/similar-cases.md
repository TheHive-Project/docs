# List similar Cases

List similar *Cases*.

## Query

```plain
POST /api/v1/query?name=alert-similar-cases
```


##  Request Body Example

!!! Example "" 
    
    ```json
    {
      "query": [
        {
          "_name": "getAlert",
          "idOrName": "{id}"
        },
        {
          "_name": "similarCases",
          "caseFilter": {
            "_field": "status",
            "_value": "Open"
          }
        }
      ]
    }
    ```

    with: 

    - `id`: id of the Alert.

##  Response 

### Status codes

- `200`: if auery is run successfully
- `401`: Authentication error

### Response Body Example

!!! Example ""

    ```json
    [
      {
        "case": {
          "_id": "~665851112",
          "_type": "Case",
          "_createdBy": "florian@strangebee.com",
          "_updatedBy": "florian@strangebee.com",
          "_createdAt": 1620397519028,
          "_updatedAt": 1624373852175,
          "number": 114,
          "title": "User connected to known malicious IP over Telnet / Malicious payload detected",
          "description": "EDR automated alert: the user robb@training.org has connected to known malicious IP over Telnet\n\nEDR automated alert: malicious payload detected on computer PC-Robb",
          "severity": 2,
          "startDate": 1620396059728,
          "tags": [
            "source:edr",
            "protocol: telnet",
            "log-source:endpoint-protection"
          ],
          "flag": false,
          "tlp": 3,
          "pap": 2,
          "status": "Open",
          "assignee": "florian@strangebee.com",
          "customFields": [],
          "extraData": {}
        },
        "similarObservableCount": 1,
        "observableCount": 6,
        "similarIocCount": 0,
        "iocCount": 0,
        "observableTypes": {
          "username": 1
        }
      },
      {
        "case": {
          "_id": "~789202345",
          "_type": "Case",
          "_createdBy": "florian@strangebee.com",
          "_createdAt": 1620393185339,
          "number": 111,
          "title": "Phishing -User posted information on known phishing URL",
          "description": "SIEM automated alert: the user robb@training.org has posted information on a known phishing url",
          "severity": 2,
          "startDate": 1620393185257,
          "tags": [
            "source:siem",
            "log-source:proxy",
            "category:Phishing"
          ],
          "flag": false,
          "tlp": 3,
          "pap": 2,
          "status": "Open",
          "assignee": "florian@strangebee.com",
          "customFields": [],
          "extraData": {}
        },
        "similarObservableCount": 2,
        "observableCount": 4,
        "similarIocCount": 0,
        "iocCount": 1,
        "observableTypes": {
          "username": 1,
          "mail": 1
        }
      }
    ]
    ```