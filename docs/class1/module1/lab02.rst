Installing module dependencies
==============================

Problem
-------

You need to install F5 Ansible module dependencies

Solution
--------

Each module has different requirements. The F5 Ansible modules
require the following PyPI packages

* ``f5-sdk``
* ``bigsuds``
* ``netaddr``
* ``objectpath``
* ``isoparser``
* ``lxml``
* ``deepdiff``

These can be installed with the ``pip`` command

.. code-block:: bash

   pip install f5-sdk bigsuds netaddr objectpath isoparser lxml deepdiff

Discussion
----------

Unfortunately, there is no way to install all dependencies for
all modules out of the box.

Instead, you must find the dependencies for the module you are
interested in, and install them manually. This can be done by either,

#. Using the ``ansible-doc`` command
#. By visiting the Ansible documentation page for the module.

Take ``bigip_selfip`` for example.

ansible-doc command
```````````````````

The ``ansible-doc`` command to view  the requirements is, ::

   ansible-doc bigip_selfip

The requirements are shown in the output of this command.

|image2|

You may need to scroll to find this information.

Visiting documentation page
```````````````````````````

Alternatively you can visit the docs for this module by navigating
to `this link`_

There is a direct link to the requirements list if you mouse over the
**Requirements** header

|image1|

Note the chain icon to the right of the header. That link will
`lead you here`_.

Installing a development copy of F5 SDK
```````````````````````````````````````

One behavior that is frequently done is the installation of a
development copy of the F5 Python SDK. This is usually safe to
do as the SDK is always in-line with the Ansible modules.

To do this, run the following command::

  pip install --upgrade git+https://github.com/F5Networks/f5-common-python.git

This is usually a required step for Ansible upgrades and future
releases of Ansible because we often include new APIs in the SDK
that Ansible will make use of.

.. |image1| image:: /_static/class1/requirements-header.png
   :height: 5in
   :width: 6in
.. |image2| image:: /_static/class1/ansible-doc-output.png
   :height: 4in
   :width: 6in
.. _this link: http://docs.ansible.com/ansible/latest/bigip_selfip_module.html
.. _lead you here: http://docs.ansible.com/ansible/latest/bigip_selfip_module.html#requirements-on-host-that-executes-module