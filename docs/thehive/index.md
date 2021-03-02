---
title: Home
---

<div>
  <figure align="center">
    <img src="./images/thehive-logo.png"width="600"/>  
    <figcaption>TheHive : Installation, operation and user guides</>
  </figure>
</div>
<div>
  <p align="center">
    <a href="https://chat.thehive-project.org" target"_blank"><img src="https://img.shields.io/badge/chat-on%20discord-7289da.svg?sanitize=true&logo=discord" alt="Discord"></a>
    <a href><img src="https://drone.strangebee.com/api/badges/TheHive-Project/TheHive/status.svg?ref=refs/heads/master" alt="Build status"></a>
    <a href="./LICENSE" target"_blank"><img src="https://img.shields.io/github/license/TheHive-Project/TheHive" alt="License"></a>
    <a href><img src="https://img.shields.io/github/v/release/thehive-project/TheHive?style=flat&logo=git-lfs" alt="Version"></a>          
  </p>
</div>


---

**Source Code**: [https://github.com/thehive-project/TheHive/](https://github.com/thehive-project/TheHive/)

**Website**: [https://www.thehive-project.org](https://www.thehive-project.org)

---

TheHive is a scalable, open source and free Security Incident Response Platform designed to make life easier for SOCs, CSIRTs, CERTs and any information security practitioner dealing with security incidents that need to be investigated and acted upon swiftly.

TheHive supports different methods to store data, files, and indexes according to your needs. However, even for a standalone, production server, we
 strongly recommend using Apache Cassandra as a scalable and fault-tolerant database. Files and indexes storage can vary, depending on your target setup ; for standalone server, the local filesystem is suitable, while sereval options are possible in the case of a cluster configuration. 

This documentation provides guides for 

## Guides

- [Installation and configuration guides](Installation/README.md) : contain step-by-step installation instructions for
 TheHive 4 for different operating systems as well as corresponding binary archives.
- [Migration guide](Administration/Migration.md): how to migrate your data from TheHive 3.4.0+.
- [Administration guides](Administration/README.md): can help you leverage or enable more advanced features, or setup
 a more complex architecture.
- [User guides](User/README.md): including a [Quick start guide](User/Quick-start.md) to get your instance of TheHive
 ready to use.

## Webhooks
Webhooks were not integrated in TheHive 4.0-RC1, but are available since TheHive-4.0-RC2. They are now part of a new notification system that is almost ready but which still needs some work. The basic webhook functionality of the TheHive-3.x releases can be configured as described [here](Administration/Webhook.md). 

## License
TheHive is an open source and free software released under the [AGPL](https://github.com/TheHive-Project/TheHive/blob/master/LICENSE) (Affero General Public License). We, TheHive Project, are committed to ensure that TheHive will remain a free and open source project on the long-run.

## Updates and community discussions
Information, news and updates are regularly posted on several communication channels:

:fontawesome-brands-twitter: [TheHive Project Twitter account](https://twitter.com/thehive_project)

:fontawesome-brands-wordpress: [TheHive Project blog](https://blog.thehive-project.org/)

:fontawesome-brands-discord: [TheHive Project Discord](https://chat.thehive-project.org)

:fontawesome-brands-google: Users forum on [Google Groups](https://groups.google.com/a/thehive-project.org/d/forum/users). Request an access:

- [using a Gmail address](https://accounts.google.com/SignUp?hl=en)
-  or [without it](https://accounts.google.com/SignUpWithoutGmail?hl=en).

## Contributing
We welcome your contributions. Please feel free to fork the code, play with it, make some patches and send us pull requests using [issues](https://github.com/TheHive-Project/TheHive/issues).

We do have a [Code of conduct](../code_of_conduct.md). Make sure to check it out before contributing.

## Community support
Please [open an issue on GitHub](https://github.com/TheHive-Project/TheHive/issues) if you'd like to report a bug or request a feature. We are also available on [Gitter](https://gitter.im/TheHive-Project/TheHive) to help you out.

If you need to contact the Project's team, send an email to <support@thehive-project.org>.

!!! Note
      - If you have problems with [TheHive4py](https://github.com/TheHive-Project/TheHive4py), please [open an issue on its dedicated repository](https://github.com/TheHive-Project/TheHive4py/issues/new).
      - If you encounter an issue with Cortex or would like to request a Cortex-related feature, please [open an issue on its dedicated GitHub repository](https://github.com/TheHive-Project/Cortex/issues/new).
      - If you have troubles with a Cortex analyzer or would like to request a new one or an improvement to an existing analyzer, please open an issue on the [analyzers' dedicated GitHub repository](https://github.com/TheHive-Project/cortex-analyzers/issues/new).

## Professional support
