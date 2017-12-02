Expected File Layout
====================

Problem
-------

You need to know how you should arrange files on disk so that Ansible can find them

Solution
--------

You should create the following directory structure when using Ansible. ::

   .
   ├── ansible.cfg
   ├── inventory
   │   ├── group_vars
   │   │   └── all.yaml
   │   ├── host_vars
   │   │   └── host1.yaml
   │   └── hosts
   ├── library
   ├── playbooks
   │   └── site.yaml
   ├── files
   ├── roles
   ├── scripts
   └── templates

The above assumes the following,

* you have a single host named ``host1``
* you have a single playbook named ``site.yaml``

More should be added as necessary. Empty directories are not required.

Discussion
----------

Each directory in Ansible has a specific purpose. You may not use all
of these directories in your day-to-day work, and that’s fine. You can
remove empty directories as needed.

In its simplest format, Ansible requires only two files to work; an
inventory and a playbook. As indicated in the solution above, we do
not recommend you follow that design.

Until you have sufficient knowledge of how Ansible’s parts work, it is
better that you use the solution above so that any modules you may use
(in any place you use them) will work.

Directories that are optional are,

* ``files``
* ``library``
* ``roles``
* ``scripts``
* ``templates``

The purpose of each directory is the following,

* ``files``

  * contains non-templates files to be used by the ``copy`` module

* ``library``

  * contains third-party Ansible modules that you want to use in your playbook

* ``roles``

  * contains roles that you want to use in your playbook

* ``scripts``

  * contains shell scripts that will be referenced by the ``script`` module

* ``templates``

  * contains files that will be treated as templates and referenced by the
  ``template`` module.