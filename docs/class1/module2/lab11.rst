Creating a new partition
========================

Problem
-------

You need to create separate partitions on the BIG-IP for different
tenants or resource management

Solution
--------

Use the ``bigip_partition`` module. ::

   - name: An example partition playbook
     hosts: big-ip01
     connection: local

     vars:
       validate_certs: no
       username: admin
       password: admin

     tasks:
       - name: Create partition
         bigip_partition:
           name: my-partition
           password: "{{ password }}"
           server: 10.1.1.4
           validate_certs: "{{ validate_certs }}"
           user: "{{ username }}"

Discussion
----------

The ``bigip_partition`` module can manage partitions on the system.

Partitions can be used in other modules after they are created. To use them
in modules that support them, provide the ``partition`` parameter.

Some modules, such as ``bigip_selfip`` allow you to modify resources that can
exist in another partition. In you want to do this, name those resources
explicitly using their full path (i.e., ``/foo/vlan1``). If you do not name the
full path, the module in question will assume the partition that is supplied
in the ``partition`` argument. By default, this is ``Common``.

At the time of this writing, partitions can *not* be removed until all of the
resources under them have been removed. We realize this is a source of pain,
but there is truly no supported way of removing a partition and all of its
resources. A future update will provide a workaround.
