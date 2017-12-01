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
:doc:`filing an issue</class1/module4/lab3>`.
