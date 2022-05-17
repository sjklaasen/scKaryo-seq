#!/bin/bash

set -eu # stop on error

for i in {1..384}; do

 mv "$i" "Suzanne_$i.bed"

done
