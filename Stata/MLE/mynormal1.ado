program mynormal1
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mynormal1") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in] [,		///
		vce(passthru)			///
		Level(cilevel)			/// -Replay- option
	]

	// check syntax
	gettoken lhs rhs : varlist
	// mark the estimation sample
	marksample touse

	// fit the full model
	ml model lf2 mynormal_lf2			///
		(mu: `lhs' = `rhs')			///
		/lnsigma				///
		if `touse',				///
		`vce'					///
		maximize

	ereturn local cmd mynormal1

	Replay , level(`level')
end

program Replay
	syntax [, Level(cilevel) ]
	ml display , level(`level')
end
