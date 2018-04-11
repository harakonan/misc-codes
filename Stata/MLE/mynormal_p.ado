program mynormal_p
	syntax anything(id="newvarname") [if] [in] [, LNSigma SIGma * ]

	if "`lnsigma'" != "" {
		syntax newvarname [if] [in] [, LNSigma ]
		_predict `typlist' `varlist' `if' `in', equation(lnsigma)
		label variable `varlist' "predicted ln(sigma)"
		exit
	}

	if "`sigma'" != "" {
		syntax newvarname [if] [in] [, SIGma ]
		_predict `typlist' `varlist' `if' `in', equation(lnsigma)
		quietly replace `varlist' = exp(`varlist')
		label variable `varlist' "predicted sigma"
		exit
	}

	// let -ml_p- handle all other cases
	ml_p `0'
end
