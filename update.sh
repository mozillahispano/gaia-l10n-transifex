#!/bin/bash

for loc in $(cat $1)
do
   if [[ -d $loc ]] 
   then
       pushd $loc
       hg pull
       hg update
       popd
   else
       hg clone ssh://hg.mozilla.org/gaia-l10n/$loc
   fi
done
