#!/bin/bash
cd /b2g/gaia-locales-1.4/
cd en-US
hg pull -u
yes y | /usr/local/bin/tx push -s en-US -f