# Docker for Vicar

Provides dockerfiles for [VICAR](https://github.com/NASA-AMMOS/VICAR)

Currently attempts to provide both ubuntu and centos containers,
but the centos one is turning out to be too much trouble so it will go away

VICAR is installed in the /vos directory but all the commands/environment variables
are already available in tcsh if you start the container


### Work directory
Work within the docker container is expected to occur in the `/data/` folder.
Use that path for volumes or mounts to move data in and out of the docker container.
For example, to use a mount for the current working directory on the host machine,
use docker run with `-v `pwd`:/data` to access data in that folder within docker.


### Calibration configuration
For certain VISOR programs (marsmap etc) VICAR needs a calibration folder for each supported mission.
These files can get very large so they are not included in the docker container. To use calibration data
stored on the host machine, simply store the data in a folder called `calibration` in some directory you want and then
mount the parent directory to `/data/` so that `/data/calibration` is available within the container.
This is done by adding `-v /parent/dir/for/calibration:/data` to the docker run command.

This can also be inside a exclusive docker volume:
```bash
docker volume create vicarcal
# inside the volume
mkdir calibration
# copy mission cal dirs into calibration so ./calibration/m20, ./calibration/mer etc exist
# now run on the host wherever
docker run -it --rm -v vicarcal:/data --platform linux/amd64 -w /data/ vicar:ubuntu /bin/tcsh
```

The `calibration` directory will have the various folders for each supported mission (e.g. `m20`,`mer`, etc)
and the docker container has some smarts to discover those folders at runtime (see `.cshrc`).

## X11 on macOS

If using macOS please:

1. Install XQuartz
2. Enable "Allow Connections from network clients" in XQuartz security settings
3. Quit XQuartz
4. allow access from localhost `xhost + 127.0.0.1`
5. Docker run with the display variable included like `docker run -it --rm -e DISPLAY=host.docker.internal:0  --platform linux/amd64 -w /data/ vicar:ubuntu /bin/tcsh`
6. You can now run `xvd` to see a vicar GUI program

