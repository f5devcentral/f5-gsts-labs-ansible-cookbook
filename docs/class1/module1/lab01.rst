Installing Ansible
==================

Problem
-------

You need to install Ansible in an existing Linux environment

Solution
--------

Ansible is distributed in several ways. These include

* Via the system’s package manager
* Via the PyPI (pronounced “pie pee eye”) package repository
* Via source tarball

The only proper way to install Ansible is via PyPI using the ``pip`` command line tool. ::

   pip install ansible

For the remainder of these labs we will be using the development copy of Ansible.

Since this is not yet available, we'll install it directly from Github

  ::

  $ pip install --upgrade git+https://github.com/ansible/ansible.git

This will include an updated set of modules that will be released in March.

Discussion
----------

PyPI is considered the only correct way to install Ansible because it
is the only method that the Ansible developers themselves can control.

The packages that you find on Linux distributions such as Ubuntu, Fedora,
or CentOS are maintained by members of the Ansible community and not by
Ansible itself.

Additionally, the packages that ship with your operating system are
frequently out-of-date.

True, they may be current at the time of their release, but Ansible’s
release cycle is quarterly, and therefore they can become out of date
quickly.

The ``pip`` method of installing is not constrained to the demands of the
Linux maintainers; it exists outside of their control. Therefore, it is
the easiest way to get the most up-to-date software from Ansible.

One more concern with the Linux packages is that they typically place
files in a location different from where ``pip`` places them. This is
totally expected, but it can have frustrating consequences should you
choose to switch to the ``pip`` version (for example, to upgrade to a
more recent version).

The differences in file locations can conflict with each other and leave
your Ansible installation a complete mess. Best to just stick with ``pip``.
