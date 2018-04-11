program myprobit_gf0_good

	args todo b lnfj

	tempvar xb
	quietly generate double `xb' = `b'[1,1]*weight + `b'[1,2]*price + ///
				       `b'[1,3]

	quietly replace `lnfj' = ln(normal(`xb')) if $ML_y1 == 1
	quietly replace `lnfj' = ln(normal(-1*`xb')) if $ML_y1 == 0

end
