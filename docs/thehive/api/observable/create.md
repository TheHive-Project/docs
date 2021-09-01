# Create

Creates an observable which can be linked to a case or an alert.

(The name artifcat comes from TheHive v3)

## Query

Create an observable for a case
```
POST /api/v0/case/{caseId}/artifact
```

Create an observable for an alert
```
POST /api/v0/alert/{alertId}/artifact
```


## Request Example

If you want to upload an observable with a `dataType` of kind attachment, you need to use a multipart request

!!! Example ""


    ```
    curl -XPOST http://THEHIVE/api/v0/case/{caseId}/artifact -F attachment=@myFile -F _json='
    {
        "dataType": "file",
        "tlp": 2,
        "ioc": true,
        "sighted": false,
        "tags": [],
        "message": "foo",
        "data": [],
        "isZip": false,
        "zipPassword": ""
    }
    '
    ```

To add an observable with no attachment, you can post a json body

!!! Example ""

    ```json
    {
        "dataType": "hostname",
        "tlp": 2,
        "ioc": true,
        "sighted": true,
        "tags": [],
        "data": [
            "server.local"
        ]
    }
    ```

The following fields are required:

- `dataType`: (enum String, should be one registered observable type)
- One of `data` (Array of String) or `attachment` (File)

Other optional fields:

- `message`: (String) description of the observable in the context of the case
- `startDate`: (Date) date of the observable creation **default=now**
- `tlp`: (Int) [TLP](https://www.us-cert.gov/tlp) (`0`: `white`; `1`: `green`; `2`: `amber`;`3`: `red`) **default=2**
- `tags`: (Array of string) a list of tags **default=[]**
- `ioc`: (Boolean) indicates if the observable is an IOC **default=false**
- `sighted`: (Boolean) indicates if the observable was sighted **default=false**
- `ignoreSimilarity`: (Boolean) indicates if the observable should be used or not to calculate the similarity stats **default=false**

## Response Body Example

```json
[
  {
    "_id": "~4104",
    "id": "~4104",
    "createdBy": "jerome@strangebee.com",
    "createdAt": 1630508511351,
    "_type": "case_artifact",
    "dataType": "file",
    "startDate": 1630508511351,
    "attachment": {
      "name": "server.log",
      "hashes": [
        "ccbda6ed6aac6cde57ebac1f011bdf1f58bf61c40c759dc4f7fccb729de10147",
        "a09531845b3b26d5707cdf50a8bb11aa507dd88c",
        "1f08c024363568d6eb4e18ee97618acc"
      ],
      "size": 37165,
      "contentType": "application/octet-stream",
      "id": "ccbda6ed6aac6cde57ebac1f011bdf1f58bf61c40c759dc4f7fccb729de10147"
    },
    "tlp": 2,
    "tags": [],
    "ioc": true,
    "sighted": false,
    "message": "my message",
    "reports": {},
    "stats": {}
  }
]
```
