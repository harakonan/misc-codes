program myweibull_d0
	version 11
	args todo b lnf
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
	}
end
