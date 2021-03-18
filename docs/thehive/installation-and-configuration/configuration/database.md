# Database and index configuration

TheHive can be configured to connect to local Berkeley database or [Cassandra](https://cassandra.apache.org/) database. 

!!! Tip
    Using Cassandra is strongly recommended for production use while Berkeley DB can be prefered for testing and training purpose.


Starting with TheHive 4.1.0, indexes are managed by a dedicated engine. 

According to the setup, the instance can use:

-  A local engine, **Lucene** driven by TheHive
-  A centralised engine, **Elasticsearch**.


## Configuation 


A typical database configuration for TheHive looks like this:

```
## Database configuration
db {
  provider: janusgraph
  janusgraph {
    ## Storage configuration
    storage {
      backend: cql
      hostname: ["IP_ADDRESS"]
      cql {
        cluster-name: thp
        keyspace: thehive
      }
    }
    ## Index configuration
    index {
      search {
        backend : lucene
        directory:  /path/to/index/folder
      }
    }
  }
}
```

with: 

| Parameter                   | Type           |  Description               |
| --------------------------- | -------------- | ---------------------------| 
| `provider`                  | string         | provider name. Default: `janusgraph` | 
| `storage`                   | dict           | storage configuration                |
| `storage.backend`           | string         | storage type. Can be `cql` or `berkeleyje` |
| `storage.hostname`          | list of string | list of IP addresses or hostnames when using `cql` backend  |
| `storage.directory`         | string         | local path for data when using `berkeleyje` backend  |
| `storage.cql`               | dict           | configuration for `cql` backend _if used_                |
| `storage.cql.cluster-name`  | string         | name of the cluster name used in the configuration of Apache Cassandra |
| `storage.cql.keyspace`      | string         | Keyspace name used to store TheHive data in Apache Cassandra |
| `index.search`              | dict           | configuration for indexes                |
| `index.search.backend`      | string         | index engine. Default: `lucene` provided with TheHive. Can also be `elasticsearch`  |
| `index.search.directory`    | string         | path to folder where indexes should be stored, when using `lucene` engine           |
| `index.search.hostname`     | list of string | list of IP addresses or hostnames when using `elasticsearch` engine           |
| `index.search.index-name`   | string         | name of index, when using `elasticseach` engine           |



!!! Warning

    - Using Elasticsearch to manage indexes is required if you are setting up TheHive as a cluster.
    - The **initial start**, or first start after configuring indexes **might take some time** if the database contains a large amount of data. This time is due to the indexes creation

## Use cases

Database and index engine can be different, depending on the use case and target setup:


!!! Example

    === "Testing server"

        For such use cases, local database and indexes are adequate:

        1. Create a dedicated folder for data and for indexes. These folders should belong to the user `thehive:thehive`.

            ```bash
            mkdir /opt/thp/thehive/{data, index}
            chown -R thehive:thehive /opt/thp/thehive/{data, index}
            ```
        
        2. Configure TheHive accordingly: 

            ```
            ## Database Configuration
            db {
              provider: janusgraph
              janusgraph {
                ## Storage configuration
                storage {
                  backend: berkeleyje
                  directory: /opt/thp/thehive/database
                }
                ## Index configuration
                index {
                  search {
                    backend: lucene
                    directory: /opt/thp/thehive/index
                  }
                }
              }
            }
            ```


    === "Standalone server with Cassandra" 

        1. Install a Cassandra server locally
        2. Create a dedicated folder for indexes. This folder should belong to the user `thehive:thehive`

          ```bash
            mkdir /opt/thp/thehive/index
            chown -R thehive:thehive /opt/thp/thehive/index
          ```

        3. Configure TheHive accordingly 

            ```
            ## Database Configuration
            db {
              provider: janusgraph
              janusgraph {
                ## Storage configuration
                storage {
                  backend: cql
                  hostname: ["127.0.0.1"]
                  ## Cassandra authentication (if configured)
                  username: "thehive_account"
                  password: "cassandra_password"
                  cql {
                    cluster-name: thp
                    keyspace: thehive
                  }
                }
                ## Index configuration
                index {
                  search {
                    backend: lucene
                    directory: /opt/thp/thehive/index
                  }
                }
              }
            }
            ```

    === "Cluster with Cassandra & Elasticsearch " 


        1. Install a cluster of Cassandra servers
        2. Get access to an Elasticsearch server
        3. Configure TheHive accordingly

            ```
            ## Database Configuration
            db {
              provider: janusgraph
              janusgraph {
                ## Storage configuration
                storage {
                  backend: cql
                  hostname: ["10.1.2.1", "10.1.2.2", "10.1.2.3"]
                  ## Cassandra authentication (if configured)
                  username: "thehive_account"
                  password: "cassandra_password"
                  cql {
                    cluster-name: thp
                    keyspace: thehive
                  }
                }
                ## Index configuration
                index {
                  search {
                    backend : elasticsearch
                    hostname : ["10.1.2.5"]
                    index-name : thehive
                  }
                }
              }
            }                
            ```

        !!! Warning
            In this configuration, all TheHive nodes should have the same configuration.


