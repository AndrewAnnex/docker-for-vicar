#!/bin/tcsh

# echo the distro
uname -a

# run basic tests
$R2LIB/gen a
$R2LIB/list a
$R2LIB/copy a b
$R2LIB/label -list b
$R2LIB/list b
$R2LIB/gen c 1024 1024
ls -lahtr