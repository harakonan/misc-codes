program mynormal3
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mynormal3") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in] [,		///
		vce(passthru)			///
		HETero(varlist fv)		///
		Level(cilevel)			/// -Replay- option
	]

	// check syntax
	gettoken lhs rhs : varlist
	_fv_check_depvar `lhs'
	// mark the estimation sample
	marksample touse
	markout `touse' `hetero'			//  <- NEW
	_vce_parse `touse', opt(Robust oim opg)		/// <- NEW
		argopt(CLuster): , `vce'		//  <- NEW

	// fit the full model
	ml model lf2 mynormal_lf2			///
		(mu: `lhs' = `rhs')			///
		(lnsigma: `hetero')			///
		if `touse',				///
		`vce'					///
		missing					/// <- NEW
		maximize

	ereturn local cmd mynormal3

	Replay , level(`level')
end

program Replay
	syntax [, Level(cilevel) ]
	ml display , level(`level')
end
