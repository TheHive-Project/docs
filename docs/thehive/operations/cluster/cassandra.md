# Cassandra cluster operations
## Add a node
You can add a Cassandra node in an existing cluster without downtime.

 - Install a new node with the same configuration file except for `listen_address` and `rpc_address`. Set the first node IP in the seeds (`seed_provider`/`parameters`/`seeds`).
 - Start the node
 - Check the cluster status
```
# nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens  Owns (effective)  Host ID                               Rack 
UN  172.24.0.2  3.68 GiB   256      100.0%            048a870f-d6d5-405e-8d0d-43dbc12be747  rack1
UJ  172.24.0.3  89.54 MiB  256      ?                 f192ef8f-a4fd-4e24-99a7-0f92605a7cb6  rack1
```
Then when the node is fully operationnal:
```
# nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load      Tokens  Owns (effective)  Host ID                               Rack 
UN  172.24.0.2  3.68 GiB  256      48.8%             048a870f-d6d5-405e-8d0d-43dbc12be747  rack1
UN  172.24.0.3  1.91 GiB  256      51.2%             f192ef8f-a4fd-4e24-99a7-0f92605a7cb6  rack1
```
## Increase replication factor
When you have more than one node, you can increase the replication factor. This increase the number of copies and thus the cluster is more tolerent to hardware fault. The more copies there are, the more data is used on disk and the more resilient is the cluster, but the write access could be slower.

To increate the replication factor, connect to Cassandra using `cqlsh` and type (`thehive` is the name of the keyspace defined in application.conf):
```sql
ALTER KEYSPACE thehive WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 3 };
```
Then, on each Cassandra nodes, run a `nodetool repair -full`

It is recommended to increase replication factor for system keyspaces.
You can display current value with the following query:
```sql
SELECT * FROM system_schema.keyspaces;

 keyspace_name      | durable_writes | replication
--------------------+----------------+-------------------------------------------------------------------------------------
        system_auth |           True | {'class': 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '2'}
      system_schema |           True |                             {'class': 'org.apache.cassandra.locator.LocalStrategy'}
 system_distributed |           True | {'class': 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '2'}
             system |           True |                             {'class': 'org.apache.cassandra.locator.LocalStrategy'}
      system_traces |           True | {'class': 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '2'}
            thehive |           True | {'class': 'org.apache.cassandra.locator.SimpleStrategy', 'replication_factor': '2'}
```

## Remove an alive node
First ensure that the replication factor is compatible with the target number of nodes. If it is not the case, you can update replication factor.

Then run in the node you want to remove:
```
# nodetool decommission
```

## Remove a dead node
If a node has crash and cannot be repaired, you can remove it from a cluster with the command `nodetool removenode` followed by the node id:
```
# nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load      Tokens  Owns (effective)  Host ID                               Rack 
DN  172.24.0.4  3.69 GiB  256      72.9%             c0a96997-ea44-469e-a3e7-5660ed566ff6  rack1
UN  172.24.0.2  5.04 GiB  256      67.8%             048a870f-d6d5-405e-8d0d-43dbc12be747  rack1
UN  172.24.0.3  2.27 GiB  256      59.4%             9d5e4130-8fe0-4626-83eb-a059c5ec2872  rack1

# nodetool removenode c0a96997-ea44-469e-a3e7-5660ed566ff6
# nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load      Tokens  Owns (effective)  Host ID                               Rack 
UN  172.24.0.2  6.61 GiB  256      100.0%            048a870f-d6d5-405e-8d0d-43dbc12be747  rack1
UN  172.24.0.3  3.93 GiB  256      100.0%            9d5e4130-8fe0-4626-83eb-a059c5ec2872  rack1
```
