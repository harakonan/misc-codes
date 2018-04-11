program mynormal2
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mynormal2") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in] [,		///
		vce(passthru)			///
		HETero(varlist fv)		/// <- NEW
		Level(cilevel)			/// -Replay- options
	]

	// check syntax
	gettoken lhs rhs : varlist
	_fv_check_depvar `lhs'

	// mark the estimation sample
	marksample touse

	// fit the full model
	ml model lf2 mynormal_lf2			///
		(mu: `lhs' = `rhs')			///
		(lnsigma: `hetero')			/// <- NEW
		if `touse',				///
		`vce'					///
		maximize

	ereturn local cmd mynormal2

	Replay , level(`level')
end

program Replay
	syntax [, Level(cilevel) ]
	ml display , level(`level')
end
