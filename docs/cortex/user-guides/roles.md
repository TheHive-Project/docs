# User Roles

Cortex defines four roles:

- `read`: the user can access all the jobs that have been performed by the Cortex 2 instance, including their results. However, this role **cannot** submit jobs. Moreover, this role **cannot** be used in the default `cortex` organization. This organization can only contain super administrators.
- `analyze`: the `analyze` role implies the `read` role, described above. A user who has a `analyze` role can submit a new job using one of the configured analyzers for their organization. This role **cannot** be used in the default `cortex` organization. This organization can only contain super administrators.
- `orgAdmin`: the `orgAdmin` role implies the `analyze` role. A user who has an `analyze` role can manage users
within their organization. They can add users and give them `read`, `analyze` and/or `orgAdmin` roles.
This role also permits to configure analyzers for the organization. This role **cannot** be used in the default  `cortex` organization. This organization can only contain super administrators.
- `superAdmin`: this role is incompatible with all the other roles listed above (see chart below for examples). It can be used solely for managing organizations and their associated users. When you install Cortex, the first user that is created will have this role. Several users can have it as well but only in the default `cortex` organization, which is automatically created during installation.

The chart below lists the roles and what they can and cannot do:

| Actions                  | read | analyze | orgAdmin | superAdmin |
| ------------------------ | ---- | ------- | -------- | ---------- |
| Read reports             |  X   |    X    |    X     |            |
| Run jobs                 |      |    X    |    X     |            |
| Enable/Disable analyzer  |      |         |    X     |            |
| Configure analyzer       |      |         |    X     |            |
| Create org analyst       |      |         |    X     |     X      |
| Delete org analyst       |      |         |    X     |     X      |
| Create org admin         |      |         |    X     |     X      |
| Delete org admin         |      |         |    X     |     X      |
| Create Org               |      |         |          |     X      |
| Delete Org               |      |         |          |     X      |
| Create Cortex admin user |      |         |          |     X      |