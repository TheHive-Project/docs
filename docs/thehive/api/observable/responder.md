# Responder

You need to connect TheHive to a cortex server in order to enable responders.

!!! attention
    Responder can only be run on an observable of a case.

## Run a responder on an observable

```
POST /api/connector/cortex/action
```

### Request example

!!! Example ""

    ```json
    {
        "cortexId": "Stable",
        "responderId": "e4c500d589d14503883c02d02313cf57",
        "objectType": "case_artifact",
        "objectId": "~816984288"
    }
    ```

The following fields are required:

- `cortexId`: name of the cortex server from the configuration
- `objectType`: should be `case_artifact` here
- `objectId`: id of the observable to analyze
- `responderId`: id of the cortex responder to use

### Response example

!!! Example ""

    ```json
    {
        "responderId": "e4c500d589d14503883c02d02313cf57",
        "responderName": "ADD_TO_WEBPROXY_BL_1_0",
        "responderDefinition": "ADD_TO_WEBPROXY_BL_1_0",
        "cortexId": "Stable",
        "cortexJobId": "Bv0cq3sB8Pn57ilsUkFM",
        "objectType": "Observable",
        "objectId": "~816984288",
        "status": "Waiting",
        "startDate": 1630663366136,
        "operations": "[]",
        "report": "{}"
    }
    ```

## List responder actions

```
GET /api/connector/cortex/action/case_artifact/{observableId}
```


### Response example

!!! Example

    ```json
    [
        {
            "responderId": "e4c500d589d14503883c02d02313cf57",
            "responderName": "ADD_TO_WEBPROXY_BL_1_0",
            "responderDefinition": "ADD_TO_WEBPROXY_BL_1_0",
            "cortexId": "Stable",
            "cortexJobId": "Bv0cq3sB8Pn57ilsUkFM",
            "objectType": "Observable",
            "objectId": "~816984288",
            "status": "Failure",
            "startDate": 1630663366136,
            "endDate": 1630663372393,
            "operations": "[]",
            "report": "{\"summary\":{\"taxonomies\":[]},\"full\":null,\"success\":false,\"artifacts\":[],\"operations\":[],...}"
        }
    ]
    ```

- `status` can be one of:
    - `Waiting`
    - `Success`
    - `InProgress`
    - `Failure`
    - `Deleted`

- `report` is a string that contains the output of the responder

