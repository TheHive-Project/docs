# Installation Guide

This page is a step by step installation and configuration guide to get an TheHive 4 instance up and running. This guide is illustrated with examples for Debian and RPM packages based systems and for installation from binary packages.


## Java Virtual Machine

!!! Example ""

    === "Debian"

        ```bash
        apt-get install -y openjdk-8-jre-headless
        echo JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/environment
        export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
        ```

    === "RPM"
    
        ```bash
        yum install -y java-1.8.0-openjdk-headless.x86_64
        echo JAVA_HOME="/usr/lib/jvm/jre-1.8.0" >> /etc/environment
        export JAVA_HOME="/usr/lib/jvm/jre-1.8.0"
        ```

    === "Other"

        The installation requires Java 8, so refer to your system documentation to install it.

## Cassandra database

Apache Cassandra is a scalable and high available database. TheHive supports the latest stable version  **3.11.x** of Cassandra.

### Install from repository

!!! Example ""
    === "Debian"
        
        1. Add Apache repository references

            ```bash
            curl -fsSL https://www.apache.org/dist/cassandra/KEYS | sudo apt-key add -
            echo "deb http://www.apache.org/dist/cassandra/debian 311x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list
            ```

        2. Install the package

            ```bash
            sudo apt update
            sudo apt install cassandra
            ```


    === "RPM"

        1. Add the Apache repository of Cassandra to `/etc/yum.repos.d/cassandra.repo`

            ```bash
            [cassandra]
            name=Apache Cassandra
            baseurl=https://downloads.apache.org/cassandra/redhat/311x/
            gpgcheck=1
            repo_gpgcheck=1
            gpgkey=https://downloads.apache.org/cassandra/KEYS
            ```

        2. Install the package

            ```bash
            yum install -y cassandra
            ```

    === "Other"

        Download and untgz archive from http://cassandra.apache.org/download/ in the folder of your choice.
    

By default, data is stored in `/var/lib/cassandra`.


### Configuration

Start by changing the `cluster_name` with `thp`. Run the command `cqlsh`: 
```
cqlsh localhost 9042
```

```bash
UPDATE system.local SET cluster_name = 'thp' where key='local';
```

Exit and then run:

```
nodetool flush
```

Configure Cassandra by editing `/etc/cassandra/cassandra.yaml` file.


```yml
# content from /etc/cassandra/cassandra.yaml

cluster_name: 'thp'
listen_address: 'xx.xx.xx.xx' # address for nodes
rpc_address: 'xx.xx.xx.xx' # address for clients
seed_provider:
    - class_name: org.apache.cassandra.locator.SimpleSeedProvider
      parameters:
          # Ex: "<ip1>,<ip2>,<ip3>"
          - seeds: 'xx.xx.xx.xx' # self for the first node
data_file_directories:
  - '/var/lib/cassandra/data'
commitlog_directory: '/var/lib/cassandra/commitlog'
saved_caches_directory: '/var/lib/cassandra/saved_caches'
hints_directory: 
  - '/var/lib/cassandra/hints'
```

Then restart the service:

!!! Example ""
    === "Debian"

        ```
        service cassandra restart
        ```

    === "RPM"

        Run the service and ensure it restart after a reboot:

        ```bash
        systemctl daemon-reload
        service cassandra start
        chkconfig cassandra on
        ```

        !!! Warning
            Cassandra service does not start well with the new systemd version. There is an existing issue and a fix on Apache website: [https://issues.apache.org/jira/browse/CASSANDRA-15273]()

By default Cassandra listens on `7000/tcp` (inter-node), `9042/tcp` (client).

#### Additional configuration

For additional configuration options, refer to:

- [Cassandra documentation page](https://cassandra.apache.org/doc/latest/getting_started/configuring.html)
- [Datastax documentation page](https://docs.datastax.com/en/ddac/doc/datastax_enterprise/config/configTOC.html)


#### Security

To add security measures in Cassandra , refer the the [related administration guide](../Administration/Cassandra_security.md).

#### Add nodes

To add Cassandra nodes, refer the the [related administration guide](../Administration/Clustering.md).

## Choose and install attachment storage

Files uploaded in TheHive (in *task logs* or in *observables*) can be stores in localsystem, in a Hadoop filesystem (recommended) or in the graph database.

For standalone production and test servers , we recommends using local filesystem. If you think about building a cluster with TheHive, you have several possible solutions: using Hadoop or S3 services ; see the related administration guide)[../Administration/Clustering.md] for more details and an example with MinIO servers.  

### Option 1: Local filesystem

!!! Note
    This option is perfect if you **do not** intend to build a cluster for your instance of TheHive 4.

To store files on the local filesystem, start by choosing the dedicated folder:

```bash
mkdir -p /opt/thp_data/files/thehive
```

This path will be used in the configuration of TheHive.

Later, after having installed TheHive, ensure the user `thehive` owns the path chosen for storing files:

```
chown -R thehive:thehive /opt/thp_data/files/thehive
```


### Option 2: S3 with Min.io

### Option 3: Hadoop

If you choose Hadoop distributed filesystem, proceed to installation of the software before configuring it.

#### Installation

- Download hadoop distribution from https://hadoop.apache.org/releases.html and uncompress.

```bash
cd /tmp
wget https://downloads.apache.org/hadoop/common/hadoop-3.1.3/hadoop-3.1.3.tar.gz
cd /opt
tar zxf /tmp/hadoop-3.1.3.tar.gz
ln -s hadoop-3.1.3 hadoop
```

- Create a user and update permissions

```bash
useradd hadoop
chown hadoop:root -R /opt/hadoop*
```

- Create a datastore and set permissions

```bash
mkdir /opt/thp_data/hdfs
chown hadoop:root -R /opt/thp_data/hdfs
```

- Create ssh keys for `hadoop` user:

```bash
su - hadoop
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
```

- Update `.bashrc`file for `hadoop` user. Add following lines:

```
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HADOOP_HOME/bin
export PATH=$PATH:$HADOOP_HOME/sbin
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export YARN_HOME=$HADOOP_HOME
```


**Note**: Apache has a well detailed [documentation](https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/SingleCluster.html) for more advanced configuration with Hadoop.


#### Configuration the Hadoop Master

Configuration files are located in `etc/hadoop` (`/opt/hadoop/etc/hadoop`). They must be identical in all nodes.

**Notes**:

- The configuration described there is for a single node server. This node is the master node, namenode and datanode (refer to [Hadoop documentation](https://hadoop.apache.org/docs/current/) for more information). After validating this node is running successfully, refer to the [related administration guide](../Administration/Clustering.md) to add nodes;
- Ensure you **update** the port value to something different than `9000` as it is already reserved for TheHive application service;


- Edit the file `core-site.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://thehive1:10000</value>
  </property>
  <property>
    <name>hadoop.tmp.dir</name>
    <value>/opt/thp_data/hdfs/temp</value>
  </property>
  <property>
    <name>dfs.client.block.write.replace-datanode-on-failure.best-effort</name>
    <value>true</value>
  </property>
</configuration>
```

- Edit the file `hdfs-site.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
  <property>
    <name>dfs.replication</name>
    <value>2</value>
  </property>
  <property>
    <name>dfs.namenode.name.dir</name>
    <value>/opt/thp_data/hdfs/namenode/data</value>
  </property>
  <property>
    <name>dfs.datanode.name.dir</name>
    <value>/opt/thp_data/hdfs/datanode/data</value>
  </property>
  <property>
    <name>dfs.namenode.checkpoint.dir</name>
    <value>/opt/thp_data/hdfs/checkpoint</value>
  </property>
  <property>
    <name>dfs.namenode.http-address</name>
    <value>0.0.0.0:9870</value>
  </property>
  <!--
  <property>
    <name>dfs.client.block.write.replace-datanode-on-failure.best-effort</name>
    <value>true</value>
  </property>
-->
  <property>
    <name>dfs.client.block.write.replace-datanode-on-failure.policy</name>
    <value>NEVER</value>
  </property>
</configuration>
```

#### Format the volume and start services

- Format  the volume

```bash
su - hadoop
cd /opt/hadoop
bin/hdfs namenode -format
```

#### Run it as a service

---

Create the `/etc/systemd/system/hadoop.service` file with the following content:

```
[Unit]
Description=Hadoop
Documentation=https://hadoop.apache.org/docs/current/index.html
Wants=network-online.target
After=network-online.target

[Service]
WorkingDirectory=/opt/hadoop
Type=forking

User=hadoop
Group=hadoop
Environment=JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
Environment=HADOOP_HOME=/opt/hadoop
Environment=YARN_HOME=/opt/hadoop
Environment=HADOOP_COMMON_HOME=/opt/hadoop
Environment=HADOOP_HDFS_HOME=/opt/hadoop
Environment=HADOOP_MAPRED_HOME=/opt/hadoop
Restart=on-failure

TimeoutStartSec=2min


ExecStart=/opt/hadoop/sbin/start-all.sh
ExecStop=/opt/hadoop/sbin/stop-all.sh

StandardOutput=null
StandardError=null

# Specifies the maximum file descriptor number that can be opened by this process
LimitNOFILE=65536

# Disable timeout logic and wait until process is stopped
TimeoutStopSec=0

# SIGTERM signal is used to stop the Java process
KillSignal=SIGTERM

# Java process is never killed
SendSIGKILL=no

[Install]
WantedBy=multi-user.target
```

#### Start the service

```bash
service hadoop start
```

You can check cluster status in [http://thehive1:9870](http://thehive1:9870/)

#### Add nodes

To add Hadoop nodes, refer the the [related administration guide](../Administration/Clustering.md).


## TheHive

This part contains instructions to install TheHive and then configure it.

!!! Warning
    TheHive4 can't be installed on the same server than older versions. We recommend installing it on a new server, especially if a migration is foreseen.

### Installation

All packages are published on our packages repository. We support Debian and RPM packages as well as binary packages (zip archive). All packages are signed using our GPG key [562CBC1C](https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY). Its fingerprint is `0CD5 AC59 DE5C 5A8E 0EE1  3849 3D99 BB18 562C BC1C`.

!!! Example ""

    === "Debian"
 
        ```bash
        curl https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY | sudo apt-key add -
        ```
 
    === "RPM"

        ```bash
        sudo rpm --import https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY
        ```

We also release stable and beta version of the applications.

#### Stable versions

Install TheHive 4.x package of the stable version by using the following commands:

!!! Example ""

    === "Debian"

        ```bash
        echo 'deb https://deb.thehive-project.org release main' | sudo tee -a /etc/apt/sources.list.d/thehive-project.list
        sudo apt-get update
        sudo apt-get install thehive4
        ```

    === "RPM"
        1. Setup your system to connect the RPM repository. Create and edit the file `/etc/yum.repos.d/thehive-project.repo`:

            ```bash
            [thehive-project]
            enabled=1
            priority=1
            name=TheHive-Project RPM repository
            baseurl=https://rpm.thehive-project.org/release/noarch
            gpgcheck=1
            ```

        2. Then install the package using `yum`:

            ```bash
            yum install thehive4
            ```
    
    === "Other"

        1. Download and unzip the chosen binary package. TheHive files can be installed wherever you want on the filesystem. In this guide, we assume you have chosen to install them under `/opt`.

        ```bash
        cd /opt
        wget https://download.thehive-project.org/thehive4-latest.zip
        unzip thehive4-latest.zip
        ln -s thehive4-x.x.x thehive
        ```

        2. Prepare the system

            It is recommended to use a dedicated, non-privileged user account to start TheHive. If so, make sure that the chosen account can create log files in `/opt/thehive/logs`.

            If you'd rather start the application as a service, use the following commands:

            ```bash
            addgroup thehive
            adduser --system thehive
            chown -R thehive:thehive /opt/thehive
            mkdir /etc/thehive
            touch /etc/thehive/application.conf
            chown root:thehive /etc/thehive
            chgrp thehive /etc/thehive/application.conf
            chmod 640 /etc/thehive/application.conf
            ```

            Copy the systemd script in `/etc/systemd/system/thehive.service`.

            ```bash
            cd /tmp
            wget https://github.com/TheHive-Project/TheHive/blob/master/package/thehive.service
            cp thehive.service /etc/systemd/system/thehive.service
            ```


#### Installing beta versions

To follow beta versions of TheHive4, use the following setup:

!!! Example ""

    === "Debian"

        ```bash
        echo 'deb https://deb.thehive-project.org beta main' | sudo tee -a /etc/apt/sources.list.d/thehive-project.list
        sudo apt-get update
        sudo apt-get install thehive4
        ```

    === "RPM"

        1. setup your system to connect the RPM repository. Create and edit the file `/etc/yum.repos.d/thehive-project.repo`:

            ```bash
            [thehive-project]
            enabled=1
            priority=1
            name=TheHive-Project RPM repository
            baseurl=https://rpm.thehive-project.org/beta/noarch
            gpgcheck=1
            ```

        2. Then install the package using `yum`:

            ```bash
            yum install thehive4
            ```

    === "Other"

        1. Download and unzip the chosen binary package. TheHive files can be installed wherever you want on the filesystem. In this guide, we assume you have chosen to install them under `/opt`.

            ```bash
            cd /opt
            wget https://download.thehive-project.org/thehive4-beta-latest.zip
            unzip thehive4-beta-latest.zip
            ln -s thehive4-x.x.x thehive
            ```
        
        2. Prepare the system

            It is recommended to use a dedicated, non-privileged user account to start TheHive. If so, make sure that the chosen account can create log files in `/opt/thehive/logs`.

            If you'd rather start the application as a service, use the following commands:

            ```bash
            addgroup thehive
            adduser --system thehive
            chown -R thehive:thehive /opt/thehive
            mkdir /etc/thehive
            touch /etc/thehive/application.conf
            chown root:thehive /etc/thehive
            chgrp thehive /etc/thehive/application.conf
            chmod 640 /etc/thehive/application.conf
            ```

            Copy the systemd script in `/etc/systemd/system/thehive.service`.

            ```bash
            cd /tmp
            wget https://github.com/TheHive-Project/TheHive/blob/master/package/thehive.service
            cp thehive.service /etc/systemd/system/thehive.service
            ```

!!! Warning

    We do not recommend that configuration for production servers.


### Configuration

Following configurations are required to start TheHive successfully:

- Secret key configuration
- Database configuration
- File storage configuration

#### Secret key configuration

!!! Example ""

    === "Debian"
        The secret key is automatically generated and stored in `/etc/thehive/secret.conf` by package installation script.

    === "RPM"
        The secret key is automatically generated and stored in `/etc/thehive/secret.conf` by package installation script.

    === "Other"
        Setup a secret key in the `/etc/thehive/secret.conf` file by running the following command:

        ```bash
        cat > /etc/thehive/secret.conf << _EOF_
        play.http.secret.key="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)"
        _EOF_
        ```

#### Database

To use Cassandra database, TheHive configuration file (`/etc/thehive/application.conf`) has to be edited and updated with following lines:

```yaml
db {
  provider: janusgraph
  janusgraph {
    storage {
      backend: cql
      hostname: [
        "127.0.0.1"
      ] # seed node ip addresses

      #username: "<cassandra_username>"       # login to connect to database (if configured in Cassandra)
      #password: "<cassandra_passowrd"

      cql {
        cluster-name: thp       # cluster name
        keyspace: thehive           # name of the keyspace
        local-datacenter: datacenter1   # name of the datacenter where TheHive runs (relevant only on multi datacenter setup)
        # replication-factor: 2 # number of replica
        read-consistency-level: ONE
        write-consistency-level: ONE
      }
    }
  }
}
```

#### Local filesystem

If you chose [Option 1: Local filesystem](#option:1_local_filesystem) to store files:

- Update permission of the folder

```bash
chown -R thehive:thehive /opt/thp_data/files/thehive
```

- add following lines to TheHive configuration file (`/etc/thehive/application.conf`)

```yml
storage {
  provider = localfs
  localfs.location = /opt/thp_data/files/thehive
}
```

#### S3


#### Hadoop

If you chose [Option 2: Hadoop](#option:3_hadoop) to store files in a distrubuted filesystem, add following lines to TheHive configuration file (`/etc/thehive/application.conf`)

```yaml
storage {
  provider: hdfs
  hdfs {
    root: "hdfs://thehive1:10000" # namenode server
    location: "/thehive"
    username: thehive
  }
}
```


### Run

Save configuration file and run the service:


```bash
service thehive start
```

Please note that the service may take some time to start. Once it is started, you may launch your browser and connect to `http://YOUR_SERVER_ADDRESS:9000/`.


## Advanced configuration

For additional configuration options, please refer to the [Administration Guide](../Administration/README.md).


