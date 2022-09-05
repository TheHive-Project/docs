# Installation & configuration guides


## Overview
Cortex relies on Elasticsearch to store its data. A basic setup to install Elasticsearch, then Cortex on a standalone and dedicated server (physical or virtual).

Before starting the install Cortex, this is important to know how _Analyzers_ and _Responders_ will be managed and run. 2 solutions are available to run them:

### Run the _Analyzers_ & _Responders_ locally
The programs are downloaded and installed on the system running Cortex. 

There are many disadvantages with this option:

* Some public _Analyzers_ or _Responders_, or you own custom program might required specific applications installed on the system, 
* All of the programs published are written in Python and come with dependancies. To run successfully, the dependancies of all programs should be installed on the same operating system ; so there is a high risk of incompatibilities (some program might require a specific version of a librarie with the latest is also required by another one)
* The goal of _Analyzers_ is to extract or gather information or intelligence about observables ; and some of them might be malicious. Depending on the analysis, like a code analysis, you might want to ensure the Analyzer has not been compromised - and the host - by the observable itself
* You might want to ensure that when you run an _Analyzer_, there is no question about the integrity of its programs
* Updating them might be a pain regarding Operating System used and dependancies

### Run the _Analyzers_ & _Responders_ with Docker
_Analyzers_ & _Responders_ we publish also have their own [Docker images](https://hub.docker.com/search?q=cortexneurons). 

There are several benefits to use Docker images of _Analyzers_ & _Responders_.

* No need to worry about applications required or libraries, it just work
* When requested, Cortex downloads the docker image of a program and instanciate a container running the program. When finished, the container is trashed and a new one is created the next time. No need to worry about the integrity of the program
* This is simple to use and maintain

!!! Tip "This is the recommended option. It requires installing Docker engine as well."

This is not an exclusive choice, both solutions can be used by the same instance of Cortex.


## Hardware requirements
Hardware requirements depends on the usage of the system. We recommend starting with dedicated resources: 

  * 8 vCPU
  * 16 GB of RAM


## Installation Guide

The [following Guide](step-by-step-guide.md) let you **prepare**, **install** and **configure** Cortex and its prerequisites for Debian and RPM packages based Operating Systems, as well as for other systems and using our binary packages. 

## Configuration Guides

The configuration of Cortex is in files stored in the `/etc/cortex` folder:
    
  - `application.conf` contains all parameters and options
  - `logback.xml` is dedicated to log management

```
/etc/cortex
├── application.conf
├── logback.xml
└── secret.conf
```

A separate [secret.conf](secret.md) file is automatically created by Debian or RPM packages. This file should contain a secret that should be used by one instance.

Various aspects can configured in the `application.conf` file:

- [database](database.md)
- [Authentication](authentication.md)
- [Analyzers & Responders](analyzers-responders.md)
