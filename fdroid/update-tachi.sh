cd $HOME/fdroidserver/fdroid
mv config.py config.py.censored
mv config.py.bak config.py
cd $HOME/tachiyomi-extensions
git pull
apkfiles="$(git diff --summary HEAD@{1} HEAD@{0} *.apk|grep create|sed -E 's/^.*?apk.(.*?\.apk)$/\1/g')"
cd $HOME/fdroidserver/fdroid
for file in $apkfiles
do
	cp $HOME/tachiyomi-extensions/apk/$file repo/$file
	fdroid update -c --use-date-from-apk #this takes too long. figure out a way to have netlify push the results back to github
	git add archive repo metadata tmp
	git commit -m "$file"
done
cd $HOME/fdroidserver/fdroid
mv config.py config.py.bak
mv config.py.censored config.py
git push

