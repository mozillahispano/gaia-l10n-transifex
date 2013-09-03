#!/bin/bash

GITBASE=`pwd`"/.."
HGBASE=`pwd`

cd $HGBASE

if [[ -z "$1" ]]
then
    echo "Usage: $0 [properties|manifest]"
    echo
    echo "  properties                    Import en-US properties files from git."
    echo "  manifests                     Import en-US manifests files from git."
    echo
    echo "The import command uses jq.  Download from http://stedolan.github.com/jq/"
    exit 1
fi

if [[ "$1" == "properties" ]]
then
    rm -rf ../apps/system/camera
    # migrate properties files
    for f in $(find .. -name "*.en-US.properties")
    do
        new="$HGBASE/en-US/$(echo $f | sed -e 's/..\///' -e 's/locales\///' -e 's/en-US.//')"
        mkdir -p $(dirname $new)
        echo "importing $f"
        cp $f $new
    done
    rm en-US/shared/branding/official/branding.properties
    exit 0
fi

if [[ "$1" == "manifests" ]]
then
    rm -rf ../apps/system/camera
    # migrate manifest files
    for f in $(find ../apps ../showcase_apps ../external-apps  -name "manifest.webapp")
    do
        new="$HGBASE/en-US/$(echo $f | sed -e 's/..\///' -e 's/webapp/properties/')"
        mkdir -p $(dirname $new)
        echo "importing $f"
        cat $f | jq '.locales["en-US"].name' | sed -e "s/^/name=/" -e 's/"//g' > $new
        cat $f | jq '.locales["en-US"].description' | sed -e "s/^/description=/" -e 's/"//g' >> $new
    done
    exit 0
fi
