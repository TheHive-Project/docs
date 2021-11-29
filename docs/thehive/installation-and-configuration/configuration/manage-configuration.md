# Manage configuration files

TheHive uses [HOCON](https://github.com/lightbend/config/blob/master/HOCON.md) as configuration file format.  This format gives enough flexibility to structure and organise the configuration of TheHive.

TheHive is delivered with following files, in the folder `/etc/thehive` : 

- `logback.xml` containing the log policy
- `secret.conf` containing a secret key used to create sessions. This key should be unique per instance (in the case of a cluster, this key should be the same for all nodes of this cluster)
- `application.conf`


HOCON file format let you organise the configuration to have separate files for each purpose. It is the possible to create a `/etc/thehive/application.conf.d` folder and have several files inside that will be _included_ in the main file `/etc/thehive/application.conf`. 

At the end, the following configuration structure is possible: 

```
/etc/thehive
|-- application.conf
|-- application.conf.d
|   |-- secret.conf
|   |-- service.conf
|   |-- ssl.conf
|   |-- proxy.conf
|   |-- database.conf
|   |-- storage.conf
|   |-- cluster.conf
|   |-- authentication.conf
|   |-- cortex.conf
|   |-- misp.conf
|   `-- webhooks.conf
`-- logback.xml

```

And the content of `/etc/thehive/application.conf`: 

```conf
###
## Documentation is available at https://docs.thehive-project.org
###

## Include Play secret key
# More information on secret key at https://www.playframework.com/documentation/2.8.x/ApplicationSecret
include "/etc/thehive/application.conf.d/secret.conf"

## Service
include "/etc/thehive/application.conf.d/service.conf"

## SSL settings
include "/etc/thehive/application.conf.d/ssl.conf"

## PROXY settings
include "/etc/thehive/application.conf.d/proxy.conf"

## Database
include "/etc/thehive/application.conf.d/database.conf"

## Storage
include "/etc/thehive/application.conf.d/storage.conf"

## Cluster
include "/etc/thehive/application.conf.d/cluster.conf"

## Authentication
include "/etc/thehive/application.conf.d/authentication.conf"

## Cortex
include "/etc/thehive/application.conf.d/cortex.conf"

## MISP
include "/etc/thehive/application.conf.d/misp.conf"

## Webhooks
include "/etc/thehive/application.conf.d/webhooks.conf"
```
