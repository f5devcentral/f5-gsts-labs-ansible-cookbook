Tweaking local ansible.cfg
==========================

Problem
-------

You need to tell Ansible how to find your unreleased modules

Solution
--------

Create, or change, an ``ansible.cfg`` file that specifies the ``library`` setting.

I recommend that you put an ``ansible.cfg`` file at the :doc:`top level<./lab3>` of
your Ansible related work.

Then add the following line to the ``ansible.cfg`` file ::

   library = ./library

Discussion
----------

There are a number of settings that you can change in an ansible.cfg file.
The entire list is `shown here`_.

Amongst the list of things that I routinely change, are the following

* ``retry_files_enabled = False``
* ``host_key_checking = False``
* ``roles_path = ./roles``
* ``library = ./library``

Values for paths (such as ``roles_path`` and ``library`` can be separated by
a colon. For example, ::

   roles_path = ./roles-dir-1:/path/to/absolute-dir2

I **never** use the system config found at ``/etc/ansible/ansible.cfg``. This
is an **anti-pattern**, do not do it. Instead, put your changes for you specific
project in a config file found in your project’s top-level directory.

If you use the system file, it will affect all the users of the system and all
the uses of Ansible on the system. This is almost never what you want.

.. _shown here: http://docs.ansible.com/ansible/latest/intro_configuration.html