Local connection versus delegation
==================================

Problem
-------

You need to know when to use ``connection: local`` and ``delegate_to: localhost``

Solution
--------

An explanation of the difference between these two `is here`_. It is reprinted here for your convenience.

There are three major differences between ``connection: local` and
``delegate_to: localhost``:

* ``connection: local`` applies to all hosts
* ``delegate_to`` applies to specific hosts
* ``delegate_to`` runs your task on one host, in the context of another host

Connection: local
`````````````````

First, ``connection: local`` applies to all hosts in the playbook. If you find
yourself mixing and matching BIG-IP hosts with things like web servers, it would
cause your legitimate ssh connections to fail.

This is because when you specify ``connection: local``, every host is now considered
to have 127.0.0.1 as their IP address.

This is likely not what you want.

For example,

#. Create a ``lab3.3`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``server`` host to the ansible inventory and give it,

   * an ``ansible_host`` fact with the value ``10.1.1.6``

#. *Type* the following into the ``playbooks/site.yaml`` file.

  ::

   ---

   - name: This is my play
     hosts: server
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
         - name: Disable pool member for upgrading
           bigip_pool_member:
             pool: web-servers
             port: 80
             name: "{{ inventory_hostname }}"
             monitor_state: disabled
             session_state: disabled
             password: "{{ password }}"
             server: 10.1.1.4
             user: "{{ username }}"
             validate_certs: "{{ validate_certs }}"

         - name: Upgrade the webserver
           apt:
             name: apache2
             state: latest

         - name: Re-enable pool member after upgrading
           bigip_pool_member:
             pool: web-servers
             port: 80
             name: "{{ inventory_hostname }}"
             monitor_state: enabled
             session_state: enabled
             password: "{{ password }}"
             server: 10.1.1.4
             user: "{{ username }}"
             validate_certs: "{{ validate_certs }}"

Run this playbook, from the ``lab3.3`` directory like so

  ::

   $ ansible-playbook -i inventory/hosts playbooks/site.yaml

This playbook will run, but it's actually not correct. The reason is because of the
second task.

The second task is not what you want because it attempts to run the ``apt`` module on
your **local** machine. Your playbook, however, intended to upgrade the **remote**
webserver.

So you installed apache on the Ansible controller machine.

You can verify this with the following command

* ``dpkg --list | grep apache``

For example, here is the output on my ansible controller

  ::

   $ dpkg --list | grep apache
   ii  apache2                          2.4.18-2ubuntu3.5                          amd64        Apache HTTP Server
   ii  apache2-bin                      2.4.18-2ubuntu3.5                          amd64        Apache HTTP Server (modules and other binary files)
   ii  apache2-data                     2.4.18-2ubuntu3.5                          all          Apache HTTP Server (common files)
   ii  apache2-utils                    2.4.18-2ubuntu3.5                          amd64        Apache HTTP Server (utility programs for web servers)

Whoops.

You can remove apache on the Ansible controller with this command

* ``apt-get remove --purge apache2*``

Delegation
``````````

You can remedy this situation with ``delegate_to``. For the most part, you will
use this feature when the connection line is set to ssh (the default).

Delegation allows you to mix and match remote hosts. You continue to use an SSH
connection for legitimate purposes, such as connecting to remove servers, but
for the devices that don’t support this option, you delegate their tasks.

For example, this playbook will correct your problem:

#. Change your ``playbooks/site.yaml`` file to reflect the changes below.

  ::

   ---

   - name: This is my play
     hosts: server

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
         - name: Disable pool member for upgrading
           bigip_pool_member:
             pool: web-servers
             port: 80
             name: "{{ inventory_hostname }}"
             monitor_state: disabled
             session_state: disabled
             password: "{{ password }}"
             server: 10.1.1.4
             user: "{{ username }}"
             validate_certs: "{{ validate_certs }}"
           delegate_to: localhost

         - name: Upgrade the webserver
           apt:
             name: apache2
             state: latest

         - name: Re-enable pool member after upgrading
           bigip_pool_member:
             pool: web-servers
             port: 80
             name: "{{ inventory_hostname }}"
             monitor_state: enabled
             session_state: enabled
             password: "{{ password }}"
             server: 10.1.1.4
             user: "{{ username }}"
             validate_certs: "{{ validate_certs }}"
           delegate_to: localhost

The ``delegate_to`` parameter delegates the running of the task to some
completely different machine.

However, instead of the module having access to that totally different machine’s
facts, it instead has the facts of the inventory item where the delegation happened.
This is using the context of the host.

We also removed the `connection: local` line. This means that Ansible will try to
connect over SSH to all of our hosts on the `hosts:` line.

Discussion
----------

Quiz time.

In the above example, *even though* the first and third tasks are running on
the Ansible controller (instead of the remote webserver), what is the value
of the ``{{ inventory_hostname }}`` variable?

1. localhost
2. server
3. something else

If you answered ``server`` then you are correct.

This is **context**. The task executed on localhost using ``server``’s
context, and therefore, its ``facts``.

.. _is here: http://clouddocs.f5.com/products/orchestration/ansible/devel/usage/connection-local-or-delegate-to.html