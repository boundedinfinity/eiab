Vagrant configuration
############################################################

In one terminal:

.. code-block:: bash

    sudo rngd -r /dev/urandom

Then in another:

.. code-block:: bash

    gpg --gen-key --batch ~/.gnupg/gen-key-script
