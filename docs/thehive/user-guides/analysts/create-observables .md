# Create an observable

In a TheHive `case`, you can declare `observables`. 

To create an `observable`, open the *Observables list* (*Case > Observables*). you must have the `manageCase` permission (refer to [Profiles and permissions](../../Administrators/profiles/))

You will find the *Add observable* button under the *Observables* tab:

![create observable button](../images/create-observable-button.png)

In the pop-up, you are invited to fill the `observable`(s) details:

- Type *: The `observable` `dataType` (eg: ip, hash, domain, ...)
- Value *: Your `observable` value (eg: 8.8.8.8)
    - One observable per line: Create one `observable` per line inserted in value field.
    - One single multiline observable: Create one `observable`, no matter the number of lines (useful for long URLs for example).
- TLP *: Define here the way the information should be shared.
- Is IOC: Check it if this `observable` is considered as Indicator of Compromission.
- Has been sighted: Has this `observable` been sighted on your information system.
- Ignore for similarity: Do not correlate this `observable` with other similar `observables`.
- Tags **: Tag your `observable` with insightful information.
- Description **: Description of the `observable`.

Details annoted with a '*' are mandatory. Detail annoted with '**' mean at least.

![create observable](../images/create-observable.png)

Finally clic on *Create Observable(s)*