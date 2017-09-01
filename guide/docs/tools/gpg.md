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
