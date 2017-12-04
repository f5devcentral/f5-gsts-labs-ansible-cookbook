Installing unstable modules
===========================

Problem
-------

You need to install an unstable F5 Ansible module

Solution
--------

The procedure for this is `documented here`_. We will use ``bigip_software``
for this example.

Ensure that you have created a directory named ``library`` as shown in
:doc:`1.3 Expected File Layout</class1/module1/lab03>`.

Next, download the source for this module using ``curl`` ::

   curl -o library/bigip_software.py https://raw.githubusercontent.com/F5Networks/f5-ansible/devel/library/bigip_software.py

You can now use the module as documented in its examples.

Discussion
----------

Our unstable code exists for the following reasons,

* We do not want to upstream everything. This may be because the underlying
  product is immature or not fully supported
* Due to the above, we can’t put it into upstream Ansible. If we did, this would
  create a support liability for us.
* It allows us to work independently of anything Ansible does.

Will you need to get unstable code? Probably.

In many cases, the unstable code is just as good as what exists in Ansible today,
but you won’t know this unless you try to use it.

If you find a module in the unstable branch that is not in the stable
(Ansible upstream) product, you will want to let us know about this by
:doc:`filing an issue</class1/module4/lab03>`.

.. _documented here: http://clouddocs.f5.com/products/orchestration/ansible/devel/usage/installing-modules.html