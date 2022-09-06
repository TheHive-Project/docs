# Analyzers & Responders

## Run with Docker

!!! Tip "Ensure Cortex is authorized to run use Docker"
    To run docker images of Analyzers & Responders, Cortex should have permissions to use docker. 

    ```bash
    sudo usermod -G docker cortex
    ```


### Configure Cortex

To run Analyzers&Responders with Docker images, Cortex should be able have access to Internet: 

- To download public catalogs from _download.thehive-project.org_ 
- To download Docker images from _hub.docker.com_  ([https://hub.docker.com/search?q=cortexneurons](https://hub.docker.com/search?q=cortexneurons)).


!!! Example ""

    ```yaml title="/etc/cortex/application.conf" 
    [..]
    analyzer {
      # Directory that holds analyzers
      urls = [
        "https://download.thehive-project.org/analyzers.json"
      ]

      fork-join-executor {
        # Min number of threads available for analyze
        parallelism-min = 2
        # Parallelism (threads) ... ceil(available processors * factor)
        parallelism-factor = 2.0
        # Max number of threads available for analyze
        parallelism-max = 4
      }
    }

    responder {
      # Directory that holds responders
      urls = [
        "https://download.thehive-project.org/responders.json"
      ]

      fork-join-executor {
        # Min number of threads available for analyze
        parallelism-min = 2
        # Parallelism (threads) ... ceil(available processors * factor)
        parallelism-factor = 2.0
        # Max number of threads available for analyze
        parallelism-max = 4
      }
    }
    [..]
    ```

## Store & run programs on the host

### Additionnal packages

Some system packages are required to run Analyzers&Responders programs successfully: 

!!! Example ""

    === "Debian" 

        ```bash
        sudo apt install -y --no-install-recommends python3-pip python3-dev ssdeep libfuzzy-dev libfuzzy2 libimage-exiftool-perl libmagic1 build-essential git libssl-dev
        ```

        You may need to install Python's `setuptools` and update pip/pip3:

        ```bash
        sudo pip3 install -U pip setuptools
        ```

### Clone the repository 

Once finished, clone the Cortex-analyzers repository in the directory of your choosing:

!!! Example ""
    
    ```bash
    cd /opt
    git clone https://github.com/TheHive-Project/Cortex-Analyzers
    chown -R cortex:cortex /opt/Cortex-Analyzers 
    ```

### Install dependencies

Each analyzer comes with its own, pip compatible `requirements.txt` file. You can install all requirements with the following commands:

```
cd /opt
for I in $(find Cortex-Analyzers -name 'requirements.txt'); do sudo -H pip3 install -r $I || true; done
```

### Configure Cortex

Next, you'll need to tell Cortex where to find the analyzers. Analyzers may be in different directories as shown in this dummy example of the Cortex configuration file (`application.conf`):

!!! Example ""

    ```yaml title="/etc/cortex/application.conf"
    [..]
    analyzer {
      # Directory that holds analyzers
      urls = [
        "/opt/Cortex-Analyzers/responders",
      ]

      fork-join-executor {
        # Min number of threads available for analyze
        parallelism-min = 2
        # Parallelism (threads) ... ceil(available processors * factor)
        parallelism-factor = 2.0
        # Max number of threads available for analyze
        parallelism-max = 4
      }
    }

    responder {
      # Directory that holds responders
      urls = [
        "/opt/Cortex-Analyzers/responders"
      ]

      fork-join-executor {
        # Min number of threads available for analyze
        parallelism-min = 2
        # Parallelism (threads) ... ceil(available processors * factor)
        parallelism-factor = 2.0
        # Max number of threads available for analyze
        parallelism-max = 4
      }
    }
    [..]
    ```


## Run you own Analyzers & Responders

Either you run them from the host or with Docker images, you can also run your own custom Analyzers and Responders. 

### Dedicated folder

Create a dedicated folder to host your programs: 

!!! Example ""
    
    ```bash
    cd /opt
    mkdir -p Custom-Analyzers/{analyzers,responder}
    chown -R cortex:cortex /opt/Cortex-Analyzers 
    ```

### Update Cortex configuration

Update `analyzer.urls` and `responders.urls` accordingly.

!!! Example ""

    ```yaml title="/etc/cortex/application.conf" 
    [..]
    analyzer {
      # Directory that holds analyzers
      urls = [
        "https://download.thehive-project.org/analyzers.json",
        "/opt/Custom-Analyzers/analyzers" 
      ]

      fork-join-executor {
        # Min number of threads available for analyze
        parallelism-min = 2
        # Parallelism (threads) ... ceil(available processors * factor)
        parallelism-factor = 2.0
        # Max number of threads available for analyze
        parallelism-max = 4
      }
    }

    responder {
      # Directory that holds responders
      urls = [
        "https://download.thehive-project.org/responders.json",
        "/opt/Custom-Analyzers/responders" 
      ]

      fork-join-executor {
        # Min number of threads available for analyze
        parallelism-min = 2
        # Parallelism (threads) ... ceil(available processors * factor)
        parallelism-factor = 2.0
        # Max number of threads available for analyze
        parallelism-max = 4
      }
    }
    [..]
    ```

Then restart Cortex for the changes to take effect.


!!! Tip "How to develop your own Analyzers or Responders ?"

    Have a look at the dedicated documentation: [https://thehive-project.github.io/Cortex-Analyzers/dev_guides/how-to-create-an-analyzer/](https://thehive-project.github.io/Cortex-Analyzers/dev_guides/how-to-create-an-analyzer/)

