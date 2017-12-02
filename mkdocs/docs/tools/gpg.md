GPG
############################################################

Password encryption and storage tool.

- `OpenSSH Key Management, Part 1 <http://www.funtoo.org/OpenSSH_Key_Management,_Part_1>`_
- `OpenSSH Key Management, Part 2 <http://www.funtoo.org/OpenSSH_Key_Management,_Part_2>`_
- `OpenSSH Key Management, Part 3 <http://www.funtoo.org/OpenSSH_Key_Management,_Part_3>`_
https://wiki.archlinux.org/index.php/Rng-tools
http://www.dewinter.com/gnupg_howto/english/GPGMiniHowto-3.html#ss3.5
https://gnupg.org/documentation/manuals/gnupg/#toc-Invoking-GPG_002dAGENT-1
https://www.gnupg.org/documentation/manuals/gnupg/Unattended-GPG-key-generation.html
http://www.issihosts.com/haveged/faq.html
https://www.2uo.de/myths-about-urandom/
https://alexcabal.com/creating-the-perfect-gpg-keypair/
https://spin.atomicobject.com/2013/11/24/secure-gpg-keys-guide/

List public keys

```bash
gpg -k
# or 
gpg --list-keys
```

List secret keys

```bash
gpg -K
# or 
gpg --list-secret-keys
```


gpg --list-keys -a "vagrant@eiab.net"

gpg --export vagrant@eiab.net | base64
gpg --export 1356A221 | base64

gpg --edit-key vagrant@eiab.net
