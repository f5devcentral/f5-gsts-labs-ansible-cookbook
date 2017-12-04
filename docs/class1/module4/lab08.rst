Dealing with unsupported versions
=================================

Problem
-------

You’re not sure what version of BIG-IP is supported

Solution
--------

The list of supported versions, at the time of this writing, is

* BIG-IP 12.0.0 (BIGIP-12.0.0.0.0.606)
* BIG-IP 12.1.0 (BIGIP-12.1.0.0.0.1434)
* BIG-IP 12.1.0-hf1 (BIGIP-12.1.0.1.0.1447-HF1)
* BIG-IP 12.1.0-hf2 (BIGIP-12.1.0.2.0.1468-HF2)
* BIG-IP 12.1.1 (BIGIP-12.1.1.0.0.184)
* BIG-IP 12.1.1-hf1 (BIGIP-12.1.1.1.0.196-HF1)
* BIG-IP 12.1.1-hf2 (BIGIP-12.1.1.2.0.204-HF2)
* BIG-IP 12.1.2 (BIGIP-12.1.2.0.0.249)
* BIG-IP 12.1.2-hf1 (BIGIP-12.1.2.1.0.264-HF1)
* BIG-IP 13.0.0 (BIGIP-13.0.0.0.0.1645)
* BIG-IP 13.0.0-hf1 (BIGIP-13.0.0.1.0.1668-HF1)
* BIG-IP 13.0.0-hf2 (BIGIP-13.0.0.2.0.1671-HF2)

If you are using an unsupported version, no F5 Ansible modules are expected to work
except ``bigip_command``. You must also use SSH to connect to the device (as REST will
be unavailable on older platforms).

To use this, set the parameter ``transport: cli`` and authenticate as ``root`` for it to
work.

We have not written a deprecation policy for EOL’ing supported versions (in Ansible)
of F5 products.

Discussion
----------

At this time we have a large, and growing, list of F5 products that we have tested
to work with Ansible. Eventually, this list will be pruned.

In **all** cases, our recommendation is to **plan your upgrade path**. No exceptions.

On legacy product (versions less than 12) we do not expect any of our modules to
work, so do not even try. The **only** module that may work is the ``bigip_command``
module. However, on legacy versions, for it to work correctly,

* you **must** use the ``transport: cli``
* you **must** set the ``user`` argument to a name that has the *Administrator* role.

If you do not do the above things, do not expect that any of your ``tmsh`` commands
will work. An example usage would be

  ::

   - name: Run multiple commands as root over CLI
     bigip_command:
       commands:
         - tmsh create ltm virtual foo
         - tmsh create ltm pool bar
       server: lb.mydomain.com
       password: secret
       user: root
       validate_certs: no
       transport: cli
     delegate_to: localhost
