# Taxonomies and Tags

!!! Warning "TheHive 4.1.0+ is required to use Taxnomies


TheHive 4.1.0 introduces the support of Taxonomies as it is defined and published by [MISP](https://github.com/MISP/misp-taxonomies). These set of classification libraries can be used in THeHive to tag `Cases`, `Observables` and `Alerts`. 

!!! Tip
    Not only [MISP-Taxonomies](https://github.com/MISP/misp-taxonomies) are supported by TheHive, but you can also build your own by:
    
    - Following the IETF draft [https://tools.ietf.org/id/draft-dulaunoy-misp-taxonomy-format-07.html](https://tools.ietf.org/id/draft-dulaunoy-misp-taxonomy-format-07.html)
    - Draw inspiration from an existing definition file :-)


By default, TheHive does not contain any taxonomie. 



## Import taxonomies

To access and import taxonomies, beeing `admin` or at least have the role `manageTaxonomy` is required.

1. In the admin organisation, open the `Taxonomies` menu

    ![](./images/menu-admin-taxonomies.png){: witdh=600}

2. Click on `Import taxonomies` and select the file containing the libraries
 
    ![](./images/admin-import-taxonomies.png){: witdh=600}