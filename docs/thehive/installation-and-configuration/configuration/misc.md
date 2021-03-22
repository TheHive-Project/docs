# Miscelleneous settings

## Manage content lengh

Content length of text and files managed by the application are limited by default. Before TheHive 4.1.1, they were set to very small values.
Default values in TheHive 4.1.1 are set with these default parameters: 

```
play.http.parser.maxDiskBuffer: 128MB
play.http.parser.maxMemoryBuffer: 256kB
```

If you feel that these should be updated, edit `/etc/thehive/application.conf` file and update these parameters. 


