#!/usr/bin/env bash

cd /home/efreak/fdroidserver/fdroid/repo

predl="$(ls)"

curl -L $(curl $(curl 'https://api.github.com/repos/jays2kings/tachiyomi/releases/latest'|jq '.url'|cut -d\" -f2)|jq '.assets'|grep browser_download_url|cut -d\" -f4) --output j2k.apk
mv -n j2k.apk $(aapt dump badging j2k.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

curl -L $(curl $(curl 'https://api.github.com/repos/inorichi/tachiyomi/releases/latest'|jq '.url'|cut -d\" -f2)|jq '.assets'|grep browser_download_url|cut -d\" -f4) --output stable.apk
mv -n stable.apk $(aapt dump badging stable.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

curl -L 'https://tachiyomi.kanade.eu/latest' --output debug.apk
mv -n debug.apk $(aapt dump badging debug.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

curl -L $(curl $(curl 'https://api.github.com/repos/CarlosEsco/Neko/releases/latest'|jq '.url'|cut -d\" -f2)|jq '.assets'|grep browser_download_url|cut -d\" -f4) --output neko.apk
mv -n neko.apk $(aapt dump badging neko.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

curl -L $(curl $(curl 'https://api.github.com/repos/neverfelly/Meow/releases/latest'|jq '.url'|cut -d\" -f2)|jq '.assets'|grep browser_download_url|cut -d\" -f4) --output meow.apk
mv -n meow.apk $(aapt dump badging meow.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

rm -f meow.apk neko.apk debug.apk stable.apk j2k.apk

# if there's no new files, then exit
#TODO: git stash before dl, and git diff here instead
if diff <(echo "$predl") <(ls) > /dev/null
then exit
fi

# alert me
echo 'New files:'
newstuff=$(diff <(echo "$predl") <(ls) |fgrep '+'|cut -d+ -f2)
echo "$newstuff"

# now move older versions of tachiyomi.debug to archive, if it's been updated
if
  echo "$newstuff"|fgrep eu.kanade.tachiyomi.debug > /dev/null
then
  # if I've messed with it manually, make sure a copy remains
  while test $(ls eu.kanade.tachiyomi.debug*|wc -l) -gt 1
  do mv -vt ../archive $(ls eu.kanade.tachiyomi.debug* -v|head -1)
  done
fi

# now update fdroid
cd /home/efreak/fdroidserver/fdroid
./fdroid.sh update --create-metadata --pretty --use-date-from-apk

# and update git
git add repo archive tmp
git commit -m "Update apps: "$'\n\n'"$newstuff"

# and leave it to be pushed manually
