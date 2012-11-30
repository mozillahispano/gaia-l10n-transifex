# Gaia l10n transifex config files #
 -----------------------------------
 
 This repo contains the files to hook up transifex with Gaia localization files.
 
## What do you need? ##

* Clone this repo
* Enther the cloned repo: `gaia-l10n-transifex`
* Clone the en-US repo:
  `hg clone http://hg.mozilla.org/gaia-l10n/en-US/`
* Clone the <lang> repo:
  `hg clone http://hg.mozilla.org/gaia-l10n/<lang>/`

Now you can just `tx pull -s` to get the en-US (which is the default language), or `tx pull -l <lang>` where `<lang>` is your language code you cloned in an earlier step.

If you do this, you can simply go to your `<lang>` repo and `hg push` to gaia-l10n and upload your translation to the Mozilla's repo.