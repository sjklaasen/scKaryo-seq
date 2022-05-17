#!/bin/bash

set -eu # stop on error

for i in *; do

 awk '$5 != "-"' < "$i" > "$i.new" && mv "$i.new" "$i"

done
