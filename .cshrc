# discover calibration files at runtime looking in /data/calibration/
set cal_path = "/data/calibration/"
set cal_dirs = `ls -d $cal_path/*/`
setenv ACC_MARS_CONFIG_PATH ""

foreach dir ($cal_dirs)
  setenv ACC_MARS_CONFIG_PATH "${ACC_MARS_CONFIG_PATH}${dir}:"
end

setenv MARS_CONFIG_PATH `echo $ACC_MARS_CONFIG_PATH | sed 's/:$//' | sed 's/\/\//\//g' | sed 's/\/:/:/g' | sed 's/\/$//'`

if ($?V2TOP == 0) then
	setenv V2TOP /vos
	source $V2TOP/vicset1.csh
	source $V2TOP/vicset2.csh
else
	source $V2TOP/vicset2.csh
endif

setenv MARS_CONFIG_PATH `echo $ACC_MARS_CONFIG_PATH | sed 's/:$//' | sed 's/\/\//\//g' | sed 's/\/:/:/g' | sed 's/\/$//'`
