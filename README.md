# Gaia l10n transifex config files #
 -----------------------------------

 This repo contains the files to hook up transifex with Gaia localization files.

## What do you need? ##

* Clone this repo inside the `locales` folder of Gaia.
* Enter the cloned repo: `gaia-l10n-transifex`
* Execute the `./import.sh properties` and `./import.sh manifests` to import manifests and properties from the gaia repository.

Now you can just `tx pull -s` to get the en-US (which is the default language), or `tx pull -l <lang>` where `<lang>` is your language code you cloned in an earlier step.

If you do this, you can simply go to your `<lang>` repo and `hg push` to gaia-l10n and upload your translation to Mozilla's repo.

## Steals ##
From stasm: https://github.com/stasm/gaia-l10n/