program myprobit_d1
	version 11
	args todo b lnf g H g1
	tempvar xb lj
	mleval `xb' = `b'
	quietly {
		gen double `lj'  = normal( `xb')  if $ML_y1 == 1
		replace    `lj'  = normal(-`xb')  if $ML_y1 == 0
		mlsum `lnf' = ln(`lj')
		if (`todo'==0 | `lnf' >= .) exit

		replace `g1' =  normalden(`xb')/`lj'  if $ML_y1 == 1
		replace `g1' = -normalden(`xb')/`lj'  if $ML_y1 == 0
		mlvecsum `lnf' `g' = `g1', eq(1)
	}
end
