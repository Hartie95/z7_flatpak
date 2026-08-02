#!/bin/bash

## load utils.sh and do the base setup
source /app/z7/utils.sh
copy_files
check_generate_pid
cd $Z7_BASE_DATA_DIR

## check for parameters, of not there read names from the configs the launcher uses
has_pid=false
has_nid=false
has_name=false

extra_args=()

for arg in "$@"; do
    case "$arg" in
        -pid | -pid=*)
            has_pid=true
            ;;
        -nid | -nid=*)
            has_nid=true
            ;;
        -name | -name=*)
            has_name=true
            ;;
    esac
done

if ! "$has_pid"; then
    blaze_id=$(read_blaze_id)

    extra_args+=("-pid" "$blaze_id")
fi

if ! "$has_nid"; then
    nucleus_id=$(read_nucleus_id)

    extra_args+=("-nid" "$nucleus_id")
fi

if ! "$has_name"; then
    name="$(read_username)"

    extra_args+=("-name" "$name")
fi

echo "added arguments: ${extra_args[@]}"
exec env TMPDIR="${XDG_CACHE_HOME}" /app/z7/gw2-server "${FLAGS[@]}" "$@" "${extra_args[@]}"
