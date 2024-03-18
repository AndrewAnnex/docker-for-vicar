#!/bin/csh

# Change to MARSSUB
cd $MARSSUB

# Loop over all pig_ folders and run makeapp_nounpack
foreach i ($MARSSUB/pig_*)
  $V2UTIL/makeapp_nounpack.sys `basename $i`
end

# Change directory again just in case and then build top level pig
cd $MARSSUB
$V2UTIL/makeapp_nounpack.sys pig $MARSLIB

