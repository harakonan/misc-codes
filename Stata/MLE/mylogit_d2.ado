program mylogit_d2
	version 11
	args todo b lnf g H g1
	tempvar xb lj
	mleval `xb' = `b'
	quietly {
		gen double `lj' = invlogit( `xb')  if $ML_y1 == 1
		replace    `lj' = invlogit(-`xb')  if $ML_y1 == 0
		mlsum `lnf' = ln(`lj')
		if (`todo'==0 | `lnf' >= .) exit

		replace `g1' =  invlogit(-`xb')  if $ML_y1 == 1
		replace `g1' = -invlogit( `xb')  if $ML_y1 == 0
		mlvecsum `lnf' `g' = `g1', eq(1)
		if (`todo'==1 | `lnf' >= .) exit

		mlmatsum `lnf' `H' = -abs(`g1')*`lj', eq(1,1)
	}
end
