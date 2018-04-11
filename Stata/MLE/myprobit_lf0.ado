program myprobit_lf0
	version 11
	args todo b lnfj
	tempvar xb
	mleval `xb' = `b'
	quietly replace `lnfj' = ln(normal( `xb')) if $ML_y1 == 1
	quietly replace `lnfj' = ln(normal(-`xb')) if $ML_y1 == 0
end
