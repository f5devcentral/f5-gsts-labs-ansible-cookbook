Getting Started
---------------

.. NOTE::
	 All work for this lab will be performed exclusively from the Ansible
	 controller. No installation or interaction with your local system is
	 required.

Lab Topology
~~~~~~~~~~~~

The following components have been included in your lab environment:

- 1 x F5 BIG-IP VE (v13.0)
- 1 x Linux Server (ubuntu 16.04 LTS)
- 1 x Linux Client (ubuntu 16.04 LTS)
- 1 x Ansible Controller (ubuntu 16.04 LTS)

Lab Components
^^^^^^^^^^^^^^

The following table lists VLANS, IP Addresses and Credentials for all
components:

.. list-table::
    :widths: 20 40 40
    :header-rows: 1
    :stub-columns: 1

    * - **Component**
      - **VLAN/IP Address(es)**
      - **Credentials**
    * - big-ip01
      - - **Management:** 10.1.1.4
        - **External:** 10.1.10.10
        - **Internal:** 10.1.20.10
      - ``admin``/``admin``
    * - client
      - - **Management:** 10.1.1.5
        - **External:** 10.1.10.11
      - ``root``/``default``
    * - server
      - - **Management:** 10.1.1.6
        - **Internal:** 10.1.20.11
      - ``root``/``default``
    * - controller
      - - **Management:** 10.1.1.7
      - ``root``/``default``

Lab Environments
^^^^^^^^^^^^^^^^

In order to complete this class you will need to utilize a specific
**Lab Environment**.  You can consume this training in the following
ways:

- Pre-built Environment using the F5 Unified Demo Framework (UDF)

  - This environment is currently available for F5 employees only

Select the Environment from the list below to get started:

.. toctree::
   :maxdepth: 1
   :glob:

   udf