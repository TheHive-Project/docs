# Query API

## Overview

The Query API is the API used to search for objects with filtering and sorting capabilities. It's an API introduced by TheHive 4 and is optimized for the the new data model.

TheHive comes with a list of predefined search *Queries* like:

- `listOrganisation`
- `listUser`
- `listAlert`
- `listCase`

## Query

```plain
POST /api/v0/query
```

## Request Body

The Query API request body should be an array of *operations* of different types:

- Selection: *Required*
    - list of objects
    - object by identifier
- Filtering: *optional*
- Sorting: *optional*
- Pagination: *optional*
- Formatting: *optional*

!!! Examples

    === "Simple List"
        ```json
        {
            "query": [
                {
                    "_name": "listOrganisation"
                }
            ]
        }
        ```
    === "List with filters"
        List organisations called *admin*
        ```json
        {
            "query": [
                {
                    "_name": "listOrganisation"
                },
                {
                    "_like": {
                        "_field": "name",
                        "_value": "admin"
                    },
                    "_name": "filter"
                }
            ]
        }
        ```
    === "List with filters and sort"
        List organisations called *admin*, sorted by ascendant `updatedAt` value
        ```json
        {
            "query": [
                {
                    "_name": "listOrganisation"
                },
                {
                    "_like": {
                        "_field": "name",
                        "_value": "admin"
                    },
                    "_name": "filter"
                },
                {
                    "_fields": [
                        {
                            "updatedAt": "asc"
                        }
                    ],
                    "_name": "sort"
                }
            ]
        }
        ```
    === "List with pagination"
        List organisations called *admin*, sorted by ascendant `updatedAt` value, paginated to display the first 15 items
        ```json
        {
            "query": [
                {
                    "_name": "listOrganisation"
                },
                {
                    "_like": {
                        "_field": "name",
                        "_value": "admin"
                    },
                    "_name": "filter"
                },
                {
                    "_fields": [
                        {
                            "updatedAt": "asc"
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

    