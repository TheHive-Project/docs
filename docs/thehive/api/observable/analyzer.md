# Analyzer

You need to connect TheHive to a cortex server in order to enable analyzers.

!!! attention
    Analyzer can only be run on an observable of a case.

## Run an analyzer on an observable

```
POST /api/connector/cortex/job
```

### Request example

!!! Example ""

    ```json
    {
        "cortexId":"Stable",
        "artifactId":"~816984288",
        "analyzerId":"Abuse_Finder_3_0"
    }
    ```

The following fields are required:
- `cortexId`: name of the cortex server from the configuration
- `artifactId`: id of the observable to analyze
- `analyzerId`: id of the cortex analyzer to use

### Response example

!!! Example ""

    ```json
    {
        "_type": "case_artifact_job",
        "analyzerId": "bface6faa22029dcf81d5d817f27eb98",
        "analyzerName": "Abuse_Finder_3_0",
        "analyzerDefinition": "Abuse_Finder_3_0",
        "status": "Waiting",
        "startDate": 1630660394582,
        "endDate": 1630660394582,
        "cortexId": "Stable",
        "cortexJobId": "BP3uqnsB8Pn57ils_kFX",
        "id": "~1433604184"
    }
    ```

## Get analyzer report

```
GET /api/connector/job/{jobId}
```

`jobId` should be the `id` returned from the creation request

### Response example

!!! Example

    ```json
    {
        "_type": "case_artifact_job",
        "analyzerId": "bface6faa22029dcf81d5d817f27eb98",
        "analyzerName": "Abuse_Finder_3_0",
        "analyzerDefinition": "Abuse_Finder_3_0",
        "status": "Success",
        "startDate": 1630660394582,
        "endDate": 1630660427845,
        "report": {
            "success": true,
            "full": {
                "abuse_finder": {
                    "value": "1.2.3.4",
                    "names": [
                    "APNIC Debogon Project"
                    ],
                    "abuse": [
                    "helpdesk@apnic.net"
                    ],
                    "raw": "% [whois.apnic.net]\n% Whois data copyright terms    http://www.apnic.net/db/dbcopyright.html\n\n% Inf..."
                }
            },
            "artifacts": []
        },
        "cortexId": "Stable",
        "cortexJobId": "BP3uqnsB8Pn57ils_kFX",
        "id": "~1433604184"
    }
    ```

- `status` can be one of:
    - `Waiting`
    - `Success`
    - `InProgress`
    - `Failure`
    - `Deleted`

## List reports for an observable

```
POST /api/v1/query
```

### Query body example

Replace the value of `idOrName` by the `id` of your observable

!!! Example

    ```json
    {
      "query": [
        {
          "_name": "getObservable",
          "idOrName": "~816984288"
        },
        {
          "_name": "jobs"
        },
        {
          "_name": "sort",
          "_fields": [
            {
              "startDate": "desc"
            }
          ]
        },
        {
          "_name": "page",
          "from": 0,
          "to": 200
        }
      ]
    }
    ```

### Response example


!!! Example

    ```json
    [
      {
        "_type": "case_artifact_job",
        "analyzerId": "bface6faa22029dcf81d5d817f27eb98",
        "analyzerName": "Abuse_Finder_3_0",
        "analyzerDefinition": "Abuse_Finder_3_0",
        "status": "Waiting",
        "startDate": 1630660394582,
        "endDate": 1630660394582,
        "cortexId": "Stable",
        "cortexJobId": "BP3uqnsB8Pn57ils_kFX",
        "id": "~1433604184"
      }
    ]
    ```

