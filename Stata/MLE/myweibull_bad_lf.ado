program myweibull_bad_lf
	version 11
	args lnfj leta lgam
	tempvar p M R
	quietly {
		gen `p' = exp(`lgam')
		gen `M' = ($ML_y1*exp(-`leta'))^`p'
		gen `R' = ln($ML_y1)-`leta'
		replace `lnfj' = -`M' + $ML_y2*(`lgam'-`leta'+(`p'-1)*`R')
	}
end
