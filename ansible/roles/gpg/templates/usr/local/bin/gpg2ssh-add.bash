#!/usr/bin/env bash

keyid=$1
keyfile=$HOME/.gnupg/$USER@$HOSTNAME

if [ -z $keyid ] ; then
    echo "key not found"
    exit 1
fi

keyval=$(gpg --export-secret-subkeys --export-options export-reset-subkey-passwd ${keyid}! | openpgp2ssh $keyid)

if [ -f $keyfile ] ; then
    rm -rf $keyfile
fi

echo "$keyval" > $keyfile
chmod 0600 $keyfile

ssh-add $keyfile

if [ -f $keyfile ] ; then
    rm -rf $keyfile
fi

