program mynormal5
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mynormal5") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in]		///
		[fweight pweight] [,		/// <- NEW
		noLOg				/// -ml model- options
		noCONStant			///
		vce(passthru)			///
		HETero(varlist fv)		///
		Level(cilevel)			/// -Replay- option
		*				/// -mlopts- options
	]

	// check syntax
	mlopts mlopts, `options'
	gettoken lhs rhs : varlist
	_fv_check_depvar `lhs'
	if "`weight'" != "" {				// NEW block
		local wgt "[`weight'`exp']"
	}
	// mark the estimation sample
	marksample touse
	markout `touse' `hetero'
	_vce_parse `touse', opt(Robust oim opg)		///
		argopt(CLuster): `wgt' , `vce'		//  <- CHANGED
	if "`r(cluster)'" != "" {
		markout `touse' `r(cluster)', strok
	}
                                                

	// fit the full model
	ml model lf2 mynormal_lf2				///
		(mu: `lhs' = `rhs', `constant')		///
		(lnsigma: `hetero')			///
		`wgt' if `touse',			/// <- CHANGED
		`vce'					///
		`log'					///
		`mlopts'				///
		missing					///
		maximize

	ereturn local cmd mynormal5

	Replay , level(`level')
end

program Replay
	syntax [, Level(cilevel) ]
	ml display , level(`level')
end
