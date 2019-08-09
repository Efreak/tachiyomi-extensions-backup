# Tachiyomi Extensions

This is mainly for my own personal use, as I use tachiyomi on multiple devices 
configured to auto update through fdroid, and this way I can update all 
plugins on all of them just by pushing once and initiating a check. If you 
intend to do so as well, please use 
https://cdn.rawgit2.com/Efreak/tachiyomi-extensions/master/fdroid/repo/

# Updating
If I don't update fast enough for you and you'd like to take over the work, let
me know and I'll give you the config.py and the keyfile and such. The commands
I use to update are so:

```
cd ../tachiyomi-extensions/apk
git pull
# watch the changes go by
cp -t $path/to/fdroid/repo $file1.apk $file2.apk $file3.apk
cd - # or `cd $repodir/fdroid`
fdroid update -c # the -c adds blank metadata if necessary.
# ^ The metadata I have has all the URLs set to the tachiyomi extensions repo, since I don't modify them.
git add repo archive
git commit -m "Update $sites"
git push
```
