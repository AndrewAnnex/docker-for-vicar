# discover calibration files at runtime looking in /data/calibration/
set filec
set autolist
set complete = enhance

setenv ACC_MARS_CONFIG_PATH ""
set cal_path = "/calibration/"
if ( -d /calibration/ ) then
    set cal_dirs = `ls -d $cal_path/*/`
    foreach dir ($cal_dirs)
      setenv ACC_MARS_CONFIG_PATH "${ACC_MARS_CONFIG_PATH}${dir}:"
    end
    setenv MARS_CONFIG_PATH `echo $ACC_MARS_CONFIG_PATH | sed 's/:$//' | sed 's/\/\//\//g' | sed 's/\/:/:/g' | sed 's/\/$//'`
endif

if ($?V2TOP == 0) then
    setenv V2TOP /vos
	source $V2TOP/vicset1.csh
	source $V2TOP/vicset2.csh
else
	source $V2TOP/vicset2.csh
endif

if (! $?ACC_MARS_CONFIG_PATH == "") then
    setenv MARS_CONFIG_PATH `echo $ACC_MARS_CONFIG_PATH | sed 's/:$//' | sed 's/\/\//\//g' | sed 's/\/:/:/g' | sed 's/\/$//'`
endif

alias update_vos 'rsync -crhv --out-format="[%t]:%o:%f" /vossrc/ $V2TOP && cd /data'
alias update_getproj 'update_vos && cd $V2TOP/p2/sub && $V2UTIL/makeapp_nounpack.sys getproj && cd /data'
alias update_pigs_and_pig '~/update_pigs.csh && cd /data'
alias update_pigs 'update_getproj && update_pigs_and_pig && cd /data'
alias update_marssub 'update_pigs && cd $MARSSUB && $V2UTIL/bldcomfiles_nounpack.csh $MARSLIB && cd /data'
alias update_marsmap 'update_marssub && cd $MARSSOURCE && $V2UTIL/makeapp_nounpack.sys marsmap $MARSLIB && cd /data'
alias update_mars 'update_marssub && cd $MARSSOURCE && $V2UTIL/bldcomfiles_nounpack.csh $MARSLIB && cd /data'
