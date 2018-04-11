program myprobit_bad_d2
	version 11
	args todo b lnf g H
	tempvar xb lj
	mleval `xb' = `b'
	quietly {
		gen double `lj'  = normal( `xb')  if $ML_y1 == 1
		replace    `lj'  = normal(-`xb')  if $ML_y1 == 0
		mlsum `lnf' = ln(`lj')
		if (`todo'==0 | `lnf' >= .) exit

		tempvar g1
		gen double `g1' = .
		replace `g1' =  normalden(`xb')/`lj'  if $ML_y1 == 1
		replace `g1' = -normalden(`xb')/`lj'  if $ML_y1 == 0
		mlvecsum `lnf' `g' = `g1', eq(1)
		if (`todo'==1 | `lnf' >= .) exit

		tempvar h
		gen double `h' = `g1'*(`g1'+`xb') if $ML_y1 == 1
		replace    `h' = -`g1'*(`g1'-`xb') if $ML_y1 == 0
		mlmatsum `lnf' `H' = -`h', eq(1)
	}
end
