# Database configuration

TheHive can be configured to connect to local Berkeley database or [Cassandra](https://cassandra.apache.org/) database. 

!!! Tip
    Using Cassandra is strongly recommended for production use while Berkeley DB can be prefered for testing and training purpose.

!!! Example

    === "Berkeley DB"

        1. Create a dedicated folder. This folder should belong to the user `thehive:thehive`.

            ```bash
            mkdir /opt/thp/thehive/database
            chown -R thehive:thehive /opt/thp/thehive/database 
            ```
        
        2. Configure TheHive accordingly: 

            ```yaml
            # Database Configuration
            ## For test only !
            # Comment Cassandra settings before enable Berkeley database
            db.janusgraph {
              storage {
                backend: berkeleyje
                directory: /opt/thp/thehive/database
              }
            ```


    === "Apache Cassandra - standalone server" 

        1. Install a Cassandra server locally
        2. Configure TheHive accordingly 

            ```yaml
            ## Database Configuration
            db.janusgraph {
              storage {
              ## Cassandra configuration
              # More information at https://docs.janusgraph.org/basics/configuration-reference/#storagecql
              backend: cql
              hostname: ["127.0.0.1"]
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


        1. Install a cluster of Cassandra servers
        2. Configure TheHive accordingly 
            ```yaml
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

        !!! Warning
            In this configuration, all 3 nodes should have the same configuration.