# Database configuration


!!! Example "" 
    ```yaml title="/etc/cortex/application.conf"
    [..]
    ## ElasticSearch
    search {
      index = cortex
      # For cluster, join address:port with ',': "http://ip1:9200,ip2:9200,ip3:9200"
      uri = "http://127.0.0.1:9200"

      ## Advanced configuration
      # Scroll keepalive.
      #keepalive = 1m
      # Scroll page size.
      #pagesize = 50
      # Number of shards
      #nbshards = 5
      # Number of replicas
      #nbreplicas = 1
      # Arbitrary settings
      #settings {
      #  # Maximum number of nested fields
      #  mapping.nested_fields.limit = 100
      #}

      ## Authentication configuration
      #username = ""
      #password = ""

      ## SSL configuration
      #keyStore {
      #  path = "/path/to/keystore"
      #  type = "JKS" # or PKCS12
      #  password = "keystore-password"
      #}
      #trustStore {
      #  path = "/path/to/trustStore"
      #  type = "JKS" # or PKCS12
      #  password = "trustStore-password"
      #}
    }
    ```