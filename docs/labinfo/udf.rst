F5 Unified Demo Framework (UDF)
-------------------------------

.. NOTE:: This environment is currently available for F5 employees only

Determine how to start your deployment:

- **Official Events (ISC, SSE Summits):**  Please follow the
  instructions given by your instructor to join the UDF Course.

- **Self-Paced/On Your Own:** Login to UDF,
  :guilabel:`Deploy` the ``Ansible Cookbook``
  Blueprint and :guilabel:`Start` it.

Connecting to the Environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To connect to the lab environment we will use a Web Shell to connect to the
Ansible Controller.

Connect using Web Shell
^^^^^^^^^^^^^^^^^^^^^^^

#. In the UDF navigate to your :guilabel:`Deployments`

#. Click the :guilabel:`Details` button for your Deployment

#. Click the :guilabel:`Components` tab

#. Find the ``Ansible Controller`` Component and click the the :guilabel:`Access`
   button.  Then click the :guilabel:`WEB SHELL` option.  A new browser window/tab
   will be opened.

#. Ensure that the `f5-gsts-labs-ansible-cookbook` directory in your `/root` directory
   is up-to-date.

   This can be done with the following command

   ``cd /root/f5-gsts-labs-ansible-cookbook && git pull``

#. Select how you would like to continue:

   - Review: :ref:`bigipbasics`
   - Start: :ref:`module1`
