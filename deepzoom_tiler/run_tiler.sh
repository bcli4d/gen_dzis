#!/bin/bash

set -x
export FOLDER_IN=/tmp/imaging-west
export FOLDER_OUT=/tmp/imaging-west-dzis

#IN=$BASE
#arrIN=(${IN//\// })
#SUBBASE=${arrIN[0]}

python /usr/share/doc/python-openslide/examples/deepzoom/deepzoom_tile.py -o $FOLDER_OUT/$1 -e 0 -s 256 $FOLDER_IN/$1/$2
if [ $? == 0 ]; then
#    gsutil -m -q cp -r -a public-read $FOLDER/${BASE}_files gs://imaging-west-dzis/${BASE}_files
#    gsutil -m -q cp -a public-read ${FOLDER}/${BASE}.dzi gs://imaging-west-dzis/${BASE}.dzi

#    gsutil -m -q cp -r -a public-read $FOLDER/${BASE}_files gs://imaging-west-dzis-logging/1/${BASE}_files
#    gsutil -m -q cp -a public-read ${FOLDER}/${BASE}.dzi gs://imaging-west-dzis-logging/${BASE}.dzi

#    gsutil -m -q cp -r -a public-read $FOLDER/${BASE}_files gs://imaging-west-dzis/$SUBBASE/
#    gsutil -m -q cp -a public-read ${FOLDER}/${BASE}.dzi gs://imaging-west-dzis/$SUBBASE/
    exit 0
else
    exit 1
fi
