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

git describe --tags --always > "$GAME_DIR/version"

if [ -d $CCDATA ]
then
	GAME_ZIP=${GAME_ZIP:="$GAME_ASSET.zip"}

	pushd "$GAME_DIR"
	GAME_CCDATA=$(basename $CCDATA)
	zip -r "$OUTDIR/$GAME_ASSET" * -x "$GAME_CCDATA" "$GAME_CCDATA/*" "$GAME_CCDATA/**/*"
	zip -r "$OUTDIR/$GAME_ZIP" "$GAME_CCDATA"
	popd #$GAME_DIR
	
	zip -r "$GAME_ZIP" "$GAME_ASSET"

	sed -r -e "s/game/${GAME_ASSET}/" run.bat > /tmp/run.bat
	sed -r -e "s/game/${GAME_ASSET}/" run.sh > /tmp/run.sh
	pushd /tmp
	zip "$OUTDIR/$GAME_ZIP" run.sh run.bat
	popd
else
	pushd "$GAME_DIR"
	zip -r "$OUTDIR/${GAME_ASSET}" *
	popd #$GAME_DIR
fi

if [ -f "appicon/appicon.png" ]
then
	zip $GAME_ASSET appicon/appicon.png
fi