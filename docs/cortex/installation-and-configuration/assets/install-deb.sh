## INSTALLATION SCRIPT FOR Linux operating systems with DEB packages
#
#
#
# This script installs:
# - Elasticsearch 7.x
# - Docker engine
# - Cortex 3.x
# 
# It has been sucessfully tested  on freshly installed Operating systems:
# - Ubuntu 20.04 LTS
# 
#
# Requirements: 
# - 4vCPU
# - 16 GB of RAM
# 
#
# Usage:
# 
#   $ sudo -v ; wget -q -O /tmp/install-cortex.sh https://donwload.thehive-project.org/scripts/cortex/install-deb.sh ; bash /tmp/install-cortex.sh
# 
# 
# Maintained by: ©StrangeBee - https://www.strangebee.com

HEADER="---
Cortex installation script for Linux using DEB packages

Following softwares will be installed:
 - Elasticsearch 7.x
 - Docker engine
 - Cortex 3.x
 
It has sucessfully been tested on freshly installed Operating systems:
 - Ubuntu 20.04 LTS
 - Debian 11

Requirements: 
 - 4vCPU
 - 16 GB of RAM
 
Usage:
 
   $ sudo -v ; wget -q -O /tmp/install-cortex.sh https://donwload.thehive-project.org/scripts/cortex/install-deb.sh ; bash /tmp/install-cortex.sh
 

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
exec &> ${LOGFILE}

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


apt-update() {
  sudo apt update -qq 
}

# Start service, wait for it to be available and enable it
apt-install() {
  PACKAGENAME=$@
  log message "Installing package(s) ${PACKAGENAME}"
  apt-update
  sudo RUNLEVEL=1 apt install -yqq ${PACKAGENAME} 
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

  log ok "* Service ${SERVICENAME} is starting"
  sudo systemctl -q start ${SERVICENAME} 

  count=0
  while [ `ss -antl | grep LISTEN | grep :${SERVICEPORT} | wc -l` -lt 1 ] 
  do 
    count=$((${count}+1))
    if [ ${count} = 30 ]
    then
      log ko " ${SERVICENAME} failed to start, exiting."
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
apt-install wget gnupg apt-transport-https  ca-certificates curl jq software-properties-common lsb-release 

apt-install openjdk-11-jre-headless
echo JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64" | sudo tee -a /etc/environment 
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
sudo update-java-alternatives --jre-headless -s java-1.11.0-openjdk-amd64

## ELASTICSEARCH INSTALLATION
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch |  sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" |  sudo tee /etc/apt/sources.list.d/elastic-7.x.list 
apt-install elasticsearch

## ELASTICSEARCH CONFIGURATION
log message "Configuring elasticsearch"
sudo systemctl stop elasticsearch
sudo rm -rf /var/lib/elasticsearch/*

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
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

if [ `lsb_release -i | cut -d ':' -f 2` = 'Ubuntu' ] ; then 
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list 
else
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list 
fi
apt-install docker-ce

## Install PYTHON LIBS
log message "Installing python libs"
apt-install python3-pip
sudo pip3 install cortex4py cortexutils

## INSTALL CORTEX
wget -O- "https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY"  | sudo apt-key add -
wget -qO- https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY |  sudo gpg --dearmor -o /usr/share/keyrings/thehive-project.gpg
echo 'deb https://deb.thehive-project.org release main' | sudo tee -a /etc/apt/sources.list.d/thehive-project.list
apt-install cortex

## CONFIGURE CORTEX
log message "Configuring cortex"
sudo mkdir -p /opt/custom-Cortex-Analyzers/{analyzers,responders}
sudo chown -R cortex:cortex /opt/custom-Cortex-Analyzers


sudo systemctl stop cortex
if ! test -e /etc/cortex/secret.conf; then
    key=$(dd if=/dev/urandom bs=1024 count=1 | tr -dc 'a-zA-Z0-9' | fold -w 64 | head -n 1)
    echo "play.http.secret.key=\"$key\"" | sudo tee -a /etc/cortex/secret.conf
    # sudo sed -i 's_#play\.http\.secret\.key=.*$_include\ \"/etc/cortex/secret\.conf\"_' /etc/cortex/application.conf
    sudo sed -i  \
      -e 's_#play\.http\.secret\.key=.*$_include\ \"/etc/cortex/secret\.conf\"_' \
      -e 's/\(.*analyzers.json\"\)$/\1,/' \
      -e '/.*analyzers.json\",/a \\t\"/opt/custom-Cortex-Analyzers/analyzers\"' \
      -e 's/\(.*responders.json\"\)$/\1,/' \
      -e '/.*responders.json\",/a \\t\"/opt/custom-Cortex-Analyzers/responders\"' \
      /etc/cortex/application.conf
fi
    #sudo sed -i 's/#play\.http\.secret\.key=.*$/play.http.secret.key=\"$key\"/' /etc/cortex/application.conf
## PERMIT CORTEX TO USE DOCKER
sudo usermod -G docker cortex


## SERVICES
log message "\nStarting services"
sudo systemctl daemon-reload

## START ELASTICSEARCH 
start-service elasticsearch 9200

## START CORTEX
start-service cortex 9001

[[ $? -eq 0 ]] && display_success

exec 3>&-
