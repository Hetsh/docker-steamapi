# SteamCMD
Small image equipped with steamcmd, intended to be a foundation for game servers.

## Use it
To use this image as a foundation for a game server, simply include it in your Dockerfile:
```Dockerfile
FROM hetsh/steamcmd:<version>
```
`steamcmd.sh` can then be called from everywhere since it is included in `PATH`.

## Ignored Errors
SteamCMD emits a few error and warning messages during different stages of execution despite working properly.
Some can be fixed by adding the "required" libraries, but this would increase the image size by a lot.
For this case, i made the decision to not include them for now, but you can install the libraries if you want:
```Dockerfile
RUN DEBIAN_FRONTEND="noninteractive" && apt-get install --no-install-recommends --assume-yes <package>
```

### [#1](https://github.com/Hetsh/docker-steamcmd/issues/1) Missing libsdl
> Failed to init SDL priority manager: SDL not found  
> Failed to set thread priority: per-thread setup failed  
> Failed to set thread priority: per-thread setup failed  

The debian package is `libsdl2-2.0-0`.

## Fork Me!
This is an open project (visit [GitHub](https://github.com/Hetsh/docker-steamcmd)).
Please feel free to ask questions, file an issue or contribute to it.