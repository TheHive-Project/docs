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

## List of possible parameters 


| Parameter                   | Type           |  Description               |
| --------------------------- | -------------- | ---------------------------| 
| `provider`                                                      | string         | provider name. Default: `janusgraph` | 
| `storage`                                                       | dict           | storage configuration                |
| `storage.backend`                                               | string         | storage type. Can be `cql` or `berkeleyje` |
| `storage.hostname`                                              | list of string | list of IP addresses or hostnames when using `cql` backend  |
| `storage.directory`                                             | string         | local path for data when using `berkeleyje` backend  |
| `storage.username `                                             | string         | account username with `cql` backend if Cassandra auth is configured |
| `storage.password `                                             | string         | account password with `cql` backend if Cassandra auth is configured |
| `storage.port `                                                 | integer        | port number with `cql` backend (`9042` by default). Change this if using an alternate port or a dedicated port number when using SSL with Cassandra |
| `storage.cql`                                                   | dict           | configuration for `cql` backend _if used_                |
| `storage.cql.cluster-name`                                      | string         | name of the cluster name used in the configuration of Apache Cassandra |
| `storage.cql.keyspace`                                          | string         | Keyspace name used to store TheHive data in Apache Cassandra |
| `storage.cql.ssl.enabled`                                       | boolean        | `false` by default. set it to `true` if SSL is used with Cassandra  |
| `storage.cql.ssl.truststore.location`                           | string         | path the the truststore. Specify it when using SSL with Cassandra  |
| `storage.cql.ssl.password`                                      | string        | password to access the truststore  |
| `storage.cql.ssl.client-authentication-enabled`                 | boolean       | Enables use of a client key to authenticate with Cassandra  |
| `storage.cql.ssl.keystore.location`                             | string         | path the the keystore. Specify it when using SSL and client auth. with Cassandra  |
| `storage.cql.ssl.keystore.keypassword`                          | string         | password to access the key in the keystore  |
| `storage.cql.ssl.truststore.storepassword`                      | string         | password the access the keystore  |
| `index.search`                                                  | dict           | configuration for indexes                |
| `index.search.backend`                                          | string         | index engine. Default: `lucene` provided with TheHive. Can also be `elasticsearch`  |
| `index.search.directory`                                        | string         | path to folder where indexes should be stored, when using `lucene` engine           |
| `index.search.hostname`                                         | list of string | list of IP addresses or hostnames when using `elasticsearch` engine           |
| `index.search.index-name`                                       | string         | name of index, when using `elasticseach` engine           |
| `index.search.elasticsearch.http.auth.type: basic`              | string         | `basic` is the only possible value |
| `index.search.elasticsearch.http.auth.basic.username`           | string         | Username account on Elasticsearch |
| `index.search.elasticsearch.http.auth.basic.password`           | string         | Password of the account on Elasticsearch |
| `index.search.elasticsearch.ssl.enabled`                        | boolean        | Enable SSL `true/false` |
| `index.search.elasticsearch.ssl.truststore.location`            | string         | Location of the truststore |
| `index.search.elasticsearch.ssl.truststore.password`            | string         | Password of the truststore |
| `index.search.elasticsearch.ssl.keystore.location`              | string         | Location of the keystore for client authentication  |
| `index.search.elasticsearch.ssl.keystore.storepassword`         | string         | Password of the keystore |
| `index.search.elasticsearch.ssl.keystore.keypassword`           | string         | Password of the client certificate |
| `index.search.elasticsearch.ssl.disable-hostname-verification`  | boolean        | Disable SSL verification `true/false` |
| `index.search.elasticsearch.ssl.allow-self-signed-certificates` | boolean        | Allow self signe certificates `true/false` |

!!! Warning

    - Using Elasticsearch to manage indexes is required if you are setting up TheHive as a cluster.
    - The **initial start**, or first start after configuring indexes **might take some time** if the database contains a large amount of data. This time is due to the indexes creation


More information on configuration for Elasticsearch connection: [https://docs.janusgraph.org/index-backend/elasticsearch/](https://docs.janusgraph.org/index-backend/elasticsearch/).


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
                    elasticsearch {
                      http {
                        auth {
                          type: basic
                          basic {
                            username: httpuser
                            password: httppassword
                          }
                        }
                      }
                      ssl {
                        enabled: true
                        truststore {
                          location: /path/to/your/truststore.jks
                          password: truststorepwd
                        }
                      }
                    }
                  }
                }
              }
            }                
            ```

        !!! Warning
            In this configuration, all TheHive nodes should have the same configuration.
            
            Elasticsearch configuration should use the default value for `script.allowed_types`, or contain the following configuration line: 

            ```yaml
            script.allowed_types: inline,stored
            ```


