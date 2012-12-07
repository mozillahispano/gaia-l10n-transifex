# Gaia l10n transifex config files #
 -----------------------------------

 This repo contains the files to hook up transifex with Gaia localization files.

## What do you need? ##

* Clone this repo
* Enter the cloned repo: `gaia-l10n-transifex`
* Execute the `update.sh` script to download all locales from the `all-locales` file.

* If you want to import bleeding-edge strings from gaia, execute the `import.sh` script which will copy all the en-US files from the base Gaia repository to en-US. This means that you will likely have different content from github than from mercurial.

Now you can just `tx pull -s` to get the en-US (which is the default language), or `tx pull -l <lang>` where `<lang>` is your language code you cloned in an earlier step.

If you do this, you can simply go to your `<lang>` repo and `hg push` to gaia-l10n and upload your translation to Mozilla's repo.

## Steals ##
From stasm: https://github.com/stasm/gaia-l10n/