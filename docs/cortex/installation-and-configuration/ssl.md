# Configure SSL

## Connect Cortex using HTTPS

We recommend using a reverse proxy to manage SSL layer; for example, Nginx. 

!!! Example ""

    === "Nginx"

        **Reference**: [Configuring HTTPS servers](https://nginx.org/en/docs/http/configuring_https_servers.html) on [nginx.org](https://nginx.org)

        ```title="/etc/nginx/sites-available/cortex.conf"
        server {
          listen 443 ssl http2;
          server_name cortex;

          ssl on;
          ssl_certificate       path-to/cortex-server-chained-cert.pem;
          ssl_certificate_key   path-to/cortex-server-key.pem;

          proxy_connect_timeout   600;
          proxy_send_timeout      600;
          proxy_read_timeout      600;
          send_timeout            600;
          client_max_body_size    2G;
          proxy_buffering off;
          client_header_buffer_size 8k;

          location / {
            add_header              Strict-Transport-Security "max-age=31536000; includeSubDomains";
            proxy_pass              http://127.0.0.1:9001/;
            proxy_http_version      1.1;
          }
        }
        ```


### Certificate manager
Certificate manager is used to store client certificates and certificate authorities.

#### Use custom Certificate Authorities

The prefered way to use custom Certificate Authorities is to use the system configuration. 

If setting up a custom Certificate Authority (to connect web proxies, remote services like LPAPS server ...) is required globally in the application, the better solution consists of installing it on the OS and restarting Cortex. 

!!! Example ""

    === "Debian"

        Ensure the package `ca-certificates-java` is installed , and copy the CA certificate in the right folder. Then run `dpkg-reconfigure ca-certificates` and restart Cortex service. 

        ```bash
        apt-get install -y ca-certificates-java
        mkdir /usr/share/ca-certificates/extra
        cp mycustomcert.crt /usr/share/ca-certificates/extra
        dpkg-reconfigure ca-certificates
        service cortex restart
        ```

    === "RPM"

        No additionnal packages is required on Fedora or RHEL. Copy the CA certificate in the right folder, run `update-ca-trust` and restart Cortex service.

          ```bash
          cp mycustomcert.crt /etc/pki/ca-trust/source/anchors
          sudo update-ca-trust 
          service cortex restart
          ```
