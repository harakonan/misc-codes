program myweibullb_d1
	version 11
	args todo b lnf g H

	if ($ML_ic==$MAXITER) exit 1

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
	
		tempname d1 d2
		mlvecsum `lnf' `d1'  = `p'*(`M'-`d') , eq(1)
		mlvecsum `lnf' `d2'  = `d' - `R'*`p'*(`M'-`d'), eq(2)
		matrix `g' = (`d1',`d2')
	}
end
