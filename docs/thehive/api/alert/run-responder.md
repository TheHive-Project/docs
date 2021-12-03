# Run Responder

Run a Responder on an *Alert*.

## Query

```plain
POST /api/connector/cortex/action
```


##  Request Body Example

!!! Example "" 
    
    ```json
    {
      "responderId": "05521ec727f75d69e828604dc5ae4c03",
      "objectType": "alert",
      "objectId": "~947478656"
    }
    ```

The following fields are required: 

- `responderId`: (String)
- `objectType`: "alert"
- `objectId`:  (String)

## Response

### Status codes

- `200`: if *Responder* is run successfully
- `401`: Authentication error

### ResponseBody Example

!!! Example ""

    ```json
    {
      "responderId": "05521ec727f75d69e828604dc5ae4bed",
      "responderName": "JIRA_Create_Ticket_1_0",
      "responderDefinition": "JIRA_Create_Ticket_1_0",
      "cortexId": "CORTEX_INTERNAL",
      "cortexJobId": "_v2EnHsB8Pn57ilsukA3",
      "objectType": "Alert",
      "objectId": "~947478656",
      "status": "Waiting",
      "startDate": 1630418550145,
      "operations": "[]",
      "report": "{}"
    }
    ```