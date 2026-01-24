#!/bin/sh
set -e

. ./make-vars.sh

LUA=${LUA:=luajit}
GAME_TYPE=${GAME_TYPE:=game}
GAME_ASSET=${GAME_ASSET:=${GAME_TYPE}.love}
GAME_DIR=${GAME_DIR:="$PWD"}

if [ -e $GAME_ASSET ]
then
	rm $GAME_ASSET
fi

OUTDIR="$PWD"

case $(uname | tr '[:upper:]' '[:lower:]') in
	windows*|mingw*|msys*|cygwin*)
		if ! [ -x "$(command -v zip)" ]; then
			ZIP_VERSION=3.0
			ZIP_BIN_ZIP=zip-$ZIP_VERSION-bin.zip
			ZIP_DEP_ZIP=zip-$ZIP_VERSION-dep.zip
			ZIP_BIN_URL=http://downloads.sourceforge.net/gnuwin32/$ZIP_BIN_ZIP
			ZIP_DEP_URL=http://downloads.sourceforge.net/gnuwin32/$ZIP_DEP_ZIP
			if ! [ -f $ZIP_BIN_ZIP ]
			then
				curl -LkO $ZIP_BIN_URL
				unzip -o $ZIP_BIN_ZIP -d zip
			fi
			if ! [ -f $ZIP_DEP_ZIP ]
			then
				curl -LkO $ZIP_DEP_URL
				unzip -o $ZIP_DEP_ZIP -d zip
			fi
			PATH="$PWD/zip/bin:$PATH"
		fi
		;;
esac

cd "$GAME_DIR"
git describe --tags --always > version
zip -r "$OUTDIR/${GAME_ASSET}" *
