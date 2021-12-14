# Backup and restore

!!! Warning "**This guide has only been tested on single node Cassandra server**"

!!! Note References
    - [https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/operations/opsBackupRestore.html]()


## Overview

To be restored successfully, TheHive requires following data beeing saved: 

- The database
- Files
- optionnally, the index. 


## Cassandra

### Pre requisites

To backup or export database from Cassandra, following information are required: 

- Cassandra admin password
- keyspace used by thehive (default = `thehive`). This can be checked in the `application.conf`configuration file, in the database configuration in *storage*, *cql* and `keyspace` attribute. 

!!! Tip
    This information can be found in TheHive configuration: 

    ```
    [..]
    db.janusgraph {
        storage {
        backend: cql
        hostname: ["127.0.0.1"]

        cql {
            cluster-name: thp
            {==keyspace: thehive==} 
        }
        }
    [..]
    ```


### Backup

Following actions should be performed to backup the data successfully: 

- Save the database schema
- Create a snapshot
- Save the data and the schema


#### Save the database schema

This can be done with the following command: 

```bash
cqlsh -u cassandra -p <CASSANDRA_PASSWORD> <SERVER_IP> -e "DESCRIBE KEYSPACE <KEYSPACE>" > schema.cql
```

#### Create a snapshot and an archive

Considering that your keyspace is `thehive` and `backup_name` is the name of the snapshot, run the following commands:


1. Before taking snapshots

    ```bash
    nodetool cleanup thehive
    ```

2. Take a snapshot
 
    ```bash
    nodetool snapshot thehive -t backup_name
    ```

3. Create and archive with the snapshot data: 

    ```bash
    tar cjf backup.tbz /var/lib/cassandra/data/thehive/*/snapshots/backup_name/
    ```

4. Remove old snapshots (if necessary)

    ```bash
    nodetool -h localhost -p 7199 clearsnapshot -t <snapshotname>
    ```


#### Example

!!! Example "Example of script to generate backups of TheHive keyspace"


    ```bash
    #!/bin/bash

    ## Create a CQL file with the schema of the KEYSPACE
    ## and an tbz archive containing the snapshot

    ## Complete variables before running:
    ## KEYSPACE: Identify the right keyspace to save in cassandra
    ## SNAPSHOT: choose a name for the backup

    IP=10.1.1.1
    SOURCE_KEYSPACE=thehive
    SNAPSHOT=thehive_20211124
    SNAPSHOT_INDEX=1

    # Backup Cassandra

    nodetool cleanup ${SOURCE_KEYSPACE}

    nodetool snapshot ${SOURCE_KEYSPACE}  -t ${SNAPSHOT}_${SNAPSHOT_INDEX}

    echo -n "Cassandra admin password":
    read -s CASSANDRA_PASSWORD

    ## Save schema
    cqlsh -u cassandra -p ${CASSANDRA_PASSWORD} ${IP} -e "DESCRIBE KEYSPACE ${SOURCE_KEYSPACE}" > schema_${SNAPSHOT}_${SNAPSHOT_INDEX}.cql

    ## Create archive
    if [[ $? == 0 ]]
    then
    tar cjf ${SNAPSHOT}_${SNAPSHOT_INDEX}.tbz /var/lib/cassandra/data/${SOURCE_KEYSPACE}/*/snapshots/${SNAPSHOT}_${SNAPSHOT_INDEX}/
    fi
    ```

### Restore data

#### Pre requisites

Following data is required to restore TheHive database successfully: 

- The database schema (example: `schema.cql`)
- A backup of the database (example: `backup.tbz`)
- Keyspace to restore does not exist in the database (or it will be overwritten)

#### Restore 

1. Restore keyspace

    ```bash
    cqlsh -u cassandra -p <CASSANDRA_PASSWORD> <IP> -e "source 'schema.cql';"
    ```

2. Unarchive backup files: 

    ```bash
    tar jxf /PATH/TO/backup.tbz -C /tmp/cassandra_backup
    ```

3. And restore snapshots files:

    ```bash
    cd /var/lib/cassandra/data/thehive

    for I in `ls /tmp/cassandra/var/lib/cassandra/data/<KEYSPACE>`  ; do cp /tmp/cassandra/var/lib/cassandra/data/<KEYSPACE>/$I/snapshots/<BACKUP_NAME>/* /var/lib/cassandra/data/<KEYSPACE>/$I/ ; done

    ```

4. Ensure Cassandra user keep ownership on the files: 

    ```bash
    chown -R cassandra:cassandra /var/lib/cassandra/data/<KEYSPACE>
    ```

5. Refresh tables

    ```bash
    for TABLE in `ls /var/lib/cassandra/data/<KEYSPACE>`
    do 
        sstableloader -d <IP> /var/lib/cassandra/data/<KEYSPACE>/<TABLE>
    done
    ```


!!! Warning "Ensure no Commitlog file exist before restarting Cassandra service. (`/var/lib/cassandra/commitlog`)"


!!! Example "Example of script to restore TheHive keyspace in Cassandra"

    ```bash
    #!/bin/bash

    ## Restore a KEYSPACE and its data from a CQL file with the schema of the
    ## KEYSPACE and an tbz archive containing the snapshot

    ## Complete variables before running:
    ## IP: IP of cassandra server
    ## TMP: choose a TMP folder !!! this folder will be removed if exists.
    ## SOURCE_KEYSPACE: KEYSPACE used in the backup
    ## TARGET_KEYSPACE: new KEYSPACE name ; use same name of SOURCE_KEYSPACE if no changes
    ## SNAPSHOT: choose a name for the backup
    ## SNAPSHOT_INDEX: index of the snapshot (1, 20210401 ...)

    IP=10.1.1.1
    TMP=/tmp/cassandra_backup
    SOURCE_KEYSPACE="thehive"
    TARGET_KEYSPACE=""
    SNAPSHOT="thehive_20211124"
    SNAPSHOT_INDEX="1"

    ## Uncompress data in TMP folder
    rm -rf ${TMP} && mkdir ${TMP} 
    tar jxf ${SNAPSHOT}_${SNAPSHOT_INDEX}.tbz -C ${TMP}

    ## Read Cassandra password
    echo -n "Cassandra admin password: " 
    read -s CASSANDRA_PASSWORD

    ## Define new KEYSPACE NAME
    sed -i "s/${SOURCE_KEYSPACE}/${TARGET_KEYSPACE}/g" schema_${SNAPSHOT}_${SNAPSHOT_INDEX}.cql

    ## Restore keyspace
    cqlsh -u cassandra -p ${CASSANDRA_PASSWORD} cassandra --file schema_${SNAPSHOT}_${SNAPSHOT_INDEX}.cql

    ## Restore data
    for TABLE in `cqlsh -u cassandra -p ${CASSANDRA_PASSWORD} ${IP} -e "use ${TARGET_KEYSPACE}; DESC tables ;"`
    do
    cp -r ${TMP}/var/lib/cassandra/data/${SOURCE_KEYSPACE}/${TABLE}-*/snapshots/${SNAPSHOT}_${SNAPSHOT_INDEX}/* /var/lib/cassandra/data/${TARGET_KEYSPACE}/$TABLE-*/
    done

    ## Change ownership
    chown -R cassandra:cassandra /var/lib/cassandra/data/${TARGET_KEYSPACE}


    ## sstableloader
    for TABLE in `ls /var/lib/cassandra/data/${TARGET_KEYSPACE}`
    do 
        sstableloader -d ${IP} /var/lib/cassandra/data/${TARGET_KEYSPACE}/${TABLE}
    done

    ```

## Files

### Backup

Wether you use local or distributed files system storage, copy the content of the folder/bucket.

### Restore

Restore the saved files into the destination folder/bucket that will be used by TheHive.