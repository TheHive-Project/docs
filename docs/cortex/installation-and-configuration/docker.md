# Parameters for Docker

## list of options

- `docker.container.capAdd`: (array of string) Add Linux capabilities
- `docker.container.capDrop`: (array of string) Drop Linux capabilities
- `docker.container.cgroupParent`: (string) Cgroup to run a container in
- `docker.container.cpuPeriod`: (integer) Limit the CPU CFS (Completely Fair Scheduler) period
- `docker.container.cpuQuota`: (integer) Limit the CPU CFS (Completely Fair Scheduler) quota
- `docker.container.dns`: (array of string) Set custom dns servers for the container
- `docker.container.dnsSearch`: (array of string) Search list for host-name lookup.
- `docker.container.extraHosts`: (array of string) Add a line to /etc/hosts (host:IP)
- `docker.container.kernelMemory`: (integer) Kernel memory limit
- `docker.container.memoryReservation`: (integer) Memory soft limit
- `docker.container.memory`: (integer) Memory limit
- `docker.container.memorySwap`: (integer) Total memory limit (memory + swap)
- `docker.container.memorySwappiness`: (integer) Tune a container’s memory swappiness behavior. Accepts an integer between 0 and 100
- `docker.container.networkMode`: (string) name of the network
- `docker.container.privileged`: (boolean) Give extended privileges to this container
- `job.directory`: (string) Folder used by Cortex binary inside the container to share input and output data of Analyzers & Responders
- `job.dockerDirectory` = (string) Folder on the host used by Analyzers & Responders to share input and output data with Cortex

## Dockerized analyzers / responders

To run Analyzers&Responders as docker images, use our available catalogs to register them.

In Cortex configuration file, update `analyzer.urls` and `responder.urls` and tell Cortex how to find analyzers and responders. These settings accept:
   - a path to a directory where workers are installed (like previous version of Cortex)
   - a path or an url (http(s)) to a JSON file containing all worker definitions (merge of all JSON in one array)

If you want to use dockerized analyzers, you can add the following urls:
 - [analyzers-stable.json](https://download.thehive-project.org/analyzers-stable.json) (once used, analyzer is never updated) 
 - [analyzers.json](https://download.thehive-project.org/analyzers.json) (updated when new version is released)
 - [analyzers-devel.json](https://download.thehive-project.org/analyzers-devel.json) (updated at each commit, used for development)

For responders urls are:
  - [responders-stable.json](https://download.thehive-project.org/responders-stable.json) (once used, analyzer is never updated)
  - [responders.json](https://download.thehive-project.org/responders.json) (updated when new version is released)
  - [responders-devel.json](https://download.thehive-project.org/responders-devel.json) (updated at each commit, used for development)