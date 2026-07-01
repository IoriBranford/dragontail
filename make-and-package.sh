#!/bin/sh
set -e

. ./make-vars.sh

VERSION=$1

if [[ $# -le 0 ]]
then
    echo "Need version"
fi

if [[ $# -le 1 ]]
then
    echo "Need one or more platforms: windows, linux, game"
fi

if [[ $# -lt 2 ]]
then
    exit 1
fi

declare -A PLATFORM_CONTENTS
declare -A PLATFORM_FULL
PLATFORM_CONTENTS["linux"]="$GAME_TITLE_NOSPACE-x86_64"
PLATFORM_FULL["linux"]="linux-x86_64"
PLATFORM_CONTENTS["windows"]="$GAME_TITLE"
PLATFORM_FULL["windows"]="win-64"
PLATFORM_CONTENTS["game"]=${GAME_ASSET:="$PROJECT.love"}
PLATFORM_FULL["game"]="data"

for PLATFORM in ${*:2}
do
    # echo $PLATFORM
    ./make-${PLATFORM}.sh
    CONTENTS=${PLATFORM_CONTENTS[$PLATFORM]}
    FULL_PLATFORM=${PLATFORM_FULL[$PLATFORM]}
    # echo zip -r "$PROJECT-$VERSION-$FULL_PLATFORM.zip" "$CONTENTS"
    if [[ -e "$CONTENTS" ]]
    then
        zip -r "$PROJECT-$VERSION-$FULL_PLATFORM.zip" "$CONTENTS"
    fi
done
