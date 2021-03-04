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


!!! Tip
    A direct link to the current zip archive of [MISP-Taxonomies](https://github.com/MISP/misp-taxonomies) let you download it quickly.

## Select interesting taxonomies

Select the libraries you would like your user be able to use in `Case` or `Observables`, and **enable it**.

<video height="450" autoplay controls muted>
    <source src="/thehive/user-guides/administration/images/admin-taxonomy-details.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>


!!! Warning
    Taxonomies enabled are available to users when adding tags in `Cases` or `Observables`. If a tag from a disabled taxonomy comes in an `Alert`, it can be seen, and imported in Cases. But users cannot add a similar tag in other `Cases` or `Observables`. 

    So you can leave a taxonomy disabled, and still receive tags issued from these taxonomies from `Alerts`.


## Free tags 


{== XXX TODO XXX  ==}
