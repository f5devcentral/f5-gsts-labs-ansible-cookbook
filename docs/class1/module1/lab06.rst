Using static inventory
======================

Problem
-------

You need to have Ansible communicate with a predefined list of hosts

Solution
--------

Use a static inventory file.

A static inventory file is a INI formatted file. Here is an example ::

   server ansible_host=10.1.1.6
   bigip ansible_host=10.1.1.4
   client ansible_host=10.1.1.5

The above text you be put in a file named ``hosts`` in the ``inventory`` directory.

You would use the inventory like so, ::

   ansible-playbook -i inventory/hosts playbooks/site.yaml

#. Create a ``lab1.6`` directory in the ``labs`` directory.
#. Setup the filesystem layout to mirror the one :doc:`described in lab 1.3</class1/module1/lab03>`.
#. Add a ``server`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.6``
#. Add a ``client`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.5``
#. Add a ``bigip`` host to the ansible inventory and give it an ``ansible_host``
   fact with the value ``10.1.1.4``

Discussion
----------

Static hosts are the original means of specifying an inventory to Ansible.

The format mentioned in the solution above includes the following information,

#. A host named ``bigip``. This value will be put in Ansible’s ``inventory_hostname``
   variable.
#. A host *fact* called ``ansible_host``. This is a reserved variable in Ansible.
   It is used by Ansible to connect to the remote host. Its value is ``10.1.1.4``.

There are many more forms of inventory than static lists. Indeed, you can also
provide dynamic lists that take the form of small programs which output specially
formatted JSON.

Static lists work well for demos, ad-hoc play running, and cases when your
organizations systems practically never change. Otherwise, a dynamic source is
probably better.

Dynamic sources must be written by hand if you require a specific means of
getting the host informations (for example, from a local database at your company).

There are also a number of dynamic resources that you can get from Ansible.
You can find `Community contributions here`_, and you can find Contributions that `ship with Ansible, here`_.

.. _Community contributions here: https://github.com/ansible/ansible/tree/devel/contrib/inventory
.. _ship with Ansible, here: https://github.com/ansible/ansible/tree/devel/lib/ansible/plugins/inventory