#!/bin/bash

for D in */
do
    cd $D
    NAME=`echo $D | sed 's/\/\+$//'`
    zip -r ../$NAME.oxt *
    cd ..
done
