## INSTALLATION SCRIPT FOR Linux operating systems with RPM packages
#
#
#
# This script installs:
# - Elasticsearch 7.x
# - Docker engine
# - Cortex 3.x
# 
# It has sucessfully been tested  on freshly installed Operating systems:
# - Fedora 35
# - RHEL 8 
#
# Requirements: 
# - 4vCPU
# - 16 GB of RAM
# 
#
# Usage:
# 
#   $ sudo -v ; wget -q -O /tmp/install-cortex.sh https://donwload.thehive-project.org/scripts/cortex/install-rpm.sh ; bash /tmp/install-cortex.sh
# 
# 
# maintained by: ©StrangeBee - https://www.strangebee.com

HEADER="---
THeHive installation script for Linux using RPM packages

Following softwares will be installed:
 - Elasticsearch 7.x
 - Docker engine
 - Cortex 3.x

It has sucessfully been tested on freshly installed Operating systems:
 - Fedora 35
 - RHEL 8 

Requirements: 
 - 4vCPU
 - 16 GB of RAM
 
Usage:
 
   $ sudo -v ; wget -q -O /tmp/install-cortex.sh https://donwload.thehive-project.org/scripts/cortex/install-rpm.sh ; bash /tmp/install-cortex.sh
 

Maintained by: ©StrangeBee - https://www.strangebee.com

---

"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
LOGFILE="/tmp/install-cortex.log"

[[ -f ${LOGFILE} ]] && rm ${LOGFILE}
exec 3>$(tty)
exec 2>&1> ${LOGFILE}

display_info() {
  log message "Something went wrong. More information is available in /tmp/install-cortex.log file."
}

IP=`hostname -I| cut -d ' ' -f 1`
display_success() {
  log success "
  ---
  Cortex installation complete! 

  Connect to http://${IP}:9001 and start configuring the application. Create a global Admin account, and then Organisations and users.
  
  Information:
  Cortex is installed with basic configuration parameters. It is configured to use:
  - local accounts for authentication
  - Docker to run Analyzers & Responders images
  
  Warning :
  No specific security measures have been added. Xpack in Elasticsearch is disabled, and Cortex is accessing this service anonymously and using clear communication protocol. Please have a look at the documentation to secure the environment. 

  Troublesoot: 
  More information is available in /tmp/install-cortex.log file.\n
  "
}

log () {
  TYPE=$1
  MESSAGE=$2

  case $1 in
    "success" )
    TAG="\n>>>> "
    COLOR=${YELLOW}
    ;;

    "ko" )
    TAG="[!] "
    COLOR=${RED}
    ;;

    "ok" )
    TAG="  "
    COLOR=${BLUE}
    ;;

    "message" )
    TAG=""
    COLOR=${CYAN}
    ;;
    
  esac

  echo -e "${TAG}${MESSAGE}"
  echo -e "${COLOR}${TAG}${MESSAGE}${NC}" >&3
}


yum-install() {
  PACKAGENAME=$@
  log message "Installing package(s) ${PACKAGENAME}"
  sudo yum install -yq ${PACKAGENAME} 
  if [ $? -eq 0 ]
    then
      log ok "package(s) ${PACKAGENAME} installed"
    else
      log ko "package(s) ${PACKAGENAME} not installed"
      display_info
      exit 1
    fi

}

# Start service, wait for it to be available and enable it
start-service() {
  SERVICENAME=$1
  SERVICEPORT=$2

  log ok  "* Starting service ${SERVICENAME}"
  sudo systemctl -q start ${SERVICENAME} 

  count=0
  while [ `ss -antl | grep LISTEN | grep ${SERVICEPORT} | wc -l` -lt 1 ] 
  do 
    count=$((${count}+1))
    if [ ${count} = 30 ]
    then
       log ko " ${SERVICENAME} not started, exiting."
       display_info
      exit 1
    else
      sleep 10
    fi
  done

  sudo systemctl -q enable ${SERVICENAME}
}

## HEADER
echo -e "${HEADER}" >&3

## REQUIRED PACKAGES
yum-install gnupg chkconfig


## INSTALL JAVA
# yum-install java-11-openjdk-headless.x86_64
# echo JAVA_HOME="/usr/lib/jvm/jre-11-openjdk" |sudo tee -a /etc/environment
# export JAVA_HOME="/usr/lib/jvm/jre-11-openjdk"




## INSTALL ELASTICSEARCH
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

cat <<EOF |  sudo tee  -a /etc/yum.repos.d/elasticsearch.repo 
[elasticsearch]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
EOF

yum-install python3-pip

sudo yum install -y -q --enablerepo=elasticsearch elasticsearch


## ELASTICSEARCH CONFIGURATION
log message "Configuring elasticsearch"
cat << EOF |  sudo tee /etc/elasticsearch/elasticsearch.yml 
http.host: 127.0.0.1
transport.host: 127.0.0.1
cluster.name: hive
thread_pool.search.queue_size: 100000
path.logs: "/var/log/elasticsearch"
path.data: "/var/lib/elasticsearch"
xpack.security.enabled: false
script.allowed_types: "inline,stored"
EOF

cat << EOF | sudo tee -a /etc/elasticsearch/jvm.options.d/jvm.options 
-Dlog4j2.formatMsgNoLookups=true
-Xms4g
-Xmx4g
EOF


## INSTALL DOCKER
log message "Installing Docker"
sudo yum remove -yq docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

sudo dnf -yq install dnf-plugins-core

OS=`cat /etc/redhat-release | cut -d ' ' -f 1`

if [ ${OS} = 'Fedora' ] ; then 
  sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/fedora/docker-ce.repo
else
  sudo dnf config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
fi

sudo dnf install -yq docker-ce docker-ce-cli containerd.io docker-compose-plugin

## Install PYTHON LIBS
log message "Installing python libs"
sudo pip3 install cortex4py cortexutils


## INSTALL CORTEX 
sudo rpm --import https://raw.githubusercontent.com/TheHive-Project/Cortex/master/PGP-PUBLIC-KEY

cat <<EOF | sudo  tee -a  /etc/yum.repos.d/thehive-project.repo
[cortex]
enabled=1
priority=1
name=TheHive-Project RPM repository
baseurl=https://rpm.thehive-project.org/release/noarch
gpgkey=https://raw.githubusercontent.com/TheHive-Project/Cortex/master/PGP-PUBLIC-KEY
gpgcheck=1
EOF

yum-install  cortex
sudo systemctl -q stop cortex
## DOCKER PERMISSIONS
sudo usermod -G docker cortex

## CONFIGURE CORTEX 
log message "Configuring cortex"
sudo mkdir -p /opt/custom-Cortex-Analyzers/{analyzers,responders}
sudo chown -R cortex:cortex /opt/custom-Cortex-Analyzers

sudo systemctl stop cortex
if ! test -e /etc/cortex/secret.conf; then
    key=$(dd if=/dev/urandom bs=1024 count=1 | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)
    echo "play.http.secret.key=\"$key\"" | sudo tee -a /etc/cortex/secret.conf
    sudo sed -i  \
      -e 's_#play\.http\.secret\.key=.*$_include\ \"/etc/cortex/secret\.conf\"_' \
      -e 's/\(.*analyzers.json\"\)$/\1,/' \
      -e '/.*analyzers.json\",/a \\t\"/opt/custom-Cortex-Analyzers/analyzers\"' \
      -e 's/\(.*responders.json\"\)$/\1,/' \
      -e '/.*responders.json\",/a \\t\"/opt/custom-Cortex-Analyzers/responders\"' \
      /etc/cortex/application.conf
fi

## FIREWALLD
log message "\nUpdating firewalld rules"
sudo firewall-cmd --add-port=9001/tcp
sudo firewall-cmd --runtime-to-permanent

## SERVICES
log message "\nStarting services"
sudo systemctl daemon-reload

### START AND ENABLE DOCKER
sudo systemctl enable -q docker
log ok  "* Starting service docker"
sudo systemctl start -q docker

### START AND ENABLE ELASTICSEARCH
start-service elasticsearch 9200

### START AND ENABLE THEHIVE
start-service cortex 9001 

[[ $? -eq 0 ]] && display_success

exec 3>&-