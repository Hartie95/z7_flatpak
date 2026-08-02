# Flatpak for the [Z7 Launcher](https://github.com/Khysnik/Z7/tree/main/Launcher) (WIP)

## Usage
Starting the launcher:
```sh
flatpak run com.khysnik.Z7
```

Starting all servers, additional paramters will be passed to the gw2-server binary
```sh
flatpak run --command="servers" com.khysnik.Z7
```

Starting all servers with online mode enabled on the default server:
```sh
flatpak run --command="servers" com.khysnik.Z7 -online 208.117.82.46:42220
```

starting just the BlazeServer:
```sh
flatpak run --command="BlazeServer" com.khysnik.Z7
```

starting just the gw2-server:

```sh
flatpak run --command="gw2-server" com.khysnik.Z7
```

## Paths
The main data directory for everything is in `$XDG_DATA_HOME/z7`, which should normally result in `~/.var/app/com.khysnik.Z7/data/z7/`.
The scripts will copy all data from the flatpaks internal directory there, to allow the user to modify those files.
