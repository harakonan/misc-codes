program myprobit_lf
	version 11
	args lnfj xb
	quietly replace `lnfj' = ln(normal( `xb')) if $ML_y1 == 1
	quietly replace `lnfj' = ln(normal(-`xb')) if $ML_y1 == 0
end
