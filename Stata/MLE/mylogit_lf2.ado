program mylogit_lf2
	version 11
	args todo b lnfj g1 H
	tempvar xb lj
	mleval `xb' = `b'
	quietly {
		gen double `lj' = invlogit( `xb')  if $ML_y1 == 1
		replace    `lj' = invlogit(-`xb')  if $ML_y1 == 0
		replace `lnfj' = ln(`lj')
		if (`todo'==0) exit

		replace `g1' =  invlogit(-`xb')  if $ML_y1 == 1
		replace `g1' = -invlogit( `xb')  if $ML_y1 == 0
		if (`todo'==1) exit

		mlmatsum `lnfj' `H' = -1*abs(`g1')*`lj', eq(1,1)
	}
end
