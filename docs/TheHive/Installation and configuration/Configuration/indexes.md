# Indexes

Starting with TheHive 4.1.0, indexes are managed by a dedicated engine. 
According to the setup, the instance can use:

-  A local engine, **Lucene** driven by TheHive
-  A centralised engine, **Elasticsearch**.


!!! Example

    === "Lucene"

        1. Create a dedicated folder ; it should belong to user and group `thehive:thehive`.

            ```bash
            mkdir /opt/thp/thehive/index
            chown thehive:thehive /opt/thp/thehive/index
            ```

        2. Configure TheHive accordingly: 
            
            ```yaml
            ## Indexes configuration
            index{
                search {
                backend : lucene
                directory:  /opt/thp/thehive/index
                }
            }
            ```

        !!! Tip
            This is the recommended configuration for a **standalone server**.

    === "Elasticsearch"

        ```yaml
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
            Using Elasticsearch to manage indexes is required if you are setting up TheHive as a cluster. 

    
## First start

Indexes are created during the first start after the configuration changes. 

!!! Warning
    This first start might take some time if the database contains a large amount of data.