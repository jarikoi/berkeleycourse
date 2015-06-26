#!/bin/sh
if [ "$#" -ne 1 ]; then
  echo "Usage: userdata.spark "
  exit 1
fi

spark-shell -i $1