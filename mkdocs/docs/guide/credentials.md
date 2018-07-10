gpg --batch --passphrase 'password' --quick-generate-key 'someone@somewhere.org' default default none
gpg: key 889CA58B86AC202D marked as ultimately trusted
gpg: directory '/Users/someone/.gnupg/openpgp-revocs.d' created
gpg: revocation certificate stored as '/Users/someone/.gnupg/openpgp-revocs.d/77D713373977DA74A2A1936A949CA58B86AC202D.rev'

gpg --list-keys
pass init someone@somewhere.org
pass insert eiab/rpi/pi
