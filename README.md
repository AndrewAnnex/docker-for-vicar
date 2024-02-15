# Docker for Vicar

Provides dockerfiles for [VICAR](https://github.com/NASA-AMMOS/VICAR)

Currently attempts to provide both ubuntu and centos containers,
but the centos one is turning out to be too much trouble so it will go away


## X11 on macOS

If using macOS please:

1. Install XQuartz
2. Enable "Allow Connections from network clients" in XQuartz security settings
3. Quit XQuartz
4. allow access from localhost `xhost + 127.0.0.1`
5. Docker run with the display variable included like `docker run -it --rm -e DISPLAY=host.docker.internal:0  --platform linux/amd64 -w /data/ vicar:ubuntu /bin/tcsh`
6. You can now run `xvd` to see a vicar GUI program