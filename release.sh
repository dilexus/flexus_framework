#!/bin/bash

#  ./release.sh patch --push --release --version

# current Git branch
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

release=$1

# establish branch and tag name variables
devBranch=develop
masterBranch=master

# file in which to update version number
pubspecFile="pubspec.yaml"

currentVersion=`grep 'version: ' $pubspecFile | sed 's/version: //'`
echo "--------------------------------"
echo "Current Version: $currentVersion"
echo "--------------------------------"
versionCode=${currentVersion##*+}
versionName=${currentVersion/+$versionCode/}
IFS='.' read -r -a versionArray <<< "$versionName"
majorVersion=${versionArray[0]}
minorVersion=${versionArray[1]}
patchVersion=${versionArray[2]}

channel="internal"

if echo $* | grep -e "--v" -q
      then
          exit 1
      fi

if [[ $release == new ]]; then

    if [[ $minorVersion -ge 3 ]]; then
            echo "Releasing New Version"
            perl -i -pe 's/^(version:\s+)(\d+)(\.)(\d+)(\.)(\d+)(\+)(\d+)$/$1.($2+1).$3.(0).$5.(0).$7.($8+1)/e' $pubspecFile
      else
            echo "You cannot start a new version until one in production"
            exit 1
     fi

elif [[ $release == alpha ]]; then

    if echo $* | grep -e "--release" -q
    then
          channel="alpha"
    fi

    if [[ $minorVersion -ge 1 ]]; then
        echo "The App is already in Alpha, Beta or Production. You cannot release Alpha"
        exit 1
    else
        echo "Releasing New Alpha"
        perl -i -pe 's/^(version:\s+\d+\.)(\d+)(\.)(\d+)(\+)(\d+)$/$1.(1).$3.(1).$5.($6+1)/e' $pubspecFile
    fi
elif [[ $release == beta ]]; then

      if echo $* | grep -e "--release" -q
            then
                channel="beta"
      fi

      if [[ $minorVersion -ge 2 ]]; then
           echo "The App is already in Beta or Production. You cannot release Beta"
           exit 1
      else
          echo "Releasing New Beta"
          perl -i -pe 's/^(version:\s+\d+\.)(\d+)(\.)(\d+)(\+)(\d+)$/$1.(2).$3.(1).$5.($6+1)/e' $pubspecFile
      fi
elif [[ $release == production ]]; then

      if echo $* | grep -e "--release" -q
      then
          channel="production"
      else
          echo "Production cannot be released under internal you have to use --release"
          exit 1
      fi

     if [[ $minorVersion -le 2 ]]; then
          echo "Releasing New Production"
          perl -i -pe 's/^(version:\s+\d+\.)(\d+)(\.)(\d+)(\+)(\d+)$/$1.(3).$3.(0).$5.($6+1)/e' $pubspecFile
      else
          echo "Releasing Production"
          perl -i -pe 's/^(version:\s+\d+\.)(\d+)(\.)(\d+)(\+)(\d+)$/$1.('$(($minorVersion + 1))').$3.(0).$5.($6+1)/e' $pubspecFile
      fi

elif [[ $release == patch ]]; then
        perl -i -pe 's/^(version:\s+\d+\.\d+\.)(\d+)(\+)(\d+)$/$1.($2+1).$3.($4+1)/e' $pubspecFile
      if [[ $minorVersion == 0 ]]; then
          echo "Releasing Patch for Internal"
      elif [[ $minorVersion == 1 ]]; then
        echo "Releasing Patch for Alpha"
      elif [[ $minorVersion == 2 ]]; then
        echo "Releasing Patch for Beta"
      else
        echo "Releasing Patch for Production for Internal Testing"
        channel="internal"
      fi
else
    echo "Invalid Release Channel"
    exit 1
fi

if echo $* | grep -e "--internal" -q
then
  channel="internal"
fi


echo "Releasing Channel: $channel"
echo "--------------------------------"
newVersion=`grep 'version: ' $pubspecFile | sed 's/version: //'`
echo "New Version: $newVersion"
newVersionCode=${newVersion##*+}
newVersionName=${newVersion/+$newVersionCode/}
newVersionLabel="v$newVersionName"

echo "Version Tag: $newVersionLabel"
echo "--------------------------------"
fastlane run notification title:"New App Version" message:"$newVersionLabel"
sleep 5


releaseBranch=release/$newVersionLabel

# create the release branch from the -develop branch
git checkout -b $releaseBranch $devBranch

# commit version number increment
git commit -am "Incrementing version number to $newVersionName"

# merge release branch with the new version number into master
git checkout $masterBranch
echo -ne '\n' | git merge --no-ff $releaseBranch

# create tag for new version from -master
git tag $newVersionLabel

# merge release branch with the new version number back into develop
git checkout $devBranch
echo -ne '\n' | git merge --no-ff $releaseBranch

# remove release branch
git branch -d $releaseBranch

git push origin --tags
git push --all origin


if echo $* | grep -e "--android" -q
then
   if [[ $channel == internal ]]; then
        fastlane run notification title:"Android" message:"Android internal release started"
        echo "Building the Internal App"
        fvm flutter build appbundle --no-shrink --target lib/main.dart
   else
       fastlane run notification title:"Android" message:"Android production release started"
       echo "Building the Production App"
       fvm flutter build appbundle --no-shrink --target lib/main_prod.dart
   fi

  cd android
  fastlane run notification title:"Android" message:"Android release started"
  fastlane supply --aab ../build/app/outputs/bundle/release/app-release.aab --track $channel --rollout 1.0 --skip_upload_metadata true --skip_upload_images true --skip_upload_screenshots true --skip_upload_apk true
  cd ..
  echo "Completed Release to Play Store $newVersionName"
  fastlane run notification title:"Android" message:"Completed Release to Play Store $newVersion"

fi

if echo $* | grep -e "--ios" -q
then
  if [[ $channel == internal ]]; then
        fastlane run notification title:"iOS" message:"iOS release started"
        echo "Building the Internal App"
        fvm flutter build ios --target lib/main.dart
        cd ios
        fastlane ios beta
   else
       fastlane run notification title:"iOS" message:"iOS release started"
       echo "Building the Production App"
       fvm flutter build ios --target lib/main_prod.dart
       cd ios
       fastlane ios beta
   fi
  cd ..
  fastlane run notification title:"iOS" message:"Completed Release to Apple Store $newVersion"
  echo "Completed Release to Apple Store $newVersionName"
fi