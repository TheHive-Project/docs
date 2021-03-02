# Fail2ban

## Adding TheHive into Fail2Ban

Considering **TheHive** logs sit in `/var/log/thehive/application.log` and **fail2ban ** configuration is in `/etc/fail2ban`:

!!! Example ""
    1. Add a filter file in `/etc/fail2ban/filter.d` named `thehive.conf` with the following content: 

        ```
        [INCLUDES]
        before = common.conf
        
        [Definition]
        failregex = ^.*- <HOST> (?:POST \/api\/login|GET .*) .*returned 401.*$
        ignoreregex =
        ```

        

    2. Add a jail file in `/etc/fail2ban/jail.d/`named `thehive.local` with the following content: 

        ```
        [thehive]
        enabled = true
        port = 80,443
        filter = thehive
        action = iptables-multiport[name=thehive, port="80,443"]
        logpath = /var/log/thehive/application.log
        maxretry = 5
        bantime = 14400
        findtime = 1200
        ```

        This will ban any IP address for 4 hours after 5 failed authentication are identified during a period of 20 min. 

    3. Reload the configuration with the command `fail2ban-client reload`


## Manage banned IP addresses

!!! Example ""
    - Review banned IP addresses: 

        ```bash
        fail2ban-client status thehive
        ```

    - Unban an IP address: 

        ```bash
        fail2ban-client set thehive unbanip <IP ADDRESS>
        ```

    

    

