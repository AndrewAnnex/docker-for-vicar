# Docker for Vicar

Provides dockerfiles for [VICAR](https://github.com/NASA-AMMOS/VICAR)

Currently attempts to provide an ubuntu container.

VICAR is installed in the /vos directory but all the commands/environment variables
are already available in tcsh if you start the container


### Work directory
Work within the docker container is expected to occur in the `/data/` folder.
Use that path for volumes or mounts to move data in and out of the docker container.
For example, to use a mount for the current working directory on the host machine,
use docker run with `-v `pwd`:/data` to access data in that folder within docker.
Just make sure the permissions on the work directory on the host machine are permissive (777).


### Calibration configuration
For certain VISOR programs (marsmap etc) VICAR needs a calibration folder for each supported mission.
These files can get very large so they are not included in the docker container. To use calibration data
stored on the host machine, simply store the data in a folder in some directory you want and then
mount the parent directory to `/calibration` so it is available within the container.
This is done by adding `-v <HOSTFOLDER>:/calibration` to the docker run command.
Below we actually make it a named volume on host using the docker volume command.

This can also be inside a exclusive docker volume:
```bash
docker volume create vicarcal
#
# inside the volume copy mission cal dirs into calibration so ./m20, ./mer etc exist
# now run on the host wherever
docker run -it --rm -v vicarcal:/calibration -v <HOSTWORKDIR>:/data --platform linux/amd64 -w /data/ vicar:ubuntu /bin/tcsh
```

The `/calibration` directory will have the various folders for each supported mission (e.g. `m20`,`mer`, etc)
and the docker container has some smarts to discover those folders at runtime (see `.cshrc`).


### Compiling VICAR
This is a bit of a work in progress still, but if you have a git repo of VICAR you are developing in on the host, you can compile within the docker container by following the steps below:

1. add a mount for the vos directory to the docker run step like `-v HOSTVICAR/vos:/vossrc`
2. Inside the container run `rsync -crhv --out-format="[%t]:%o:%f" /vossrc/ $V2TOP` to sync the updated files inside the container
3. Rebuild something like MARS sub `cd $MARSSUB && $V2UTIL/bldcomfiles_nounpack.csh $MARSLIB`

#### Compiling VICAR with source on host
Say you are editing VICAR source code on a host machine and want to compile it within a docker container and then save the resulting container as an image.

you would run:
```bash
docker run -w /data/ -v /path/to/host/src/VICAR/vos/:/vossrc --name vicar_compiled --platform linux/amd64 vicar:ubuntu 'source ~/.cshrc && update_mars'
```

The volume will make the host machine's VICAR source code directory available in the container and the aliases within .cshrc will take care of building the MARS programs in VICAR.

Then just use docker commit to save the final container as a new image.

```bash
docker container commit <sha of container> vicarprod
```

then you can use that container name (vicarprod) in place of the other names and run one-off commands like 

```bash
!docker run -t --rm -w /data/  -v vicarcal:/calibration -v ./path/to/host/data/:/data  vicarprod:latest 'source ~/.cshrc && $MARSLIB/marsrelabel inp=in.vic out=out.vic -cm'

```

## X11 on macOS

If using macOS please:

1. Install XQuartz
2. Enable "Allow Connections from network clients" in XQuartz security settings
3. Quit XQuartz
4. allow access from localhost `xhost + 127.0.0.1`
5. Docker run with the display variable included like `docker run -it --rm -e DISPLAY=host.docker.internal:0  --platform linux/amd64 -w /data/ vicar:ubuntu /bin/tcsh`
6. You can now run `xvd` to see a vicar GUI program

