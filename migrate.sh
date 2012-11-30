#!/bin/bash

GITBASE="/Volumes/Mozilla/tid/gaia/"
HGBASE="/Volumes/Mozilla/tid/gaia/locales/"

cd $HGBASE

if [[ -z "$1" ]]
then
    echo "Usage: $0 [import|export|ini]"
    echo 
    echo "  import                    Import en-US properties files from git."
    echo "  export [LOCALE...]        Export specified locale's properties"
    echo "                            files to git.  If no locale is given"
    echo "                            export ar, fr and zh-TW."
    echo "  ini [LOCALE...]           Add LOCALE to *.ini files for all apps"
    echo 
    echo "The import command uses jq.  Download from http://stedolan.github.com/jq/"
    exit 1
fi

if [[ "$1" == "import" ]]
then
    # migrate properties files
    for f in $(find .. -name "*.en-US.properties")
    do
        new="$HGBASE/en-US/$(echo $f | sed -e 's/..\///' -e 's/locales\///' -e 's/en-US.//')"
        mkdir -p $(dirname $new)
        echo "importing $f"
        cp $f $new
    done
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

if [[ "$1" == "export" ]]
then
    args=("$@")
    locales=${args[@]:1}

    if [[ -z $locales ]]
    then
        locales=( ar fr zh-TW )
    fi

    for en_git in $(find .. -name "*.en-US.properties")
    do
        for loc in $locales
        do
            echo "exporting target: ${en_git%.en-US.properties}.$loc.properties"
            cp \
              $HGBASE/$loc/$(echo $en_git | sed -e 's/..\///' -e 's/locales\///' -e 's/en-US.//') \
              ${en_git//en-US/$loc} 2> /dev/null
        done
    done
    exit 0
fi

if [[ "$1" == "ini" ]]
then
    args=("$@")
    locales=${args[@]:1}

    if [[ -z $locales ]]
    then
        locales=( ar fr zh-TW )
    fi

    for ini in $(find .. -name "*.ini")
    do
        if [[ -z $(grep "en-US.properties" $ini) ]]
        then
            echo "No en-US line on $ini"
            continue
        fi
        echo "There is a en-US line on $ini"
        for loc in $locales
        do
            if [[ -z $(grep "\[$loc\]" $ini) ]]
            then
                echo "[$loc] section is missing; adding..."
                echo "" >> $ini
                echo "[$loc]" >> $ini
            fi
            import_en=$(grep "en-US.properties" $ini)
            import_loc=${import_en/en-US/$loc}
            if [[ -z $(grep "$import_loc" $ini) ]]
            then
                _tmp=$(mktemp /tmp/tmp.XXXX)
                gsed "/\[$loc\]/a $import_loc" $ini > $_tmp
                mv $_tmp $ini
            else
                echo "$import_loc already in $ini"
            fi
        done
    done
    exit 0
fi


