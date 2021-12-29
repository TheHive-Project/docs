# TheHive connector: Cortex

## Enable the connector

The Cortex connector module needs to be enabled to allow TheHive work with Cortex. Enable the module with this line of configuration: 

```yaml
play.modules.enabled += org.thp.thehive.connector.cortex.CortexModule
```

##  Configure one connection

TheHive is able to connect more than one Cortex organisation. Several parameters can be configured for one server :

| Parameter                      | Type           | Description                          |
| -------------------------------| -------------- | ------------------------------------ |
| `name`                         | string         | name given to the Cortex instance (eg: _Cortex-Internal_) |
| `url`                          | string         | url to connect to the Cortex instance |
| `auth`                         | dict           | method used to authenticate on the server (_bearer_ if using API keys) |
| `wsConfig`                     | dict           | network configuration dedicated to Play Framework for [SSL](ssl.md) and [proxy](proxy.md) |
| `refreshDelay`                 | duration       | frequency of job updates checks (default: `5 seconds`) |
| `maxRetryOnError`              | integer        | maximum number of successive errors before give up (default: `3`) |
| `statusCheckInterval`          | duration       | check remote Cortex status time interval (default: `1 minute`) |
| `includedTheHiveOrganisations` | list of string | list of TheHive organisations which can use this Cortex server (default: _all_ (`[*]`) |
| `excludedTheHiveOrganisations` | list of string | list of TheHive organisations which cannot use this Cortex server (default: _None_ (`[]`) ) |

This configuration has to be added to TheHive `conf/application.conf` file. 

```
## Cortex configuration
play.modules.enabled += org.thp.thehive.connector.cortex.CortexModule
cortex {
  servers = [
    {
      name = local
      url = "http://localhost:9001"
      auth {
        type = "bearer"
        key = "[REDACTED]"
      }
      wsConfig {}
    includedTheHiveOrganisations = ["*"]
    excludedTheHiveOrganisations = []
    }
  ]
  refreshDelay = 5 seconds
  maxRetryOnError = 3
  statusCheckInterval = 1 minute
}
```


!!! Note
    By default, adding a Cortex server in TheHive configuration make it available for all organisations added on the instance.



!!! Example

    === "1 server"

        Configuration with one Cortex connection: 

        ```yaml
        ## Cortex configuration
        play.modules.enabled += org.thp.thehive.connector.cortex.CortexModule
        cortex {
          servers = [
            {
              name = Cortex
              url = "http://cortex1:9001"
              auth {
                type = "bearer"
                key = "tkjjyfsdgrKuPttaaasdDWSEzClKuPt"
              }
              wsConfig {
                proxy {
                  host: "10.1.2.10"
                  port: 8080
                }
              }
              includedTheHiveOrganisations = ["ORG1", "ORG2"]
              excludedTheHiveOrganisations = []
            }
          ]
          refreshDelay = 5 seconds
          maxRetryOnError = 3
          statusCheckInterval = 1 minute
        }
        ```

    === "more servers"

        Configuration with 2 Cortex connections: 

        ```yaml
        ## Cortex configuration
        play.modules.enabled += org.thp.thehive.connector.cortex.CortexModule
        cortex {
          servers = [
            {
              name = Cortex1
              url = "http://cortex1:9001"
              auth {
                type = "bearer"
                key = "tkjjyfsdgrKuPttaaasdDWSEzClKuPt"
              }
              wsConfig {}
              includedTheHiveOrganisations = ["ORG1", "ORG2"]
              excludedTheHiveOrganisations = []
            }
            {
              name = Cortex2
              url = "http://cortex2:9001"
              auth {
                type = "bearer"
                key = "lSDkjDGGGHtipueroBHOroNJKLbpi"
              }
              wsConfig {
                proxy {
                  host: "10.1.2.10"
                  port: 8080
                }
              }
              includedTheHiveOrganisations = ["ORG2", "ORG3"]
              excludedTheHiveOrganisations = ["ORG1"]
            }
          ]
          refreshDelay = 5 seconds
          maxRetryOnError = 3
          statusCheckInterval = 5 minutes
        }
        ```