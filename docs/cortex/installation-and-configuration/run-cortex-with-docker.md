### Docker
To use the Docker image, you must use [Docker](https://www.docker.com/) (courtesy of Captain Obvious). Alternatively, it's also possible to run the image using [Podman](https://podman.io/).

By default, the docker image generate a configuration file for Cortex with:
 - the Elasticsearch uri is determined by resolving the host name "elasticsearch",
 - the [analyzers](https://download.thehive-project.org/analyzers.json) and [responders](https://download.thehive-project.org/responders.json) official location,
 - a generated secret (used to protect the user sessions).
The behaviour of the Cortex Docker image can be customized using environment variables or parameters:

| Parameter            | Env variable         | Description                                       |
|----------------------|----------------------|---------------------------------------------------|
| `--no-config`        | `no_config=1`        | Do not configure Cortex                           |
| `--no-config-secret` | `no_config_secret=1` | Do not add the random secret to the configuration |
| `--no-config-es` | `no_config_es=1` | do not add elasticsearch hosts to configuration
| `--es-uri <uri>` | `es_uri=<uri>` | use this string to configure elasticsearch hosts (format: http(s)://host:port,host:port(/prefix)?querystring)
| `--es-hostname <host>` | `es_hostname=host` | resolve this hostname to find elasticsearch instances
| `--secret <secret>` | `secret=<secret>` | secret to secure sessions
| `--show-secret` | `show_secret=1` | show the generated secret
| `--job-directory <dir>` | `job_directory=<dir>` | use this directory to store job files
| `--docker-job-directory <dir>` | `docker_job_directory=<dir>` | indicate the job directory in the host (not inside container)
| `--analyzer-url <url>` | `analyzer_urls=<url>,<url>,...` | where analyzers are located (url or path)
| `--responder-url <url>` | `responder_urls=<url>,<url>,...` | where responders are located (url or path)
| `--start-docker` | `start_docker=1` | start an internal docker (inside container) to run analyzers/responders
| `--daemon-user <user>` | `daemon_user=<user>` | run cortex using this user

At the end of the generated configuration, the file `/etc/cortex/application.conf` is included. Thus you can override any setting by binding your own `application.conf` into this file:

!!! Example ""
    ```
    docker run --volume /path/to/my/application.conf:/etc/cortex/application.conf thehiveproject/cortex:latest --es-uri http://elasticsearch.local:9200
    ```

Cortex uses docker to run analyzers and responders. If you run Cortex inside a docker, you can:

 - give Cortex access to docker service or podman service (recommended solution)
 - start a docker service inside Cortex docker container

#### Cortex uses main docker service
In order to use docker service the docker socket must be bound into Cortex container. Moreover, as Cortex shares files with analyzers, a folder must be bound between them.

!!! Example ""
    ```
    docker run --volume /var/run/docker.sock:/var/run/docker.sock --volume /var/run/cortex/jobs:/tmp/cortex-jobs thehiveproject/cortex:latest --job-directory /tmp/cortex-jobs --docker-job-directory /var/run/cortex/jobs
    ```

Cortex can instantiate docker container by using the docker socket `/var/run/docker.sock`. The folder `/var/run/cortex/jobs` is used to store temporary file of jobs. The folder `/tmp/cortex-jobs` is job folder inside the docker. In order to make job file visible to analyzer docker, Cortex needs to know both folders (parameters `--job-directory` and `-docker-job-directory`). On most cases, job directories are the same and `--docker-job-directory` can be omitted.

If you run Cortex in Windows, the docker service is accessible through the named pipe `\\.\pipe\docker_engine`. The command becomes

!!! Example ""
    ```
    docker run --volume //./pipe/docker_engine://./pipe/docker_engine --volume C:\\CORTEX\\JOBS:/tmp/cortex-jobs thehiveproject/cortex:latest --job-directory /tmp/cortex-jobs --docker-job-directory C:\\CORTEX\\JOBS
    ```

#### Docker in docker (docker-ception)
You can also run docker service inside Cortex container, a docker in a docker with `--start-docker` parameter. The container must be run in privileged mode.

!!! Example ""
    ```
    docker run --privileged thehiveproject/cortex:latest --start-docker
    ```
In this case you don't need to bind job directory.

#### Use Docker-compose
Cortex requires [Elasticsearch](#elasticsearch-inside-a-docker) to run. You can use `docker-compose` to start them together in Docker or install and configure Elasticsearch manually.
[Docker-compose](https://docs.docker.com/compose/install/) can start multiple dockers and link them together.

The following [docker-compose.yml](https://raw.githubusercontent.com/TheHive-Project/Cortex/master/docker/cortex/docker-compose.yml)
file starts Elasticsearch and Cortex:

!!! Example ""
    ```
    version: "2"
    services:
      elasticsearch:
        image: elasticsearch:7.9.1
        environment:
          - http.host=0.0.0.0
          - discovery.type=single-node
          - script.allowed_types=inline
          - thread_pool.search.queue_size=100000
          - thread_pool.write.queue_size=10000
        volumes:
          - /path/to/data:/usr/share/elasticsearch/data
      cortex:
        image: thehiveproject/cortex:3.1.1
        environment:
          - job_directory=${job_directory}
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock
          - ${job_directory}:${job_directory}
        depends_on:
          - elasticsearch
        ports:
          - "0.0.0.0:9001:9001"
    ```

Put this [docker-compose file](https://raw.githubusercontent.com/TheHive-Project/Cortex/master/docker/docker-compose.yaml) and [.env](https://raw.githubusercontent.com/TheHive-Project/Cortex/master/docker/cortex/.env) in an empty folder and run `docker-compose up`. Cortex is exposed on 9001/tcp port. These ports can be changed by modifying the `docker-compose` file.

!!! Tip "For advanced configuration, visit [our Docker Templates repository](https://github.com/TheHive-Project/Docker-Templates)"

#### Cortex with podman

Like docker, podman will be able to run the container image of cortex and of its analyzers.
The examples below assume that the containers are run as **rootful**.

For Cortex to interact with podman, it needs to use the [podman socket](https://docs.podman.io/en/latest/markdown/podman-system-service.1.html). On some systems, podman will automatically install and enable this service. You can check this on your system with:

```shell
systemctl status podman.socket
```

Here we assume that the podman socket is accessible on `/run/podman/podman.sock`. This may change based on your system.

!!! Example "Cortex uses podman service"

    You need to mount the podman socket inside the container to `/var/run/docker.sock`

    ```shell
    podman run \
      --rm \
      --name cortex \
      -p 9001:9001 \
      -v /var/run/cortex/jobs:/tmp/cortex-jobs \
      -v /run/podman/podman.sock:/var/run/docker.sock \
      docker.io/thehiveproject/cortex:3.1.7 \
      --job-directory /tmp/cortex-jobs \
      --docker-job-directory /var/run/cortex/jobs \
      --es-uri http://$ES_IP:9200
    ```

    With this configuration, Cortex analyzers will be run by podman.

!!! Warning "Image not found"

    Podman may have trouble pulling cortex neurons images from the regular docker registry. You may have to add docker.io as an unqualified registry.
    To do this, add this line to your config `/etc/containers/registries.conf`:

    ```
    unqualified-search-registries = ['docker.io']
    ```

    Then restart the podman socket service too

!!! Example "Docker in podman"

    By running with the flag `--privileged`, it is possible to start docker inside a podman container

    ```shell
    podman run \
      --privileged \
      --rm \
      --name cortex \
      -p 9001:9001 \
      docker.io/thehiveproject/cortex:3.1.7 \
      --es-uri http://$ES_IP:9200
      --start-docker
    ```
