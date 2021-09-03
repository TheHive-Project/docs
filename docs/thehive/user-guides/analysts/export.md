# Export

TheHive4 has the capability to export a `case` to a MISP instance.

This functionnality allows you to easily share your incident and findings with communities. 

To export a `case`, you must have the `manageCase` permission (refer to [Profiles and permissions](../../Administrators/profiles/))

You also must have a *MISP* instance connected to your TheHive (refer to [MISP Connector](../../../Installation-and-configuration/configuration/connectors-misp/))

Trigger the *Export* button on a `case` action ribbon (*Case > Export*):

![case export button](../images/case-export.png)

In the *MISP export* pop-up, you can chose the *MISP* instance(s) where you want to export your `case`. Clic the *Export* button to send your `case` to the *MISP* instance.

![case export pop-up](../images/case-export-instance.png)