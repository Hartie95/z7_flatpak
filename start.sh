
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
PID_FILE="$DATA_DIR/z7/data/.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "$PID_FILE does not exist, creating"
    ./generatePid.sh
fi

blazeId=$(sed -n 's/.*"blazeId"[[:space:]]*:[[:space:]]*\([0-9]\+\).*/\1/p' "$PID_FILE")
nucleusId=$(sed -n 's/.*"nucleusId"[[:space:]]*:[[:space:]]*\([0-9]\+\).*/\1/p' "$PID_FILE")

echo "starting with pid $blazeId and nid: $nucleusId"

flatpak run --command="BlazeServer" com.khysnik.Z7 &
PID1=$!

flatpak run --command="gw2-server" com.khysnik.Z7 -name "hartie95" -pid $blazeId -nid $nucleusId &
PID2=$!

trap "kill $PID1 $PID2>/dev/null; exit" INT TERM

wait $PID1 $PID2
