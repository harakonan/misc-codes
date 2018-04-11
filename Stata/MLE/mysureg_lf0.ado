program mysureg_lf0
	version 11
	args todo b lnfj
	local p : word count $ML_y
	local k = `p'*(`p'+1) / 2 + `p'

	tempname S iS sij isij isi
	tempvar ip
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
	tempvar scorei
	gen double `scorei' = .
	gen double `ip' = 0
	forval i = 1/`p' {
		matrix `isi' = `iS'[`i',1...]
		matrix colnames `isi' = `resids'
		matrix score `scorei' = `isi', replace
		replace `ip' = `ip' + `r`i''*`scorei'
	}
	replace `lnfj' = -0.5*(`p'*ln(2*c(pi))+ln(det(`S'))+`ip')

} // quietly

end
