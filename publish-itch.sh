#!/bin/sh

# Set to your itch username
ORG=ioribranford

VERSION=$1
if [ ! ${VERSION} ]
then
	echo "Usage: publish-itch.sh <VERSION>"
	echo "(after downloading artifacts via download-artifacts.sh)"
	exit 1
fi

PROJECT=${PROJECT:=${PWD##*/}}
BUTLER=${BUTLER:=butler}

publish() {
	CHANNEL=$1
	FILE=${PROJECT}-${VERSION}-${CHANNEL}.zip
	if [ -e ${FILE} ]
	then $BUTLER push --userversion ${VERSION} ${FILE} ${ORG}/${PROJECT}:${CHANNEL}
	fi
}

publish win-64
publish linux-x86_64
publish data
