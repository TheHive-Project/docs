# Security in Apache Cassandra

!!! Note "References"
    Internal authentication
      
    - [https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/configuration/secureInternalAuthenticationTOC.html](https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/configuration/secureInternalAuthenticationTOC.html)
    
    Node to node encryption
    
    - [https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/configuration/secureSSLNodeToNode.html](https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/configuration/secureSSLNodeToNode.html)
    
    Client to node encryption
    
    - [https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/configuration/secureSSLClientToNode.html](https://docs.datastax.com/en/archived/cassandra/3.0/cassandra/configuration/secureSSLClientToNode.html)
    - [https://docs.janusgraph.org/basics/configuration-reference/#storagecqlssl](https://docs.janusgraph.org/basics/configuration-reference/#storagecqlssl)

## Authentication with Cassandra

!!! Example ""
    
    - Create an account and grant permissions on keyspace

      ```sql
      CREATE ROLE thehive WITH PASSWORD = 'thehive1234' AND LOGIN = true;
      GRANT ALL PERMISSIONS ON KEYSPACE thehive TO thehive;
      ```

    - Configure TheHive with the account 

    Update `/etc/thehive/application.conf` accordingly: 

      ```
      db.janusgraph {
        storage {
          ## Cassandra configuration
          # More information at https://docs.janusgraph.org/basics/configuration-reference/#storagecql
          backend: cql
          hostname: ["xxx.xxx.xxx.xxx"]
          # Cassandra authentication (if configured)
          {==username: "thehive" ==}
          {==password: "thehive1234" ==}
          cql {
            cluster-name: thp
            keyspace: thehive
          }
        }
      ```

## Cassandra node to node encryption

This document addresses communication between Cassandra servers, when a Cassandra cluster contains several nodes. 

!!! Example ""
    
    ```yaml
    server_encryption_options:
        internode_encryption: all
        keystore: /path/to/keystore.jks
        keystore_password: keystorepassword
        truststore: /path/to/truststore.jks
        truststore_password: truststorepassword
        # More advanced defaults below:
        protocol: TLS
        algorithm: SunX509
        store_type: JKS
        cipher_suites: [TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA,TLS_DHE_RSA_WITH_
    AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_R
    SA_WITH_AES_256_CBC_SHA]
        require_client_auth: false
    ```

### Cassandra dedicated port for SSL (optional)

Optionally, you can setup a dedicated port for SSL communication. Update `/etc/cassandra/cassandra.yml` configuration file on each node: 

```yaml
native_transport_port_ssl: 9142
```

!!! Note
    By doing so, all SSL communications will be done using this port. Without this parameter, SSL is setup on `native_transport_port`. (everything is explained in the `cassandra.yaml` configuration file).


## Client to node encryption


This guide explains how to secure connection between Cassandra server and Cassandra clients (TheHive). This document doesn’t address communication between Cassandra servers, when a Cassandra cluster contains several nodes. 

### Requirements 

The setup requires a valid X509 certificate for the Cassandra service. It must have standard properties of server certificate:

 - key usage: Digital Signature, Non Repudiation, Key Encipherment, Key Agreement
 - Extended Key Usage: TLS Web Server Authentication
 - Cert Type: SSL Server

It also must have a "Subject Alternative Name" with the identifier (DNS name or/and IP address) of the Cassandra server seen by the client.
The format of the certificate file is PKCS12 (file with extention p12).

Then create a truststore containing the certificate authority used to generate the certificate for Cassandra. The truststore must be in Java format (JKS). If you CA file is ca.crt, you can generate the truststore file with the following command:

```
keytool -import -file /path/to/ca.crt -alias CA -keystore ca.jks
```

This command ask a password for file integrity checking.

The command `keytool` is available in any JDK distribution.


### Configuring Cassandra

!!! Example ""
    Locate the section `client_encryption_options` and set the following options:

    ```yaml
    client_encryption_options:
        enabled: true
        # If enabled and optional is set to true encrypted and unencrypted connections are handled.
        optional: false
        keystore: /pat/to/keystore.jks
        keystore_password: keystorepassword
        require_client_auth: false
        # Set trustore and truststore_password if require_client_auth is true
        # truststore: conf/.truststore
        # truststore_password: cassandra
        # More advanced defaults below:
        protocol: TLS
        algorithm: SunX509
        store_type: JKS
        cipher_suites: [TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA,TLS_DHE_RSA_WITH_
    AES_128_CBC_SHA,TLS_DHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_R
    SA_WITH_AES_256_CBC_SHA]
    ```
    Then the service cassandra must be restarted.

### Configuring TheHive

!!! Example ""

    ```
    db.janusgraph {
      storage {
        ## Cassandra configuration
        # More information at https://docs.janusgraph.org/basics/configuration-reference/#storagecql
        backend: cql
        hostname: ["ip_node_1", "ip_node_2", "ip_node_3"]
        # Cassandra authentication (if configured)
        username: "thehive"
        password: "thehive1234"
        {==port: 9142 # if alternative port has been set in Cassandra configuration==}
        cql {
          cluster-name: thp
          keyspace: thehive
          {==ssl {==}
            {==enabled: true==}
            {==truststore {==}
              {==location: "/path/to/truststore.jks"==}
              {==password: "truststorepassword"==}
            {==}==}
          }
        }
      }
    ```
    Then the service thehive must be restarted.

