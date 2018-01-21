#!/bin/bash

date
dsub \
    --preemptible \
    --name run.4 \
    --project isb-cgc \
    --logging gs://imaging-west-dzis-logging/run.4/ \
    --zones 'us-west1-*' \
    --image gcr.io/isb-cgc/deepzoom_tiler \
    --tasks ./notdone.tsv 1 \
    --script ./run_tiler.sh

