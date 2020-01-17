#!/bin/bash

cd /home/efreak/fdroidserver/fdroid/repo

curl -L $(curl $(curl 'https://api.github.com/repos/jays2kings/tachiyomi/releases/latest'|jq '.url'|cut -d\" -f2)|jq '.assets'|grep browser_download_url|cut -d\" -f4) --output j2k.apk
mv -i j2k.apk $(aapt dump badging j2k.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

curl -L $(curl $(curl 'https://api.github.com/repos/inorichi/tachiyomi/releases/latest'|jq '.url'|cut -d\" -f2)|jq '.assets'|grep browser_download_url|cut -d\" -f4) --output stable.apk
mv -i stable.apk $(aapt dump badging stable.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

curl -L 'https://tachiyomi.kanade.eu/latest' --output debug.apk
mv -i debug.apk $(aapt dump badging debug.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

curl -L $(curl $(curl 'https://api.github.com/repos/CarlosEsco/Neko/releases/latest'|jq '.url'|cut -d\" -f2)|jq '.assets'|grep browser_download_url|cut -d\" -f4) --output neko.apk
mv -i neko.apk $(aapt dump badging neko.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

curl -L $(curl $(curl 'https://api.github.com/repos/neverfelly/Meow/releases/latest'|jq '.url'|cut -d\" -f2)|jq '.assets'|grep browser_download_url|cut -d\" -f4) --output meow.apk
mv -i meow.apk $(aapt dump badging meow.apk|head -1|sed -e "s/'/"'"/g' -Ee 's/.*?name="([^"]+)".*?versionCode="([^"]+)".*?versionName="([^"]+)".+/\1_v\3_\2.apk/g')

rm -f meow.apk neko.apk debug.apk stable.apk j2k.apk
