#!/bin/bash

SED='sed'

if [ `uname -s` == 'Darwin' ] ; then
  SED='gsed'
fi

bn="`basename $0`"
WORKDIR="$(cd $(dirname $0); pwd -P)"

#
# Default language: zh
# You can overwrite following variables in config file.
#
MSG_INSTALL_PANDOC_FIRST='please install pandoc'
MSG_SUCCESSFULLY_GENERATED='cooking-golang.epub has been build'
MSG_CREATOR='Sinlov'
MSG_DESCRIPTION='This is a given golang development process, various books tips'
MSG_LANGUAGE='en-US'
MSG_TITLE='cooking Golang'
[ -e "$WORKDIR/config" ] && . "$WORKDIR/config"


TMP=`mktemp -d 2>/dev/null || mktemp -d -t "${bn}"` || exit 1
trap 'rm -rf "$TMP"' 0 1 2 3 15


cd "$TMP"

(
[ go list github.com/fairlyblank/md2min >/dev/null 2>&1 ] || export GOPATH="$PWD"
go get -u github.com/fairlyblank/md2min
WORKDIR="$WORKDIR" TMP="$TMP" go run "$WORKDIR/build.go"
)

if [ ! type -P pandoc >/dev/null 2>&1 ]; then
	echo "$MSG_INSTALL_PANDOC_FIRST"
	exit 0
fi

cat <<__METADATA__ > metadata.txt
<dc:creator>$MSG_CREATOR</dc:creator>
<dc:description>$MSG_DESCRIPTION</dc:description>
<dc:language>$MSG_LANGUAGE</dc:language>
<dc:rights>Creative Commons</dc:rights>
<dc:title>$MSG_TITLE</dc:title>
__METADATA__

mkdir -p $TMP/images
cp -r $WORKDIR/images/* $TMP/images/
ls [0-9]*.html | xargs $SED -i "s/png?raw=true/png/g"

pandoc --reference-links -S --toc -f html -t epub --epub-metadata=metadata.txt --epub-cover-image="$WORKDIR/../images/cover_cooking-golang.png" -o "$WORKDIR/cooking-golang.epub" `ls [0-9]*.html | sort`

echo "$MSG_SUCCESSFULLY_GENERATED"
