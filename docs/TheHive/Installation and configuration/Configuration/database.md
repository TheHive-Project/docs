# Database configuration

TheHive can be configured to connect to local Berkeley database or Cassandra database.


## Examples


=== "Berkeley DB"


    ```
    # Database Configuration
    ## For test only !
    # Comment Cassandra settings before enable Berkeley database
    db.janusgraph {
      storage {
        backend: berkeleyje
        directory: /opt/thp/thehive/database
      }
    ```

    !!! Note
        The local folder `/opt/thp/thehive/database` should belong to the user `thehive:thehive`.


=== "Apache Cassandra - standalone server" 

    ```
    ## Database Configuration
    db.janusgraph {
      storage {
      ## Cassandra configuration
      # More information at https://docs.janusgraph.org/basics/configuration-reference/#storagecql
      backend: cql
      hostname: ["10.1.2.1"]
      # Cassandra authentication (if configured)
      username: "thehive_account"
      password: "cassandra_password"
      cql {
        cluster-name: thp
        keyspace: thehive
      }
    }
    ```

=== "Apache Cassandra - Cluster with 3 nodes" 

    ```
    ## Database Configuration
    db.janusgraph {
      storage {
      ## Cassandra configuration
      # More information at https://docs.janusgraph.org/basics/configuration-reference/#storagecql
      backend: cql
      hostname: ["10.1.2.1", "10.1.2.2", "10.1.2.3"]
      # Cassandra authentication (if configured)
      username: "thehive_account"
      password: "cassandra_password"
      cql {
        cluster-name: thp
        keyspace: thehive
      }
    }
    ```

    !!! Note
        In this configuration, all 3 nodes should have the same configuration.