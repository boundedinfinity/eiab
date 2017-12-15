#!/usr/bin/env bash

keyid=$1
keydir=$HOME/.gnupg
keyfile=$USER@$HOSTNAME

if [ -z $keyid ] ; then
    echo "key not found"
    exit 1
fi

keyval=$(gpg --export-secret-subkeys --export-options export-reset-subkey-passwd ${keyid}! | openpgp2ssh $keyid)

if [ -f $keydir/$keyfile ] ; then
    rm -rf $keydir/$keyfile
fi

echo "$keyval" > $keydir/$keyfile
chmod 0600 $keydir/$keyfile

cd $keydir
ssh-add $keyfile

# if [ -f $keydir/$keyfile ] ; then
#     rm -rf $keydir/$keyfile
# fi
