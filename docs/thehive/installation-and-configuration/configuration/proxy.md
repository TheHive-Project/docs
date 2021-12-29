# Proxy settings

## Proxy for connectors

Refer to [Cortex](./connectors-cortex.md) or [MISP](./connectors-misp.md) configuration to setup specific proxy configuration for these remote services. 

## Proxy for global application

Proxy can be used. By default, the proxy configured in JVM is used but one can configured specific configurations for each HTTP client.

| Parameter                                | Type           | Description                          |
| -----------------------------------------| -------------- | ------------------------------------ |
| `wsConfig.proxy.host`                    | string         | The hostname of the proxy server |
| `wsConfig.proxy.port`                    | integer        | The port of the proxy server |
| `wsConfig.proxy.protocol`                | string         | The protocol of the proxy server.  Use "http" or "https".  Defaults to "http" if not specified |
| `wsConfig.proxy.user`                    | string         | The username of the credentials for the proxy server |
| `wsConfig.proxy.password`                | string         | The password for the credentials for the proxy server |
| `wsConfig.proxy.ntlmDomain`              | string         | The NTLM domain  | 
| `wsConfig.proxy.encoding`                | string         | The realm's charset | 
| `wsConfig.proxy.nonProxyHosts`           | list           | The list of hosts on which proxy must not be used |


