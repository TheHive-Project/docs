# Service

## Listen address & port

By default the application listens on all interfaces and port `9000`.  This is possible to specify listen address and ports with following parameters in the `application.conf` file: 

```
http.address=127.0.0.1
http.port=9000
```


## Context

If you are using a reverse proxy, and you want to specify a location (ex: `/thehive`), updating the configuration of TheHive is also required


!!! Example
    ```
    play.http.context: "/thehive"
    ```

## Specific configuration for streams

If you are using a reverse proxy like Nginx, you might receive error popups with the following message: _StreamSrv 504 Gateway Time-Out_. 

You need to change default setting for long polling refresh,  Set `stream.longPolling.refresh` accordingly.

!!! Example
    ```
    stream.longPolling.refresh: 45 seconds
    ```

## Manage content length

Content length of text and files managed by the application are limited by default. 

**Before TheHive v4.1.1**, the Play framework sets the HTTP body size limit to 100KB by default for textual content (json, xml, text, form data) and 10MB for file uploads.

**Since TheHive v4.1.1**, these values are set with default parameters: 

```yaml
# Max file size
play.http.parser.maxDiskBuffer: 128MB
# Max textual content length
play.http.parser.maxMemoryBuffer: 256kB
```

If you feel that these should be updated, edit `/etc/thehive/application.conf` file and update these parameters accordingly. 

!!! tip
    if you are using a NGINX reverse proxy in front of TheHive, be aware that it doesn't distinguish between text data and a file upload. 
    
    So, you should also set the `client_max_body_size` parameter in your NGINX server configuration to the highest value among the two: file upload and text size defined in TheHive application.conf file.