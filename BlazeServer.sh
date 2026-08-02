#!/bin/bash
## load utils.sh and do the base setup
source /app/z7/utils.sh
copy_files
cd $Z7_BASE_DATA_DIR

exec env TMPDIR="${XDG_CACHE_HOME}" /app/z7/BlazeServer "${FLAGS[@]}" "$@"
