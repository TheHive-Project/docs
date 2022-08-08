## INSTALLATION SCRIPT FOR Linux operating systems with RPM packages
# 
# It has sucessfully been tested  on freshly installed Operating systems:
# - Fedora 35
# - RHEL 8.5
# - Ubuntu 20.04
# - Debian 11
#
# Requirements: 
# - 4vCPU
# - 16 GB of RAM
# 
#
# Usage:
# 
#   $ wget -q -O /tmp/install.sh https://archives.strangebee.com/scripts/install.sh ; sudo -v ; bash /tmp/install.sh
# 
# 
# maintained by: ©StrangeBee - https://www.strangebee.com


#############
# VARIABLES #
#############

HEADER="
Installation script for Linux using RPM packages

Following software and their dependencies can be installed:
 - TheHive 5.x
 - Cortex

This script has sucessfully been tested on freshly installed Operating Systems:
 - Fedora 35
 - RHEL 8.5

Requirements: 
 - 4vCPU
 - 16 GB of RAM
 
Usage:
 
   $ wget -q -O /tmp/install.sh https://archives.strangebee.com/scripts/install.sh ; sudo -v ; bash /tmp/install.sh

Maintained by: ©StrangeBee - https://www.strangebee.com

---

"

THEHIVE="---
Following softwares are being installed & configured:
 - Cassandra 4.0.x
 - Elasticsearch 7.x
 - TheHive 5.x

"

CORTEX="---
Following softwares are being installed & configured:
 - Elasticsearch 7.x
 - Docker engine
 - Cortex 3.x

"


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
LOGFILE="/tmp/install.log"
OSRPM="fedora35 rhel8.5"
OSDEB="ubuntu20.04 debian11"

############################
# MANAGE LOG FILE & OUTPUT #
############################


[[ -f ${LOGFILE} ]] && rm ${LOGFILE}
exec 3>$(tty)
exec 2>&1> ${LOGFILE}


display_info() {
  log message "Something went wrong. More information is available in ${LOGFILE} file."
}

IP=`hostname -I| cut -d ' ' -f 1`
display-cortex-success() {
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
  More information is available in /tmp/install.log file.\n
  "
}

display-thehive-success() {
  log success "
  ---
  TheHive installation complete! 

  Connect to http://${IP}:9000 and start configuring the application. Create a global Admin account, and then Organisations and users.
  
  Information:
  TheHive is installed with basic configuration parameters. It is configured to usel local accounts for authentication
  
  Warning :
  No specific security measures have been added. Xpack in Elasticsearch is disabled.  TheHive is Cassandra and Elasticsearch services anonymously and using clear communication protocol. Please have a look at the documentation to secure the environment. 

  Documentation: 
  https://docs.strangebee.com 

  Troublesoot: 
  More information is available in /tmp/install.log file.\n
  "
}



log () {
  TYPE=$1
  MESSAGE=$2

  case $1 in
    "success" )
    TAG=""
    COLOR=${WHITE}
    ;;

    "ko" )
    TAG="[ERROR]: "
    COLOR=${RED}
    ;;

    "ok" )
    TAG="[INFO]: "
    COLOR=${BLUE}
    ;;

    "message" )
    TAG="[INFO]: "
    COLOR=${BLUE}
    ;;
    
  esac

  echo -e "${TAG}${MESSAGE}"
  echo -e "${COLOR}${TAG}${MESSAGE}${NC}" >&3
}


alias yum="yum -yq"
alias dnf="dnf -yq"

pkg-install() {
  PACKAGENAME=$@
  if [ ${INSTALLTYPE} = "RPM" ]
  then
    sudo yum install -yq -e 0 ${PACKAGENAME} &> /dev/null
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    sudo apt update -qq  &> /dev/null
    sudo RUNLEVEL=1 apt install -yqq ${PACKAGENAME}  &> /dev/null
  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
}

# Start service, wait for it to be available and enable it
start-service() {
  SERVICENAME=$1
  
  log message  "* Starting service ${SERVICENAME}"
  sudo systemctl -q start ${SERVICENAME} 

  if [  "$2" != ""  ]
  then
    SERVICEPORT=$2
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
    fi

  sudo systemctl -q enable ${SERVICENAME}
}

## REQUIRED PACKAGES
install-required-packages() {
  log message "Installing required system packages"
  if [ ${INSTALLTYPE} = "RPM" ]
  then
    pkg-install gnupg chkconfig python3-pip
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    pkg-install wget gnupg apt-transport-https  ca-certificates curl jq software-properties-common lsb-release python3-pip
  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
}

## INSTALL JAVA
install-java() {
  log message "Installing Java"
  if [ ${INSTALLTYPE} = "RPM" ]
  then
    pkg-install java-11-openjdk-headless.x86_64 &> /dev/null
    echo JAVA_HOME="/usr/lib/jvm/jre-11-openjdk" |sudo tee -a /etc/environment
    export JAVA_HOME="/usr/lib/jvm/jre-11-openjdk"
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    pkg-install openjdk-11-jre-headless
    echo JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64" | sudo tee -a /etc/environment 
    export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
    sudo update-java-alternatives --jre-headless -s java-1.11.0-openjdk-amd64

  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
}


## CASSANDRA INSTALLATION 
install-cassandra() {
  log message "Installing Cassandra"
  if [ ${INSTALLTYPE} = "RPM" ]
  then
    sudo rpm --import https://downloads.apache.org/cassandra/KEYS &> /dev/null
      cat <<EOF | sudo tee  -a /etc/yum.repos.d/cassandra.repo > /dev/null
[cassandra]
name=Apache Cassandra
baseurl=https://downloads.apache.org/cassandra/redhat/40x/
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://downloads.apache.org/cassandra/KEYS
EOF
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    wget -qO -  https://downloads.apache.org/cassandra/KEYS | sudo gpg --dearmor  -o /usr/share/keyrings/cassandra-archive.gpg
    echo "deb [signed-by=/usr/share/keyrings/cassandra-archive.gpg] https://downloads.apache.org/cassandra/debian 40x main" |  sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list   
  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
  pkg-install cassandra
}

## CQLSH
install-cqlsh() {
    if [ ${INSTALLTYPE} = "RPM" ]
  then
    log message "Installing cqlsh"
    sudo pip3 install -q cqlsh
  fi      # Not needed for DEB packages, installed with Cassandra
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
}


## CASSANDRA CONFIGURATION
configure-cassandra() {
  log message "Configuring cassandra"
  if [ ${INSTALLTYPE} = "RPM" ]
  then
    cat /etc/cassandra/default.conf/cassandra.yaml | sudo sed  -e "s/\(cluster_name:\ \).*/\1\'thp\'/g" | sudo tee /etc/cassandra/default.conf/cassandra.yaml
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    sudo systemctl stop cassandra
    sudo rm -rf /var/lib/cassandra/*
    cat /etc/cassandra/cassandra.yaml | sed  -e "s/\(cluster_name:\ \).*/\1\'thp\'/g" | sudo tee /etc/cassandra/cassandra.yaml 
  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
  sudo chown -R cassandra:cassandra /var/lib/cassandra
  
}

## Remove tombstones (for standalone server ONLY)
remove-cassamdra-tombstone() {
  log message "Removing tombstones in Cassandra"
  for TABLE in edgestore edgestore_lock_ graphindex graphindex_lock_ janusgraph_ids system_properties system_properties_lock_ systemlog txlog
      do
        cqlsh -u cassandra -p cassandra -e "ALTER TABLE thehive.${TABLE} WITH gc_grace_seconds = 0;"
      done
}


## INSTALL ELASTICSEARCH
install-elasticsearch() {
  log message "Installing Elasticsearch"
  ESOPTS=""
  if [ ${INSTALLTYPE} = "RPM" ]
  then
    sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch &> /dev/null
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
  ESOPTS="--enablerepo=elasticsearch"
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch |  sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" |  sudo tee /etc/apt/sources.list.d/elastic-7.x.list 
  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
  pkg-install ${ESOPTS} elasticsearch
}

## ELASTICSEARCH CONFIGURATION
configure-elasticsearch() {
  log message "Configuring elasticsearch"
    if [ ${INSTALLTYPE} = "DEB" ]
  then
    sudo systemctl stop elasticsearch
    sudo rm -rf /var/lib/elasticsearch/*
  fi   # Not required for RPM packages
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
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
}

## INSTALL THEHIVE 
install-thehive() {
  log message "Installing TheHive"
  if [ ${INSTALLTYPE} = "RPM" ]
  then
      sudo rpm --import https://archives.strangebee.com/keys/strangebee.gpg 
      cat <<EOF | sudo  tee -a  /etc/yum.repos.d/strangebee.repo
[thehive]
enabled=1
priority=1
name=StrangeBee RPM repository
baseurl=https://rpm.strangebee.com/thehive-5.x/noarch
gpgkey=https://archives.strangebee.com/keys/strangebee.gpg
gpgcheck=1
EOF
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    wget -qO- https://archives.strangebee.com/keys/strangebee.gpg |  sudo gpg --dearmor -o /usr/share/keyrings/strangebee-archive-keyring.gpg
    echo 'deb [signed-by=/usr/share/keyrings/strangebee-archive-keyring.gpg] https://deb.strangebee.com thehive-5.x main' |  sudo tee -a /etc/apt/sources.list.d/strangebee.list  
  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
  pkg-install thehive
}

## CREATE THEHIVE FILE STORAGE
creating-thehive-file-storage() {
  log message "Configuring TheHive"
  sudo mkdir -p /opt/thp/thehive/files
  sudo chown -R thehive:thehive /opt/thp/thehive/files
}


## INSTALL DOCKER
install-docker() {
  log message "Installing Docker"
  if [ ${INSTALLTYPE} = "RPM" ]
  then
    sudo yum remove -yq docker \
                    docker-client \
                    docker-client-latest \
                    docker-common \
                    docker-latest \
                    docker-latest-logrotate \
                    docker-logrotate \
                    docker-engine
    pkg-install dnf-plugins-core
    OS=`cat /etc/redhat-release | cut -d ' ' -f 1`
    if [ ${OS} = 'Fedora' ] ; then 
      sudo dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/fedora/docker-ce.repo &> /dev/null
    else
      sudo dnf config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo &> /dev/null
    fi
    pkg-install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    if [ `lsb_release -i | cut -d ':' -f 2` = 'Ubuntu' ]
    then 
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list 
    else
      echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list 
    fi
    pkg-install docker-ce
  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
}

## Install PYTHON LIBS
install-python-libs() {
  log message "Installing python libs"
  sudo pip3 install cortex4py cortexutils
}

## INSTALL CORTEX 
install-cortex() {
  if [ ${INSTALLTYPE} = "RPM" ]
  then
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
  elif [ ${INSTALLTYPE} = "DEB" ]
  then
    wget -qO- "https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY"  | sudo apt-key add -
    wget -qO- https://raw.githubusercontent.com/TheHive-Project/TheHive/master/PGP-PUBLIC-KEY |  sudo gpg --dearmor -o /usr/share/keyrings/thehive-project.gpg
    echo 'deb https://deb.thehive-project.org release main' | sudo tee -a /etc/apt/sources.list.d/thehive-project.list
  fi
  if [ $? -ne 0 ]
  then
    display_info
    exit 1
  fi
  pkg-install  cortex
}


## CONFIGURE CORTEX 
configure-cortex() {
  log message "Configuring cortex"
  sudo usermod -G docker cortex  # DOCKER PERMISSIONS
  sudo mkdir -p /opt/custom-Cortex-Analyzers/{analyzers,responders}
  sudo chown -R cortex:cortex /opt/custom-Cortex-Analyzers

  sudo systemctl -q stop cortex
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
}


## FIREWALLD
configure-firewalld-cortex() {
  if [ ${INSTALLTYPE} = "RPM" ]
  then
    sudo firewall-cmd --add-port=$1/tcp
    sudo firewall-cmd --runtime-to-permanent
    log message "* Firewalld rules updated"
      if [ $? -ne 0 ]
      then
        display_info
        exit 1
      fi
  fi  # Not required for Ubuntu and Debian
}

reload-services() {
  sudo systemctl daemon-reload
}


### START AND ENABLE DOCKER
start-enable-docker() {
  start-service docker
}


### START AND ENABLE ELASTICSEARCH
start-enable-elasticsearch(){
  start-service elasticsearch 9200
}

### START AND ENABLE THEHIVE
start-enable-cassandra() {
  start-service cassandra 9042
}

### START AND ENABLE THEHIVE
start-enable-thehive() {
  start-service thehive 9000
}


### START AND ENABLE CORTEX
start-enable-cortex() {
  start-service cortex 9001 
}

check-installed-application() {
  INSTALLING=$1
  if [ -d "/etc/thehive/" ] && [ -d "/opt/thehive/" ]
  then 
    INSTALLED="THEHIVE"
  elif [ -d "/etc/cortex/" ] && [ -d "/opt/cortex/" ]
  then  
    INSTALLED="CORTEX"
  else
    INSTALLED="NONE"
  fi
  if [ ${INSTALLED} != "NONE" ]
  then
    log ko "${INSTALLED} is already installed on the system. Exiting ..."
     exit 1
  fi
}

## CHECK AVAILABLE RESOURCES
check-available-resources() {
  NBPROC=`nproc`
  RAM=`vmstat  -s | grep "total memory" | xargs | cut -d ' ' -f 1`
  if [ ${NBPROC} -lt 4 ] || [ ${RAM} -lt 16000000 ]
  then
    log ko "4 core CPUs and 16GB of memory are required to run this application"
    exit 1
  fi
}

check-supported-os() {
  DIST=`cat /etc/os-release | grep -e ^ID= | cut -d '=' -f 2 | tr -d '"'`
  VERSION=`cat /etc/os-release | grep -e ^VERSION_ID= | cut -d '=' -f 2 | tr -d '"'`

  if   echo ${OSDEB} | grep "${DIST}${VERSION}" 
  then 
    INSTALLTYPE="DEB"
  elif echo ${OSRPM} | grep "${DIST}${VERSION}"
  then
      INSTALLTYPE="RPM"
  else
    log ko "Operating System of the version is not suported. Check supported OS on https://docs.strangebee.com"
    exit 1
  fi
}

#######
# RUN #     
#######

## HEADER
clear >&3 
log success "${HEADER}"
PS3='Select the application to install: '
options=("TheHive" "Cortex" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "TheHive")
            APPLICATION="THEHIVE"
            check-supported-os
            check-available-resources
            check-installed-application ${APPLICATION}
            clear >&3 
            echo "installing $opt ..."
            log success "${THEHIVE}"
            install-required-packages
            install-java
            install-cassandra
            install-cqlsh
            configure-cassandra
            install-elasticsearch
            configure-elasticsearch
            install-thehive
            creating-thehive-file-storage
            configure-firewalld-cortex 9000
            reload-services
            start-enable-cassandra
            start-enable-elasticsearch
            start-enable-thehive
            remove-cassamdra-tombstone
            [[ $? -eq 0 ]] && display-thehive-success
            exec 3>&-
            exit 0
            ;;
        "Cortex")
            APPLICATION="CORTEX"
            check-supported-os
            check-available-resources
            check-installed-application ${APPLICATION}
            clear >&3 
            echo "installing $opt ..." >&3
            log success "${CORTEX}"
            install-required-packages
            install-elasticsearch
            configure-elasticsearch
            install-docker
            install-python-libs
            install-cortex
            configure-cortex
            configure-firewalld-cortex 9001
            reload-services
            start-enable-docker
            start-enable-elasticsearch
            start-enable-cortex
            [[ $? -eq 0 ]] && display-cortex-success
            exec 3>&-
            exit 0
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
