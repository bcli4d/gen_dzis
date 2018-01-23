#!/bin/bash

date
dsub \
    --preemptible \
    --name run.6 \
    --disk-size 20 \
    --project cgc-05-0003 \
    --logging gs://imaging-west-dzis-logging/run.6/ \
    --zones 'us-west1-c' \
    --image gcr.io/cgc-05-0003/deepzoom_tiler \
    --tasks ./notdone.tsv 133-1132 \
    --script ./run_tiler.sh

