program myprobit_bad_d0
	version 11
	args todo b lnf
	tempvar xb lnfj
	mleval `xb' = `b'
	quietly {
		gen double `lnfj' = ln(  normal(`xb'))  if $ML_y1 == 1
		replace    `lnfj' = ln(1-normal(`xb'))  if $ML_y1 == 0
		replace    `lnfj' = sum(`lnfj')
		scalar `lnf' = `lnfj'[_N]
	}
end
