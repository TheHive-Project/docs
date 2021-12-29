# SSL

## Server configuration

We recommend using a reverse proxy to manage SSL layer.

## Connectors 

Refer to [Cortex](./connectors-cortex.md) or [MISP](./connectors-misp.md) configuration to setup specific SSL configuration of these remote services. 


## Client configuration

SSL configuration might be requis required to connect remote services. Following parameters can be defined: 

| Parameter                                | Type           | Description                          |
| -----------------------------------------| -------------- | ------------------------------------ |
| `wsConfig.ssl.keyManager.stores`         | list           | Stores client certificates (see [#certificate-manager](#certificate-manager) )    |
| `wsConfig.ssl.trustManager.stores`       | list           | Stored custom Certificate Authorities (see [#certificate-manager](#certificate-manager) |
| `wsConfig.ssl.protocol`                  | string         | Defines a different default protocol (see [#protocols](#protocols)) |
| `wsConfig.ssl.enabledProtocols`          | list           | List of enabled protocols (see [#protocols](#protocols)) |
| `wsConfig.ssl.enabledCipherSuites`       | list           | List of enabled cipher suites (see [#ciphers](#ciphers)) |
| `wsConfig.ssl.loose.acceptAnyCertificate`| boolean        | Accept any certificates *true / false* |



### Certificate manager
Certificate manager is used to store client certificates and certificate authorities.

#### Custom Certificate Authority

##### Global configuration 

If setting up a custom Certificate Authority (to connect web proxies, remote services ...) is required globally in the application, the better solution consists of installing it on the OS and restarting TheHive. 

!!! Example ""

    === "Debian"

        ```bash
        apt-get install -y ca-certificates-java
        mkdir /usr/share/ca-certificates/extra
        cp mysctomcert.crt /usr/share/ca-certificates/extra
        dpkg-reconfigure ca-certificates
        service thehive restart
        ```


##### Use dedicated trust stores 

the other way, is to use the `trustManager` key in TheHive configuration. It is used to establish a secure connection with remote host. Server certificate must be signed by a trusted certificate authority.
```
  wsConfig.ssl.trustManager {
    stores = [
      {
        type: "JKS" // JKS or PEM
        path: "keystore.jks"
        password: "password1"
      }
    ]
  }
```

#### Client certificates

`keyManager` indicates which certificate HTTP client can use to authenticate itself on remote host (when certificate based authentication is used)
```
  wsConfig.ssl.keyManager {
    stores = [
      {
        type: "pkcs12" // JKS or PEM
        path: "mycert.p12"
        password: "password1"
      }
    ]
  }
```

### Protocols
If you want to define a different default protocol, you can set it specifically in the client:
```
wsConfig.ssl.protocol = "TLSv1.2"
```
If you want to define the list of enabled protocols, you can do so explicitly:
```
wsConfig.ssl.enabledProtocols = ["TLSv1.2", "TLSv1.1", "TLSv1"]
```


###  Ciphers
Cipher suites can be configured using `wsConfig.ssl.enabledCipherSuites`:


```
wsConfig.ssl.enabledCipherSuites = [
  "TLS_DHE_RSA_WITH_AES_128_GCM_SHA256",
  "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
  "TLS_DHE_RSA_WITH_AES_256_GCM_SHA384",
  "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
]
```

### Debugging
To debug the key manager / trust manager, set the following flags:
```
  wsConfig.ssl.debug = {
    ssl = true
    trustmanager = true
    keymanager = true
    sslctx = true
    handshake = true
    verbose = true
    data = true
    certpath = true
  }
```