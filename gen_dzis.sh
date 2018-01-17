#!/bin/bash

date
dsub \
    --name run.1 \
    --project isb-cgc \
    --logging gs://imaging-west-dzis/perf/run.1/logs \
    --zones 'us-west1-*' \
    --image gcr.io/isb-cgc/openslide \
    --tasks ./notdone.tsv \
    --command \
'/usr/.../deepzoom_tile.py \
  --overlap=06 \
  --size=256 \
  
