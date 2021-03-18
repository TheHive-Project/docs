# Backup and restore

!!! Note "References"

- [https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/operations/opsBackupRestore.html]()



!!! Warning "**This guide has only been tested on single node Cassandra server**"


## Cassandra

### Backup

To backup or export database from Cassandra, following information are required: 

- Cassandra admin password

- keyspace used by thehive (default = `thehive`). This can be checked in the `application.conf`configuration file, in the database configuration in *storage*, *cql* and `keyspace` attribute. 

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

Considering that your keyspace is `thehive` and `backup_name` is the name of the snapshot, run the following commands:

!!! Example ""
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

    4. Remove old snapshots

        ```bash
        nodetool -h localhost -p 7199 clearsnapshot -t <snapshotname>
        ```



### Restore

!!! Example ""
    1. Unarchive backup files: 

        ```bash
        tar jxf /PATH/TO/backup.tbz -C /
        ```

    2. And restore snapshots files:

        ```bash
        cd /var/lib/cassandra/data/thehive

        for I in `ls /var/lib/cassandra/data/thehive`  ; do cp /var/lib/cassandra/data/thehive/$I/snapshots/backup_name/* /var/lib/cassandra/data/thehive/$I/ ; done

        ```

    3. Ensure Cassandra user keep ownership on the files: 

        ```bash
        chown -R cassandra:cassandra /var/lib/cassandra/data/thehive
        ```

    4. Restart services

        ```bash
        service cassandra restart
        service thehive restart
        ```

!!! Warning "Ensure no Commitlog file exist before restarting Cassandra service. (`/var/lib/cassandra/commitlog`)"

