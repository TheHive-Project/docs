# TheHive connector: MISP

## Enable MISP connector

The MISP connector module needs to be enabled to allow TheHive to interact with MISP. Enable the module with this line of configuration: 

```yaml
play.modules.enabled += org.thp.thehive.connector.misp.MispModule
```

## Configuration 

TheHive is able to connect to more than one MISP server for pulling, pushing or both.

Several parameters can be configured for one server :

| Parameter                      | Type           | Description                          |
| -------------------------------| -------------- | ------------------------------------ |
| `interval`                     | duration       | delay between to pull/push events to remote MISP servers. This is a common parameter for all configured server |
| `name`                         | string         | name given to the MISP instance (eg: `MISP-MyOrg`) |
| `url`                          | string         | url to connect to the MISP instance |
| `auth`                         | dict           | method used to authenticate on the server (_key_ if using API keys) |
| `purpose`                      | string         | define the purpose of the server MISP: `ImportOnly`, `ExportOnly` or `ImportAndExport` (default: `ImportAndExport`) |
| `wsConfig`                     | dict           | network configuration dedicated to Play Framework for [SSL](ssl.md) and [proxy](proxy.md) |
| `caseTemplate`                 | string         | case template used by default in TheHive to import events as Alerts |
| `tags`                         | list of string | tags to be added to events imported as Alerts in TheHive |
| `exportCaseTags`               | boolean        | indicate if the tags of the case should be exported to MISP event (default: false) |

**Optional** parameters can be added to filter out some events coming into TheHive:

| Parameter                      | Type           | Description                          |
| -------------------------------| -------------- | ------------------------------------ |
| `exclusion.organisations`      | list of string | list of MISP organisation from which event will not be imported |
| `exclusion.tags`               | list of string | don't import MISP events which have one of these tags |
| `whitelist.organisations`      | list of string | import only events from these MISP organisations |
| `whitelist.tags`               | list of string | import only MISP events which have one of these tags |
| `max-age`                      | duration       | maximum age of the last publish date of event to be imported in TheHive  |
| `includedTheHiveOrganisations` | list of string | list of TheHive organisations which can use this MISP server (default: _all_ (`[*]`) |
| `excludedTheHiveOrganisations` | list of string | list of TheHive organisations which cannot use this MISP server (default: _None_ (`[]`) ) |

Additionally, some organisations or tags from MISP can be defined to exclude events. 

!!! Note
    By default, adding a MISP server in TheHive configuration make it available for all organisations added on the instance.


This configuration has to be added to TheHive `conf/application.conf` file:

```yaml
## MISP configuration
# More information at https://github.com/TheHive-Project/TheHiveDocs/TheHive4/Administration/Connectors.md
# Enable MISP connector
play.modules.enabled += org.thp.thehive.connector.misp.MispModule
misp {
  interval: 1 hour
  servers: [
    {
      name = "local"            
      url = "http://localhost/" 
      auth {
        type = key
        key = "***"
      }
      wsConfig {}
      caseTemplate = "<Template_Name_goes_here>"      
      tags = ["misp-server-id"]
      max-age = 7 days
      exclusion {
        organisations = ["bad organisation", "other orga"]
        tags = ["tag1", "tag2"]
      }
      whitelist {
        tags = ["tag1", "tag2"]
      }
      includedTheHiveOrganisations = ["*"]
      excludedTheHiveOrganisations = []
    }
  ]
} 
```


!!! Example

    Connection with 1 MISP server:

    ```yaml
    ## MISP configuration
    # More information at https://github.com/TheHive-Project/TheHiveDocs/TheHive4/Administration/Connectors.md
    # Enable MISP connector
    play.modules.enabled += org.thp.thehive.connector.misp.MispModule
    misp {
      interval: 1 hour
      servers: [
        {
          name = "MISP Server"     
          url = "https://misp.server"
          auth {
            type = key
            key = "XhtropikjthiuGIORWUHHlLhlfeerljta"
          }
          wsConfig {
            proxy {
              host: "10.1.2.10"
              port: 8080
            }
          }
          tags = ["tag1", "tag2", "tag3"]
          caseTemplate = "misp"
          includedTheHiveOrganisations = ["ORG1", "ORG2" ]
        }
      ]
    }
    ```