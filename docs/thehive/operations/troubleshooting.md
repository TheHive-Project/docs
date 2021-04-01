# Troubleshooting 

For some issues, we need extra information in logs to troubleshoot and understand to root causes. To gather and share this, please read carefully and follow these steps.  

!!! Warning 
    **ENABLING TRACE LOGS HAS SIGNIFICANT IMPACT ON PERFORMANCES. DO NOT ENABLE IT ON PRODUCTION SERVERS. **


## Stop TheHive service and ensure it is stopped 

```bash
service thehive stop
```

Ensure the service is stopped with the following command: 

```bash
service thehive status
```



## Renew `application.log` file

- in `/var/log/thehive` move the file `application.log` to `application.log.bak`

```bash
mv /var/log/thehive/application.log /var/log/thehive/application.log.bak
```

## Update log configuration 

- Edit the file `/etc/thehive/logback.xml`. Look for the line containing `<logger name="org.thp" level="INFO"/>` and update it to have following lines:


```xml
    [..]
    <logger name="org.thp" level="TRACE"/>
    [..]
```

- Save the file.

## Restart the service

```bash
service thehive start
```

A new log file `/var/log/thehive/application.log` should be created and filed with a huge amount of logs. 

Wait for the issue to appear and/or the application stop.

## Save the logs

Copy the log file in a safe place. 

```
cp /var/log/thehive/application.log /root
```

## Share it with us

Create an issue on [Github](https://github.com/TheHive-Project/TheHive/issues/new?assignees=&labels=bug%2C+TheHive4&template=thehive4_bug_report.md&title=%5BBug%5D) and please share context and symptoms with the log file. Please add information regarding:

- Context:  
  - instance (single node/cluster, backend type, index engine)
  - System: Operating System, amount of RAM, #CPU for each server/node
- Symptoms: 
  - what you did, how you you come to this situation,  what happened
- The log file with traces


## Revert

To get back a to normal log configuration, stop thehive, update `logback.xml` file with the previous configuration, and restart the application.
