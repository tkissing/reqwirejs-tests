#!/bin/sh

cloneDependency()
{
    dep="$1"

    rep="$2"
    if [ "$2" == "" ]; then
        rep="requirejs"
    fi

    if [ ! -d "$dep" ]; then
        echo "INFO: Cloning ${rep}/${dep}..."

        RESULT=`git clone https://github.com/${rep}/${dep}.git`

        if [ "$RESULT" != "" ]; then
            echo "FAILED: This build requires ${rep}/${dep}, but failed with ${RESULT}!"
            exit $RESULT;
        fi
    fi

    echo "INFO: Updating ${rep}/${dep}..."
    cd $dep && git fetch origin && git reset --hard origin/master && git pull > /dev/null
    RESULT="$?"
    cd ..


    if [ "$RESULT" != "0" ]; then
        echo "FAILED: Unable to get latest ${rep}/${dep}, failed with ${RESULT}!"
        exit 127;
    fi
}

cloneDependency "text"
cloneDependency "i18n"
cloneDependency "domReady"
cloneDependency "requirejs" "jrburke"
cloneDependency "reqwirejs" "tkissing"

npm install && node server.js
