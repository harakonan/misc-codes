program myweibull_d1
	version 11
	args todo b lnf g H
	tempvar leta lgam p M R
	mleval `leta' = `b', eq(1)
	mleval `lgam' = `b', eq(2)
	local t "$ML_y1"
	local d "$ML_y2"
	quietly {
		gen double `p' = exp(`lgam')
		gen double `M' = (`t'*exp(-`leta'))^`p'
		gen double `R' = ln(`t')-`leta'
		mlsum `lnf' = -`M' + `d'*(`lgam'-`leta' + (`p'-1)*`R')
		if (`todo'==0 | `lnf'>=.) exit
	
		tempvar g1 g2
		gen double `g1' = `p'*(`M'-`d')
		gen double `g2' = `d' - `R'*`p'*(`M'-`d')
		tempname d1 d2
		mlvecsum `lnf' `d1'  = `g1', eq(1)
		mlvecsum `lnf' `d2'  = `g2', eq(2)
		matrix `g' = (`d1',`d2')
	}
end
