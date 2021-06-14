# Cluster

!!! Quote
    Akka is a toolkit for building highly concurrent, distributed, and resilient message-driven applications for Java and Scala

    -- [https://akka.io/](https://akka.io/)

Akka is used to make several nodes of TheHive work together and offer a smooth user experience. 

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


!!! Example "Configuration of a Cluster with 3 nodes"

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


## SSL/TLS

Akka supports SSL/TLS to encrypt communications between nodes. A typical configuration with SSL support : 

```yaml
## Akka server
akka {
  cluster.enable = on
  actor {
    provider = cluster
  }
  remote.artery {
    transport = tls-tcp
    canonical {
      hostname = "<HOSTNAME OR IP_ADDRESS>"
      port = 2551
    }

    ssl.config-ssl-engine {
      key-store = "<PATH TO KEYSTORE>"
      trust-store = "<PATH TO TRUSTSTORE>"

      key-store-password = "chamgeme"
      key-password = "chamgeme"
      trust-store-password = "chamgeme"

      protocol = "TLSv1.2"
    }
  }
# seed node list contains at least one active node
  cluster.seed-nodes = [ "akka://application@HOSTNAME1:2551", "akka://application@HOSTNAME2:2551", "akka://application@HOSTNAME3:2551" ]
}
```

!!! Note
    Note that `akka.remote.artery.transport` has changed and `akka.ssl.config-ssl-engine` needs to be configured.
    
    **Reference**: [https://doc.akka.io/docs/akka/current/remoting-artery.html#remote-security](https://doc.akka.io/docs/akka/current/remoting-artery.html#remote-security)

!!! Warning "About Certificates"
    Use your own internal PKI, or `keytool` commands to generate your certificates.
    
    **Reference**: [https://lightbend.github.io/ssl-config/CertificateGeneration.html#using-keytool](https://lightbend.github.io/ssl-config/CertificateGeneration.html#using-keytool)

    Your server certificates should contain various _KeyUsage_ and _ExtendedkeyUsage_ extensions to make everything work properly:
        
    - _KeyUsage_ extensions
        - `nonRepudiation`
        - `dataEncipherment`
        - `digitalSignature`
        - `keyEncipherment`
    - _ExtendedkeyUsage_ extensions
        - `serverAuth`
        - `clientAuth`




!!! Example "Akka configuration with SSL for Node 1"

    ```yaml
    ## Akka server
    akka {
      cluster.enable = on
      actor {
        provider = cluster
      }
      remote.artery {
        {==transport = tls-tcp==}
        canonical {
          hostname = "10.1.2.1"
          port = 2551
        }

        ssl.config-ssl-engine {
          key-store = "/etc/thehive/application.conf.d/certs/10.1.2.1.jks"
          trust-store = "/etc/thehive/application.conf.d/certs/internal_ca.jks"

          key-store-password = "chamgeme"
          key-password = "chamgeme"
          trust-store-password = "chamgeme"

          protocol = "TLSv1.2"
        }
      }
    # seed node list contains at least one active node
      cluster.seed-nodes = [ "akka://application@10.1.2.1:2551", "akka://application@10.1.2.2:2551", "akka://application@10.1.2.3:2551" ]
    }
    ```

    Apply the same principle for the other nodes, and restart all services.