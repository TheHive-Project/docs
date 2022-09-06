# Advanced configuration

## Cache
### Performance
In order to increase Cortex performance, a cache is configured to prevent
repetitive database solicitation. Cache retention time can be configured for
users and organizations (default is 5 minutes). If a user is updated, the cache is
automatically invalidated.

### Analyzer Results
Analyzer results (job reports) can also be cached. If an analyzer is executed against the same observable,
the previous report can be returned without re-executing the analyzer. The cache is used only
if the second job occurs within `cache.job` (the default is 10 minutes).

!!! Example "" 
    ```
    cache {
      job = 10 minutes
      user = 5 minutes
      organization = 5 minutes
    }
    ```

!!! Notes

    1. The global `cache.job` value can be overridden for each analyzer in the analyzer configuration Web dialog
    2. it is possible to bypass the cache altogether (for example to get extra fresh results) through the API as explained in the [API Guide](../api/api-guide.md#run) or by setting the cache to *Custom* in the Cortex UI for each analyzer and specifying `0` as the number of minutes.

## Streaming (a.k.a The Flow)
The user interface is automatically updated when data is changed in the back-end. To do this, the back-end sends events to all the connected front-ends.
The mechanism used to notify the front-end is called long polling and its settings are:

 * `refresh` : when there is no notification, close the connection after this
 duration (the default is 1 minute).
 * `cache` : before polling a session must be created, in order to make sure no
 event is lost between two polls. If there is no poll during the cache setting,
 the session is destroyed (the default is 15 minutes).
 * `nextItemMaxWait`, `globalMaxWait` : when an event occurs, it is not
 immediately sent to the front-ends. The back-end waits nextItemMaxWait and up
 to globalMaxWait in case another event can be included in the notification.
 This mechanism saves many HTTP requests.

The default values are:

!!! Example "" 
    ```
    # Streaming
    stream.longpolling {
      # Maximum time a stream request waits for new element
      refresh = 1m
      # Lifetime of the stream session without request
      cache = 15m
      nextItemMaxWait = 500ms
      globalMaxWait = 1s
    }
    ```

### Entity Size Limit
The Play framework used by Cortex sets the HTTP body size limit to 100KB by default for textual content (json, xml, text, form data) and 10MB for file uploads. This could be too small in some cases so you may want to change it with the following settings in the `application.conf` file:

!!! Example "" 
    ```
    # Max textual content length
    play.http.parser.maxMemoryBuffer=1M
    # Max file size
    play.http.parser.maxDiskBuffer=1G
    ```

!!! Note
    if you are using a NGINX reverse proxy in front of Cortex, be aware that it doesn't distinguish between text data and a file upload. So, you should also set the `client_max_body_size` parameter in your NGINX server configuration to the highest value among the two: file upload and text size as defined in Cortex
    `application.conf` file.