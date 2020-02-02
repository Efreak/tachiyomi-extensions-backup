# get updates
cd $HOME/tachiyomi-extensions
if
  git fetch && test -z "$(git diff origin/repo)"
then
  echo "Already up to date!"
  echo "Consider ./download_apps.sh"
  exit
fi
git pull

# get a list of new extensions
apkfiles="$(git diff --summary --color=always HEAD@{1} HEAD@{0} apk/*.apk|grep create|sed -E 's/^.*?apk.(.*?\.apk)$/\1/g')"

cd $HOME/fdroidserver/fdroid
# get the current git revision
oldrev=$(git rev-parse HEAD)

for file in $apkfiles
do
	cp $HOME/tachiyomi-extensions/apk/$file repo/$file --preserve=all
done
cd $HOME/fdroidserver/fdroid

git add archive repo metadata tmp
git commit -m "$apkfiles"
git push

./fdroid.sh update --create-metadata --pretty --use-date-from-apk
git add archive repo metadata tmp
git commit --amend --no-edit

# for my personal use
xmllint --format repo/index.xml > repo.xml
xmllint --format archive/index.xml > archive.xml

# output a diff. I only care about apk files...
git diff $oldrev --compact-summary --color=always --relative=fdroid *.apk #|less -XFR

# give a few seconds to avoid pushing. Also keep copies of upstream up to date.
#read -n1 -e -t 30 -p 'Push? <Y/N> ' gitpush
#case $gitpush in
#  [Nn] ) echo "Aborting...Clean it up yourself" $gitrev;;
#  * ) git push
#      git fetch inorichi master:upstream/master > /dev/null
#      git fetch inorichi repo:upstream/repo > /dev/null
#      git push origin master upstream/repo upstream/master;;
#esac
echo "Old hash: $oldrev"
echo "Current hash: $(git rev-parse HEAD)"
