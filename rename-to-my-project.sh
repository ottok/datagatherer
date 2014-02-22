#!/bin/bash

# script for renaming harbour-helloworld-pro-sailfish into whatever you want you project to be

# Check if input is correct

# Replace text and rename files in the same cycle

EXPECTED_ARGS=1

if [[ $# -ne $EXPECTED_ARGS ]]; then
  echo "Usage: $(basename $0) harbour-my-cool-app-name"
  exit
fi

newname=$1
if [[ $newname != harbour-* ]]; then
  echo Your new app name MUST start with \"harbour-\"
  exit
fi

echo Replacing "harbour-helloworld-pro-sailfish" with "$newname"

# First rename files
for fl in $(find .  -name .git -prune -o -type f -name 'harbour-helloworld-pro-sailfish*' -print); do
    mv $fl ${fl/harbour-helloworld-pro-sailfish/$newname}
    echo Renamed $fl to ${fl/harbour-helloworld-pro-sailfish/$newname}
done

# Then do substitutions in non-binary files only
# This magic find line is iterating over non-binary files
for fl in `find . -type f -print | xargs file | grep ASCII | cut -d: -f1`
do
    # Ignore this particular file and everything inside .git dir
    if [[ "$fl" =~ "rename-to-my-project.sh" || "$fl" =~ ".git/" ]]
    then
         continue
    fi

    mv $fl $fl.old

    sed "s/harbour-helloworld-pro-sailfish/$newname/g" $fl.old > $fl
    rm -f $fl.old
    echo Updated $fl
done

#Then specifically rename stuff inside *.sh files (shell file is executable, so isn't handled) by the previous step
for fl in `find . -type f -name \*.sh -print`
do
    # Ignore this particular file and everything inside .git dir
    if [[ "$fl" =~ "rename-to-my-project.sh" || "$fl" =~ ".git/" ]]
    then
         continue
    fi

    mv $fl $fl.old

    sed "s/harbour-helloworld-pro-sailfish/$newname/g" $fl.old > $fl
    rm -f $fl.old
    echo Updated $fl
done

echo Done. Enjoy your $newname app!
