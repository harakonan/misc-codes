program mylogit_lf
	version 11
	args lnf xb
	quietly replace `lnf' = ln(invlogit( `xb')) if $ML_y1 == 1
	quietly replace `lnf' = ln(invlogit(-`xb')) if $ML_y1 == 0
end
