#!/bin/bash

set -x

# $1 is name of a file containing list of UUIDs to process. Assumes the for each LINE in UUIDs, gs://imaging-west/$LINE is an svs file.

# Save results to external disk
#ROOT=/mnt/disks/dzis
ROOT=/tmp
# Source is in imaging-west bucket
IN=imaging-west
# Results to go to imaging-west-dzis bucket
OUT=imaging-west-dzis

mkdir -p ${ROOT}/${IN}
mkdir -p ${ROOT}/${OUT}

while IFS='' read -r UUID || [[ -n "$UUID" ]]; do
#    FILE=$(gsutil ls gs://${FOLDER_IN}/${UUID}/*.svs)
#    echo "Processing file: $FILE"
#    arrFILE=(${IN//\// })
#    SUBBASE=${arrFILE[-1]}
#    echo "Filename: $SUBBASE"

    # Processed files are in ./done
    if grep -Fxq ${UUID} ./done
    then
        echo ${UUID} " done"
    else

	# Get the GCS path to the .svs file
	PTH=$(gsutil ls gs://isb-tcga-phs000178-open/gdc/${UUID})
	echo $PTH
	# Extract the file name
	FILE=(${PTH//\// })
	echo $FILE
	FILE=${FILE[-1]}
	echo $FILE
	# Remove the .svs extension
	BASE=(${FILE//\.svs/ })
	echo $BASE
	echo "Copying /isb-tcga-phs000178-open/gdc/$UUID/${FILE}"
	mkdir ${ROOT}/${IN}/$UUID
#	gsutil -m cp gs://isb-tcga-phs000178-open/gdc/$UUID/*.svs ${ROOT}/${IN}/${UUID}
	curl -o  ${ROOT}/${IN}/${UUID}/${FILE} https://storage.googleapis.com/isb-tcga-phs000178-open/gdc/$UUID/${FILE}
#	# Get the entire file name as FILE
#	FILE=$(ls ${ROOT}/${IN}/${UUID})

	# Run the tiler 
	docker run -i \
	    -v ${ROOT}/${IN}:/tmp/${IN} \
	    -v ${ROOT}/${OUT}:/tmp/${OUT} \
	    dzit /root/run_tiler.sh ${UUID} ${FILE}

	# If tiling was successful, copy the results to GCS
	if [ $? == 0 ]; then
#	    gsutil -m -q cp -a public-read ${ROOT}/${OUT}/${UUID}.dzi gs://${OUT}-test/${UUID}/${BASE}.dzi
#	    gsutil -m -q cp -r -a public-read ${ROOT}/${OUT}/${UUID}_files gs://${OUT}-test/${UUID}/${BASE}_files
	    gsutil -m -q cp -a public-read ${ROOT}/${OUT}/${UUID}.dzi gs://${OUT}/${UUID}/${BASE}.dzi
	    gsutil -m -q cp -r -a public-read ${ROOT}/${OUT}/${UUID}_files gs://${OUT}/${UUID}/${BASE}_files
	    echo ${UUID} >> done
	else
	    echo "Failure on ${UUID}"
	fi

#	rm -rf ${ROOT}/${IN}/*
#	rm -rf ${ROOT}/${OUT}/*

    fi

done < "$1"
