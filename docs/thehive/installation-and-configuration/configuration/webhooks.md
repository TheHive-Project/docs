# TheHive webhooks

TheHive can notify external system of modification events (case creation, alert update, task assignment, ...). To use webhooks notifications, 2 steps are required: configure a notification, and activate it.

## 1. Define webhook endpoints

The configuration can accept following parameters:

| Parameter                      | Type           | Description                          |
| -------------------------------| -------------- | ------------------------------------ |
| `name`                         | string         | the identifier of the endpoint. It is used when the webhook is setup for an organisation |
| `version`                      | integer        | defines the format of the message. If `version` is `0`, TheHive will send messages with the same format as TheHive3. Currently TheHive only supports version 0. |
| `wsConfig`                     | dict           | the configuration of HTTP client. It contains proxy, SSL and timeout configuration. |
| `auth`                         | dict           | the configuration of authenticationI. It contains type, and additional options. |
| `includedTheHiveOrganisations` | list of string | list of TheHive organisations which can use this endpoint (default: _all_ (`[*]`) |
| `excludedTheHiveOrganisations` | list of string | list of TheHive organisations which cannot use this endpoint (default: _None_ (`[]`) ) |

The following section should be added in `application.conf` : 

```yaml
## Webhook notification
notification.webhook.endpoints = [
  {
    name: local
    url: "http://127.0.0.1:5000/"
    version: 0
    wsConfig: {}
    auth: {type: "none"}
    includedTheHiveOrganisations: ["*"]
    excludedTheHiveOrganisations: []
  }
]
```

### Use a proxy

Wehbook call can go through a proxy, in which case, Webhooks configuration requires a `wsConfig` config

```yaml
notification.webhook.endpoints = [
  {
    name: local
    url: "http://127.0.0.1:5000/"
    version: 0
    {==wsConfig {==}
      {==proxy {==}
        {==host: "10.1.2.10"==}
        {==port: 8080==}
      {==}==}
    {==}==}
    auth: {
      type: "none"
    }
    includedTheHiveOrganisations: ["*"]
    excludedTheHiveOrganisations: []
  }
]
```

### Use an authentication method

Webhook endpoints can be authenticated, in this case, Webhook configuration requires a `auth` setting. Supported methods are:

=== "No Auth (Default)"

    ```yaml
      auth: { 
          type: "none" 
      }
    ```

=== "Basic Auth"

    ```yaml
      auth: { 
          type: "basic", 
          username: "foo", 
          password: "bar" 
      }
    ```

=== "Beared Auth"

    ```yaml
      auth: { 
          type: "bearer", 
          key: "foobar" 
      }
    ```

=== "Key Auth"

    ```yaml
      auth: { 
          type: "key", 
          key: "foobar" 
      }
    ```

!!! Warning
    In 4.1.0 release, the `auth` config is *REQUIRED*.

### Examples

!!! Example

    ```yaml
    ## Webhook notification
    notification.webhook.endpoints = [
      {
        name: local
        url: "http://127.0.0.1:5000/"
        version: 0
        wsConfig {
          proxy {
            host: "10.1.2.10"
            port: 8080
          }
        }
        auth: {
          type: "bearer",
          key: "API_KEY"
        }
        includedTheHiveOrganisations: ["ORG1", "ORG2"]
        excludedTheHiveOrganisations: ["ORG3"]
      }
    ]
    ```

## 2. Activate webhooks

This action must be done by an organisation admin (with permission `manageConfig`) and requires to run a `curl` command:


```bash
read -p 'Enter the URL of TheHive: ' thehive_url
read -p 'Enter your login: ' thehive_user
read -s -p 'Enter your password: ' thehive_password

curl -XPUT -u$thehive_user:$thehive_password -H 'Content-type: application/json' $thehive_url/api/config/organisation/notification -d '
{
  "value": [
    {
      "delegate": false,
      "trigger": { "name": "AnyEvent"},
      "notifier": { "name": "webhook", "endpoint": "local" }
    }
  ]
}'
```
