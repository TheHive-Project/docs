# Installation & configuration guides


## Overview

The scalability of TheHive allows it to be set up as a standalone server or as nodes inside a cluster. Any number of nodes can rely on a database and a file system also setup as standalone servers or a cluster. 

Before starting installing and configuring, you need to identify and define the targetted architecture.

![](images/installation-configuration.png)

### Choose a setup
The modular architecture makes it support several types of database, file storage system and indexing system. The initial choices made with the target architecture and the setup are crucial, especially for the database.

If high availability and fault tolerance are necessary, implementing a cluster might be the choice, and this choice determines the database, the file storage and indexing system to install.  

!!! Tip "Hardware Pre-requisites"
    Hardware requirements depends on the number of concurrent users and how they use the system. The following table give some information to choose the hardware.

    | Number of users | CPU  | RAM   |
    | --------------- | ---- | ----- |
    | < 3             | 2    | 4-8   |
    | < 10            | 4    | 8-16  |
    | < 20            | 8    | 16-32 |


### Choose a database 

Once the target setup is identified, the first choice to make is the database. Even of local Berkeley DB and Cassandra database are supported, we recommend using [Apache Cassandra](https://cassandra.apache.org/), which is a scalable and high available Database, even for standalone servers. 

Berkeley DB can be enough for testing purposes.

!!! Danger "Upgradability"
    This choice is decisive as migration from Berkeley DB to Cassandra **is not possible**.
     

### Choose a file storage system

Like for databases, several options exist regarding file system. 

Basically, for standalone setups, using the local filesystem is the easiest solution. If installing a cluster, there are several options:

- Using a share NFS folder
- Using [Apache Hadoop](https://hadoop.apache.org/), a distributed file system
- Using a S3-compatible storage service ; for example with [Min.IO](https://min.io/)

!!! Tip "Upgradability"
    Starting with a standalone server and a local file storage and upgrading to a cluster with S3 of Hadoop is possible. Existing files can be moved to the targetted solutions.

### Choose an index system 

Introduced with TheHive 4.1 to increase performances, TheHive relies on a dedicated indexing process. With a standalone setup, using a local index with Lucene is sufficient.

In the case of a cluster, all nodes have to connect to the same index: an instance of **Elasticsearch** is then required.   

!!! Tip "Upgradability"
    Starting with a standalone server and Lucene and upgrading to a cluster with Elasticsearch is possible. Indices can be rebuilt. However, it can takes some time.

## Installation Guide

The [following Guide](installation/step-by-step-guide.md) let you **prepare**, **install** and **configure** TheHive and its prerequisites for Debian and RPM packages based Operating Systems, as well as for other systems and using our binary packages. 


If you want to build TheHive from sources, you can follow [this guide](installation/build-sources.md).


## Configuration Guides

The configuration of TheHive is in files stored in the `/etc/thehive` folder:
    
  - `application.conf` contains all parameters and options
  - `logback.xml` is dedicated to log management

```
/etc/thehive
├── application.conf
├── logback.xml
└── secret.conf
```

A separate [secret.conf](configuration/secret.md) file is automatically created by Debian or RPM packages. This file should contain a secret that should be used by one instance.

Various aspects can configured in the `application.conf` file:


- [database and indexing](./configuration/database.md)
- [File storage](./configuration/file-storage.md)
- [Akka](./configuration/akka.md)
- [Authentication](./configuration/authentication.md)
- Connectors
    - [Cortex: connecting to one or more organisation](./configuration/connectors-cortex.md)
    - [MISP: connecting to one or more organisation](./configuration/connectors-misp.md)
- [Webhooks](./configuration/webhooks.md)
- [Other service parameters](./configuration/service.md)


## Uses Cases

### Basic stand alone server

Follow the [installation guides](./installation/step-by-step-guide.md) for you prefered operating system.

### Cluster with 3 TheHive nodes

The folling [guide](./architecture/3_nodes_cluster.md) details all the installation and configuration steps to get a cluster with 3 nodes working. The cluster is composed of:  
  
  - 3 TheHive servers  
  - 3 Cassandra servers 
  - 3 Min.IO servers

