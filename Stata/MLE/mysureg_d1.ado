program mysureg_d1
	version 11
	args todo b lnf g H
	local p : word count $ML_y
	local k = `p'*(`p'+1) / 2 + `p'

	tempname S iS sij isij isi ip
	matrix `S' = J(`p',`p',0)

quietly {

	// get residuals and build variance matrix
	local e 1
	forval i = 1/`p' {
		tempvar r`i'
		mleval `r`i'' = `b', eq(`i')
		replace `r`i'' = ${ML_y`i'} - `r`i''
		local resids `resids' `r`i''
		mleval `sij' = `b', eq(`=`p'+`e'') scalar
		matrix `S'[`i',`i'] = `sij'
		local ++e
		forval j = `=`i'+1'/`p' {
			mleval `sij' = `b', eq(`=`p'+`e'') scalar
			matrix `S'[`i',`j'] = `sij'
			matrix `S'[`j',`i'] = `sij'
			local ++e
		}
	}
	matrix `iS' = invsym(`S')
	// get score variables
	forval i = 1/`k' {
		tempvar g`i'
		quietly gen double `g`i'' = .
	}
	gen double `ip' = 0
	forval i = 1/`p' {
		matrix `isi' = `iS'[`i',1...]
		matrix colnames `isi' = `resids'
		matrix score `g`i'' = `isi', replace
		replace `ip' = `ip' + `r`i''*`g`i''
	}
	mlsum `lnf' = -0.5*(`p'*ln(2*c(pi))+ln(det(`S'))+`ip')

} // quietly

	if (`todo' == 0 | missing(`lnf')) exit

	// compute the scores and gradient
	tempname gi gs
	capture matrix drop `g'

quietly {

	local e = `p'+1
	forval i = 1/`p' {
		mlvecsum `lnf' `gi' = `g`i'', eq(`i')
		matrix `g' = nullmat(`g'), `gi'
		replace `g`e'' = 0.5*(`g`i''*`g`i''-`iS'[`i',`i'])
		mlvecsum `lnf' `gi' = `g`e'' , eq(`e')
		matrix `gs' = nullmat(`gs'), `gi'
		local ++e
		forval j = `=`i'+1'/`p' {
			replace `g`e'' = `g`i''*`g`j'' - `iS'[`i',`j']
			mlvecsum `lnf' `gi' = `g`e'' , eq(`e')
			matrix `gs' = nullmat(`gs'), `gi'
			local ++e
		}
	}
	matrix `g' = `g' , `gs'

} // quietly

end
