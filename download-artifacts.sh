#!/bin/sh
set -e

# Set to your itch username
ORG=ioribranford

VERSION=$1
if [ ! ${VERSION} ]
then
	echo "Usage: download-artifacts.sh <VERSION>"
	exit 1
fi

if [ ! -e pat ]
then
	echo "Need a personal access token file 'pat'"
	exit 1
fi

PROJECT=${PROJECT:=${PWD##*/}}

download() {
	TAG=$1
	JOB=$2
	URL="https://gitlab.com/api/v4/projects/$ORG%2F$PROJECT/jobs/artifacts/$TAG/download?job=$JOB"
	curl -Lk -o $PROJECT-$VERSION-$JOB.zip --header "PRIVATE-TOKEN: $(cat pat)" "$URL"
}

download ${VERSION} windows
download ${VERSION} linux-x86_64
download ${VERSION} data
