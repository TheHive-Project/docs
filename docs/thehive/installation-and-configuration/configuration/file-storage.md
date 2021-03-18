# File storage configuration

TheHive can be configured to connect to local Berkeley database or Cassandra database.

!!! Example

    === "Local or NFS"

        1. Create dedicated folder ; it should belong to user and group `thehive:thehive`.
        
            ```bash
            mkdir /opt/thp/thehive/files
            chown thehive:thehive /opt/thp/thehive/files
            ```

        2. Configure TheHive accordingly:

            ```yaml
            ## Attachment storage configuration
            storage {
              ## Local filesystem
              provider: localfs
              localfs {
                location: /opt/thp/thehive/files
              }
            }
            ```


    === "Min.IO" 

        1. Install a Min.IO cluster

        2. Configure each node of TheHive accordingly: 
 
            ```yaml
            ## Attachment storage configuration
            storage {
              provider: s3
              s3 {
                bucket = "thehive"
                readTimeout = 1 minute
                writeTimeout = 1 minute
                chunkSize = 1 MB
                endpoint = "http://10.1.2.4:9100"
                accessKey = "thehive"
                secretKey = "minio_password"
              }
            }
            ```
        

    === "Apache Hadoop" 

        1. Install an Apache Hadoop server

        2. Configure each node of TheHive accordingly (`/etc/thehive/application.conf`): 

            ```yaml
            ## Attachment storage configuration
            ## Hadoop filesystem (HDFS)
            provider: hdfs
            hdfs {
              root: "hdfs://10.1.2.4:10000" # namenode server hostname
              location: "/thehive"           # location inside HDFS
              username: thehive              # file owner
              }
            }   
            ```