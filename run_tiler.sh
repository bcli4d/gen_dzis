#!/bin/bash

set -x
export FOLDER=/mnt/data/gs/imaging-west-dzis

python /usr/share/doc/python-openslide/examples/deepzoom/deepzoom_tile.py -j 1 -o $FOLDER/$BASE -e 0 -s 256 $INPUT_FILE
if [ $? == 0 ]; then
    gsutil -m -q cp -r -a public-read $FOLDER/${BASE}_files gs://imaging-west-dzis-logging/${BASE}_files
    gsutil -m -q cp -a public-read ${FOLDER}/${BASE}.dzi gs://imaging-west-dzis-logging/${BASE}.dzi
    exit 0
else
    exit 1
fi
