program mynormal_d1
	version 11
	args todo b lnf g H g1 g2
	tempvar mu lnsigma sigma
	mleval `mu' = `b', eq(1)
	mleval `lnsigma' = `b', eq(2)
	quietly {
		gen double `sigma' = exp(`lnsigma')
		mlsum `lnf' = ln( normalden($ML_y1,`mu',`sigma') )
		if (`todo'==0 | `lnf' >= .) exit

		tempvar z
		tempname dmu dlnsigma
		gen double `z' = ($ML_y1-`mu')/`sigma'
		replace `g1' = `z'/`sigma'
		replace `g2' = `z'*`z'-1
		mlvecsum `lnf' `dmu' = `g1'		, eq(1)
		mlvecsum `lnf' `dlnsigma' = `g2'	, eq(2)
		matrix `g' = (`dmu', `dlnsigma')
	}
end
