program mynormal4
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mynormal4") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in] [,		///
		vce(passthru)			///
		noLOg				/// <- NEW
		noCONStant			/// <- NEW
		HETero(varlist fv)		///
		Level(cilevel)			/// -Replay- option
		*				/// <- NEW for -mlopts-
	]

	// check syntax
	mlopts mlopts, `options'			// <- NEW
	gettoken lhs rhs : varlist
	_fv_check_depvar `lhs'
	// mark the estimation sample
	marksample touse
	markout `touse' `hetero'
	_vce_parse `touse', opt(Robust oim opg)		///
		argopt(CLuster): , `vce'

	// fit the full model
	ml model lf2 mynormal_lf2			///
		(mu: `lhs' = `rhs', `constant')		/// <- CHANGED
		(lnsigma: `hetero')			///
		if `touse',				///
		`vce'					///
		`log'					/// <- NEW
		`mlopts'				/// <- NEW
		missing					///
		maximize

	ereturn local cmd mynormal4

	Replay , level(`level')
end

program Replay
	syntax [, Level(cilevel) ]
	ml display , level(`level')
end
