# Download Cortex

Cortex is published and available as many binary packages formats: 

## :material-debian: Debian / :material-ubuntu: Ubuntu

Import the GPG key :

```bash
curl https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY | sudo apt-key add -
wget -qO- https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY |  sudo gpg --dearmor -o /usr/share/keyrings/thehive-project-archive-keyring.gpg
```

```text title="/etc/apt/source.list.d/thehive-project.list"
deb [signed-by=/usr/share/keyrings/thehive-project-archive-keyring.gpg] https://deb.thehive-project.org release main
```

## :material-redhat: Red Hat Enterprise Linux / :material-fedora: Fedora

Import the GPG key :

```bash
sudo rpm --import https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY
```

```text title="/etc/yum.repos.d/thehive-project.repo"
[thehive-project]
enabled=1
priority=1
name=TheHive-Project RPM repository
baseurl=https://rpm.thehive-project.org/release/noarch
gpgcheck=1
```

### :material-folder-zip: ZIP archive
Download it at: [https://download.thehive-project.org/cortex-latest.zip](https://download.thehive-project.org/cortex-latest.zip)

## :material-docker: Docker
Docker images are published on Dockerhub here: [https://hub.docker.com/r/thehiveproject/cortex](https://hub.docker.com/r/thehiveproject/cortex)


## Archives
There is no archive available for Cortex.

