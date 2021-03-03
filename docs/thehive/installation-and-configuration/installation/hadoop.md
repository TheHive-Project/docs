# Hadoop: installation and configuration

This guide proposes an example of installation and configuration of [Apache Hadoop](https://hadoop.apache.org/).


## Installation

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
mkdir /opt/thp/thehive/hdfs
chown hadoop:root -R /opt/thp/thehive/hdfs
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


## Configuration the Hadoop Master

Configuration files are located in `etc/hadoop` (`/opt/hadoop/etc/hadoop`). They must be identical in all nodes.

**Notes**:

- The configuration described there is for a single node server. This node is the master node, namenode and datanode (refer to [Hadoop documentation](https://hadoop.apache.org/docs/current/) for more information). After validating this node is running successfully, refer to the [related guide](../architecture/3_nodes_cluster.md) to add nodes;
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
    <value>/opt/thp/thehive/hdfs/temp</value>
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
    <value>/opt/thp/thehive/hdfs/namenode/data</value>
  </property>
  <property>
    <name>dfs.datanode.name.dir</name>
    <value>/opt/thp/thehive/hdfs/datanode/data</value>
  </property>
  <property>
    <name>dfs.namenode.checkpoint.dir</name>
    <value>/opt/thp/thehive/hdfs/checkpoint</value>
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

## Format the volume and start services

- Format  the volume

```bash
su - hadoop
cd /opt/hadoop
bin/hdfs namenode -format
```

## Run it as a service

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

## Start the service

```bash
service hadoop start
```

You can check cluster status in [http://thehive1:9870](http://thehive1:9870/)

## Add nodes

To add Hadoop nodes, refer the the [related guide](../architecture/3_nodes_cluster.md).
