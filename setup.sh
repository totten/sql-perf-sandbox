#!/bin/bash

amp create -f --skip-url
amp sql < install.sql
mkdir -p tmp

PREV=0
INTERVAL=20000
TOTAL=2000000
for NEXT in $( seq $INTERVAL $INTERVAL $TOTAL )  ; do
  echo "Batch $PREV..$NEXT"
  php fill.php $PREV $NEXT > tmp/fill-$NEXT.sql
  echo "source tmp/fill-$NEXT.sql" | amp sql
  PREV=$NEXT
done