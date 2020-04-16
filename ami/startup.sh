#! /bin/bash

if [ -z "$1" ] ;
then
    echo Please specify a folder
    exit
fi

cd $1
if [ ! -f "Dockerfile" ] ; 
then
    echo "Could not find Dockerfile"
    exit
fi

egrep '^ENTRYPOINT' < Dockerfile | sed -e 's/^ENTRYPOINT.*bash"/bash/' -e 's/,.?*"/ /' -e 's/"\].*$//'
