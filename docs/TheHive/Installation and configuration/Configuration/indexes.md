# Indexes



## Configuration

=== "Lucene"

    ```
    ## Indexes configuration
    index{
        search {
        backend : lucene
        directory:  /opt/thp/thehive/index
        }
    }
    berkeleyje.freeDisk: 200 # disk usage threshold

    }
    ```

    !!! Note
        The folder `/opt/thp/thehive/index` should belong to user and group `thehive:thehive`

    !!! Tip
        This is the recommended configuration for a **standalone server**

=== "Elasticsearch"

    ```
    ## Indexes configuration
    index {
        search {
        backend : elasticsearch
        hostname : ["10.1.2.5"]
        index-name : thehive
    }
    }
    ```

    !!! Tip
        Using Elasticsearch to manages indexes is required if you are setting up TheHive as a cluster 

    
## First start

TODO