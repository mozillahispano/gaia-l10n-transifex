# Gaia l10n transifex config files #
 -----------------------------------

 This repo contains the files to hook up transifex with Gaia localization files.

## What do you need? ##

* Install the tx client from http://help.transifex.com/features/client/#latest-stable-version
* Clone this repo inside the `locales` folder of Gaia: `$ git clone https://github.com/mozillahispano/gaia-l10n-transifex.git`
* Enter the cloned repo: `gaia-l10n-transifex`

Now you can just `tx pull -s` to get the en-US (which is the default language from Transifex), or `tx pull -l <lang>` where `<lang>` is your language code.

If you do this, you can simply go to your `<lang>` folder and find out that  you have your strings ready for mercurial. You can just use this folder as a mercurial repo (you need to init it before the steps or now), or copy the strings where you have your `http://hg.mozilla.org/gaia-l10n/<lang>/` repo.

## Steals ##
From stasm: https://github.com/stasm/gaia-l10n/
