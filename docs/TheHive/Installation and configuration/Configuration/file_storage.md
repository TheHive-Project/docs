# File storage configuration

TheHive can be configured to connect to local Berkeley database or Cassandra database.


## Examples


=== "Local or NFS"


    ```
    ## Attachment storage configuration
    storage {
    ## Local filesystem
    provider: localfs
    localfs {
      location: /opt/thp/thehive/files
    }
    ```

    !!! Note
        The local folder `/opt/thp/thehive/files` should belong to the user `thehive:thehive`.


=== "Min.IO" 

    ```
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

    ```
    ## Attachment storage configuration
    ## Hadoop filesystem (HDFS)
    provider: hdfs
    hdfs {
      root: "hdfs://localhost:10000" # namenode server hostname
      location: "/thehive"           # location inside HDFS
      username: thehive              # file owner
      }
    }   
    ```