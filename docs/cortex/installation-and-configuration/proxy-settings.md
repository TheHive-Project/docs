# Proxy settings

## Make Cortex use a HTTP proxy server

Basically, Cortex required to connect to Internet, especially to gather  catalogs of docker images of public Analyzers & Responders.

!!! Example "" 

    ```yaml title="/etc/cortex/application.conf"
    [..]
    play.ws.proxy {
      host = http://PROXYSERVERADDRESS:PORT
      port = http://PROXYSERVERADDRESS:PORT
    }
    [..]
    ```


## Operating System

!!! Example ""

    ```title="/etc/environment"
    export http_proxy=http://PROXYSERVERADDRESS:PORT
    export https_proxy=http://PROXYSERVERADDRESS:PORT  
    ```

!!! Example "Specific configuration for Debian _apt_ application"

    ```title="/etc/apt/apt.conf.d/80proxy" 
      HTTP::proxy "http://PROXYSERVERADDRESS:PORT";
      HTTPS::proxy "http://PROXYSERVERADDRESS:PORT";
    ```


## pip

If Analyzers and Responders requirements have to be installed on the host, and the host is behind a proxy server, configure the _pip_ command to use the proxy server ; use the option `--proxy http://PROXYSERVERADDRESS:PORT"`, and ` --cert path/to/cacert.pem` if a custom certificate is used by the proxy.

!!! Example "" 

    ```
    pip3 install --proxy http://PROXYSERVERADDRESS:PORT" -r analyzers/*/requirements.txt
    ```

    or 

    ```
    pip3 install --proxy http://PROXYSERVERADDRESS:PORT" --cert path/to/cacert.pem -r analyzers/*/requirements.txt
    ```



## Git

!!! Example ""

    ```bash
    sudo git config --global http.proxy http://PROXYSERVERADDRESS:PORT
    sudo git config --global https.proxy http://PROXYSERVERADDRESS:PORT
    ```

## Docker
If using Analyzers & Responders as docker images, setting up proxy parameters could be required to download images.

!!! Example ""

    Update Docker engine configuration by editing/creating the file `/etc/systemd/system/docker.service.d/http-proxy.conf`: 

    ```title="/etc/systemd/system/docker.service.d/http-proxy.conf" 
    [Service]
    Environment=http://PROXYSERVERADDRESS:PORT"
    Environment="http://PROXYSERVERADDRESS:PORT"
    ```

    Then run: 

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    ```
