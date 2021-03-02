# Akka server

!!! Quote
    Akka is a toolkit for building highly concurrent, distributed, and resilient message-driven applications for Java and Scala

    -- [https://akka.io/](https://akka.io/)

Akka is mainly used to make several nodes of TheHive work together and offer a smooth user experience. 

A good cluster setup requires at least 3 nodes of THeHive applications. For each node, Akka must be configured like this: 

```yaml
## Akka server
akka {
  cluster.enable = on
  actor {
    provider = cluster
  }
  remote.artery {
    canonical {
      hostname = "<HOSTNAME OR IP_ADDRESS>"
      port = 2551
    }
  }
# seed node list contains at least one active node
  cluster.seed-nodes = [ "akka://application@HOSTNAME1:2551", "akka://application@HOSTNAME2:2551", "akka://application@HOSTNAME3:2551" ]
}
```

with:

- `remote.artery.hostname` containing the hostname or IP address of the node,
- `cluster.seed-nodes` containing the list of akka nodes and **beeing the same on all nodes** 


!!! Example

    === "Node 1"

        Akka configuration for Node 1:

        ```yaml
        akka {
            cluster.enable = on
            actor {
            provider = cluster
            }
            remote.artery {
            canonical {
                {==hostname = "10.1.2.1"==}
                port = 2551
            }
            }
            # seed node list contains at least one active node
            cluster.seed-nodes = [ "akka://application@10.1.2.1:2551", "akka://application@10.1.2.2:2551", "akka://application@10.1.2.3:2551" ]
        }
        ```


    === "Node 2"

        Akka configuration for Node 2:

        ```yaml
        akka {
            cluster.enable = on
            actor {
            provider = cluster
            }
            remote.artery {
            canonical {
                {==hostname = "10.1.2.2"==}
                port = 2551
            }
            }
            # seed node list contains at least one active node
            cluster.seed-nodes = [ "akka://application@10.1.2.1:2551", "akka://application@10.1.2.2:2551", "akka://application@10.1.2.3:2551" ]
        }
        ```

    === "Node 3"

        Akka configuration for Node 3:

        ```yaml
        akka {
            cluster.enable = on
            actor {
            provider = cluster
            }
            remote.artery {
            canonical {
                {==hostname = "10.1.2.3"==}
                port = 2551
            }
            }
            # seed node list contains at least one active node
            cluster.seed-nodes = [ "akka://application@10.1.2.1:2551", "akka://application@10.1.2.2:2551", "akka://application@10.1.2.3:2551" ]
        }
        ```