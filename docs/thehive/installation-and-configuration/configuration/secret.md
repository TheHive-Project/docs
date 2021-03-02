# `secret.conf` file

This file contains a secret that is used to define cookies used to manage the users session. As a result, one instance of TheHive should use a unique secret key. 



!!! Example

    ```yaml
    ## Play secret key
    play.http.secret.key="dgngu325mbnbc39cxas4l5kb24503836y2vsvsg465989fbsvop9d09ds6df6"
    ```


!!! Warning
    In the case of a **cluster** of TheHive nodes, **all nodes should have the same `secret.conf` file** with the same secret key. The secret is used to generate user sessions.
