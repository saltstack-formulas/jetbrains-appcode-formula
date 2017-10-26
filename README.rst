========
appcode
========

Formula for latest Appcode IDE from Jetbrains for MacOS.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.
    
Available states
================

.. contents::
    :local:

``appcode``
------------

Downloads the archive from Jetbrains website, unpacks locally and installs the IDE on MacOS.

.. note::

This formula automatically installs latest Jetbrains release. This behaviour may be overridden in pillars.

``appcode.developer``
------------
Creates Desktop shortcut.  Optionally retrieve preferences file from url/share to 'user' (pillar) home directory.


Please see the pillar.example for configuration.
Tested on MacOS.
