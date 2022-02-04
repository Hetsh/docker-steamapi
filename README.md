# SteamAPI
Latest Steam command line client intended to query the Steam API.

## Use it
SteamCMD is included in `PATH` so you can call it like this:
```bash
docker run --rm hetsh/steamapi steamcmd.sh +login anonymous +app_info_print 600760 +quit
```
All available commands can be found in the [developer wiki](https://developer.valvesoftware.com/wiki/Command_Line_Options).

## Creating persistent storage
To keep the login information, you need to create a writeable directory:
```bash
MP="/path/to/storage"
mkdir -p "$MP"
chown -R 1379:1379 "$MP"
```
`1379` is the numerical id of the user running the server (see [Dockerfile](https://github.com/Hetsh/docker-stationeers/blob/master/Dockerfile)).
Start the server with the additional mount flag:
```bash
docker run --mount type=bind,source=/path/to/storage,target=/home/steam ...
```

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-steamcmd)).
Please feel free to ask questions, file an issue or contribute to it.