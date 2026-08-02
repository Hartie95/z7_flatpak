

DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
Z7_BASE_DATA_DIR="$DATA_DIR/z7"
Z7_DATA_DIR="$Z7_BASE_DATA_DIR/data"
Z7_PID_PATH="$Z7_DATA_DIR/.pid"
Z7_CONFIG_PATH="$Z7_DATA_DIR/config.json"

## This copies the data files that don't exist yet from the flatpak into the data dir,
## since some of the resources are expected to be modified by the user and the server writes intop these directories too
copy_files () {
    mkdir -p "$Z7_BASE_DATA_DIR"
    cd "/app/z7/"
    cp -rn certs $Z7_BASE_DATA_DIR
    cp -rn data $Z7_BASE_DATA_DIR
    cp -rn files $Z7_BASE_DATA_DIR
    cp -n courgette.exe $Z7_BASE_DATA_DIR
    cp -n PreEAAC.patch $Z7_BASE_DATA_DIR
    cp -n Z7.patch $Z7_BASE_DATA_DIR
}

## This is based on the launchers blazeId and nucleusId generation.
## The target is also based on it, and stores it in data/.pid
check_generate_pid () {

    if [ -f "$Z7_PID_PATH" ]; then
        echo ".pid exists"
        return
    fi

    BASE_BLAZE_ID=2013800000000
    BASE_NUCLEUS_ID=2029500000000
    BLAZE_ID=$((BASE_BLAZE_ID + $(shuf -i 0-99999999 -n1)))
    NUCLEUS_ID=$((BASE_NUCLEUS_ID + $(shuf -i 0-99999999 -n1)))

    echo "generated blazeId: $BLAZE_ID and nucleusId: $NUCLEUS_ID"

    echo "saving .pid file to $Z7_PID_PATH"
    mkdir -p "$Z7_DATA_DIR"
    echo -e "{\n  \"blazeId\":$BLAZE_ID,\n  \"nucleusId\":$NUCLEUS_ID\n}" > "$Z7_PID_PATH"
}

## returns the blazeId/pid for use with the gw2 server from the pid file
read_blaze_id () {
    echo $(sed -n 's/.*"blazeId"[[:space:]]*:[[:space:]]*\([0-9]\+\).*/\1/p' "$Z7_PID_PATH")
}

## returns the nucleusId for use with the gw2 server from the pid file
read_nucleus_id () {
    echo $(sed -n 's/.*"nucleusId"[[:space:]]*:[[:space:]]*\([0-9]\+\).*/\1/p' "$Z7_PID_PATH")
}

## returns the username for use with the gw2 server from the launchers config file
read_username () {
    echo "$(sed -n 's/.*"persona"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$Z7_CONFIG_PATH")"
}
