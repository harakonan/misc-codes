program mynormal12, properties(svyb svyj svyr swml)
	// NEW properties      ^^^^^^^^^^^^^^
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mynormal12") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in]		///
		[fweight pweight iweight] [,	/// <- ADDED iweight
		noLOg				/// -ml model- options
		noCONStant			///
		vce(passthru)			///
		HETero(varlist fv)		///
		noLRTEST			///
		OFFset(varname numeric)		///
		EXPosure(varname numeric)	///
		Level(cilevel)			/// -Replay- options
		EForm				///
		*				/// -mlopts- options
	]

	// check syntax
	mlopts mlopts, `options'
	local cns `s(constraints)'
	gettoken lhs rhs : varlist
	_fv_check_depvar `lhs'
	if "`weight'" != "" {
		local wgt "[`weight'`exp']"
		// for initial value calculations
		if "`weight'" == "pweight" {
			local awgt "[aw`exp']"
		}
		else	local awgt "`wgt'"

	}
	if "`log'" != "" {
		local qui quietly
	}
	if `"`hetero'"' == "" {
		local diparm diparm(lnsigma, exp label("sigma"))
	}
	if "`offset'" != "" {
		local offopt "offset(`offset')"
	}
	if "`exposure'" != "" {
		local expopt "exposure(`exposure')"
	}

	// mark the estimation sample
	marksample touse
	markout `touse' `hetero' `offset' `exposure'
	_vce_parse `touse', opt(Robust oim opg) argopt(CLuster): `wgt', `vce'

	if "`constant'" == "" {
		// initial values
		quietly sum `lhs' `awgt' if `touse'
		local mean = r(mean)
		local lnsd = ln(r(sd))+ln((r(N)-1)/r(N))/2
		local initopt init(/mu=`mean' /lnsigma=`lnsd') search(off)

		`qui' di as txt _n "Fitting constant-only model:"
		ml model lf mynormal_lf				///
			(mu: `lhs' =, `offopt' `expopt' )	///
			(lnsigma: `hetero')			///
			`wgt' if `touse',			///
			`log'					///
			`mlopts'				///
			`initopt'				///
			nocnsnotes				///
			missing					///
			maximize
		if "`lrtest'" == "" {
			local contin continue search(off)
		}
		else {
			tempname b0
			mat `b0' = e(b)
			local contin init(`b0') search(off)
		}
		`qui' di as txt _n "Fitting full model:"
	}

	// fit the full model
	ml model lf2 mynormal_lf2			///
		(mu: `lhs' = `rhs',			///
			`constant' `offopt' `expopt'	///
		)					///
		(lnsigma: `hetero')			///
		`wgt' if `touse',			///
		`vce'					///
		`log'					///
		`mlopts'				///
		`contin'				///
		`diparm'				///
		missing					///
		maximize

	if "`hetero'" == "" {
		ereturn scalar k_aux = 1
	}
	else	ereturn scalar k_aux = 0
	ereturn local cmd mynormal12

	Replay , level(`level') `eform'
end

program Replay
	syntax [, Level(cilevel) EForm ]
	ml display , level(`level') `eform'
end
