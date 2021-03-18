# Update guides

## Update from TheHive 4.0.x to TheHive 4.1.0

TheHive 4.1.0 comes with an updated application stack, with new components dedicated to performance improvement. TheHive 4.1.0 requires the usage of a dedicated index engine to manages indexed data. 

As a result, the minimum configuration required has been updated:

- If you are a new user of TheHive, follow the [installation and configuration guide](../installation-and-configuration/index.md).
- If you are an existing user of TheHive 4.0.x, an index engine should be configured alongside the database. And wether you are using a standalone server or a cluster, the solution to implement and the configuration to update are different.

According to the setup, the instance can use:

-  A local engine, **Lucene** driven by TheHive
-  A centralised engine, **Elasticsearch**.

### Updating a standalone server

In this case, a **Lucene** can be used. TheHive 4.1.0 comes with its **Lucene** engine. The configuration of TheHive, can be updated like this: 

!!! Example ""

    1. Create a dedicated folder for indexes (for example `/opt/thp/thehive/index`). This folder should belong to the user `thehive:thehive`

        ```bash
        mkdir /opt/thp/thehive/index
        chown -R thehive:thehive /opt/thp/thehive/index
        ```

    2. Add the `index` configuration in the `db.janusgraph` part: 

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
            {==## Index configuration
            index {
              search {
                backend: lucene
                directory: /opt/thp/thehive/index
              }
            }==}

          }
        }
        ```
    
    3. Restart TheHive 

        ```bash
        service thehive restart
        ```


Once TheHive configuration is updated and restarted, new indexes are created during the start-up phase.

!!! Warning
    The start-up phase of TheHive and the indexes creation can take a certain amount if time. This phase will be quicker once indexes exist.


### Updating a cluster

In this case, a **Elasticsearch** should be used, as all nodes should have access to the same index. 

Once your Elasticsearch instance is up and running, The configuration of TheHive can be updated like this: 

!!! Example ""

    Here is an example of configuration, use your IP address/hostnames.

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
        {==## Index configuration
        index {
          search {
            backend : elasticsearch
            hostname : ["10.1.2.5"]
            index-name : thehive
          }
        }==}
      }
    }                
    ```

    In this configuration, all TheHive nodes should have the same configuration.


Restart all nodes of the cluster. 

!!! Info
    the cluster makes it work out ; one of the nodes manage the indexing process while others are waiting for it to be ready.


### More information

More information about the configuration of database and indexes can be found in the [dedicated configuration guide](../installation-and-configuration/architecture/configuration/../../configuration/database.md)