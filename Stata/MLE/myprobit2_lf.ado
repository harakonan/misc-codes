program myprobit2_lf
	version 11
	args lnfj xb
	quietly replace `lnfj' = ln(normal( `xb')) if $ML_y1==1 & $ML_samp==1
	quietly replace `lnfj' = ln(normal(-`xb')) if $ML_y1==0 & $ML_samp==1
end
