program mysuregc_d2
	// concentrated likelihood for the SUR model
	version 11
	args todo b lnf g H
	local p : word count $ML_y
	tempname W sumw

	// get residuals and build variance matrix
	forval i = 1/`p' {
		tempvar r`i'
		mleval `r`i'' = `b', eq(`i')
		quietly replace `r`i'' = ${ML_y`i'} - `r`i''
		local resids `resids' `r`i''
	}
	quietly matrix accum `W' = `resids' [iw=$ML_w] if $ML_samp, noconstant
	scalar `sumw' = r(N)
	matrix `W' = `W'/`sumw'
	scalar `lnf' = -0.5*`sumw'*(`p'*(ln(2*c(pi))+1)+ln(det(`W')))

	if (`todo' == 0 | missing(`lnf')) exit

	// compute gradient
	tempname gi iW iWi
	tempvar  scorei
	quietly generate double `scorei' = .
	capture matrix drop `g'
	matrix `iW' = invsym(`W')
	forval i = 1/`p' {
		matrix `iWi' = `iW'[`i',1...]
		matrix colnames `iWi' = `resids'
		matrix score `scorei' = `iWi', replace
		mlvecsum `lnf' `gi' = `scorei', eq(`i')
		matrix `g' = nullmat(`g'), `gi'
	}

	if (`todo' == 1 | missing(`lnf')) exit

	// compute the Hessian, as if we were near the solution
	tempname hij
	local k = colsof(`b')
	matrix `H' = J(`k',`k',0)
	local r 1
	forval i = 1/`p' {
		local c `r'
		mlmatsum `lnf' `hij' = -1*`iW'[`i',`i'], eq(`i')
		matrix `H'[`r',`c'] = `hij'
		local c = `c' + colsof(`hij')
		forval j = `=`i'+1'/`p' {
			mlmatsum `lnf' `hij' = -1*`iW'[`i',`j'], eq(`i',`j')
			matrix `H'[`r',`c'] = `hij'
			matrix `H'[`c',`r'] = `hij''
			local c = `c' + colsof(`hij')
		}
		local r = `r' + rowsof(`hij')
	}

end
