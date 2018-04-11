program mynormal, properties(svyb svyj svyr swml)
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mynormal") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist [if] [in]		///
		[fweight pweight iweight] [,	///
		noLOg noCONStant		/// -ml model- options
		HETero(varlist)			///
		noLRTEST			///
		vce(passthru)			///
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
	if "`offset'" != "" {
		local offopt "offset(`offset')"
	}
	if "`exposure'" != "" {
		local expopt "exposure(`exposure')"
	}

	// mark the estimation sample
	marksample touse
	markout `touse' `offset' `exposure'
	_vce_parse `touse', opt(Robust oim opg) argopt(CLuster): `wgt', `vce'

	if "`constant'" == "" {
		// initial values
		quietly sum `lhs' `awgt' if `touse'
		local mean = r(mean)
		local lnsd = ln(r(sd))+ln((r(N)-1)/r(N))/2
		local initopt init(/mu=`mean' /lnsigma=`lnsd') search(off)

		`qui' di as txt _n "Fitting constant-only model:"
		ml model lf2 mynormal_lf2			///
			(mu: `lhs' =, `offopt' `expopt' )	///
			(lnsigma: `hetero')			///
			`wgt' if `touse',			///
			`log' `mlopts' `initopt'		///
			nocnsnotes missing maximize
		if "`lrtest'" == "" {
			local contin continue search(off)
		}
		else {
			tempname b0
			mat `b0' = e(b)
			local contin init(`b0') search(off)
		}
	}

	// fit the full model
	`qui' di as txt _n "Fitting full model:"
	ml model lf2 mynormal_lf2			///
		(mu: `lhs' = `rhs',			///
			`constant' `offopt' `expopt'	///
		)					///
		(lnsigma: `hetero')			///
		`wgt' if `touse',			///
		`log' `mlopts' `vce'			///
		`contin' missing maximize

	if "`hetero'" == "" {
		ereturn scalar k_aux = 1
	}
	else	ereturn scalar k_aux = 0
	// save a title for -Replay- and the name of this command
	ereturn local title "My normal estimates"
	ereturn local predict mynormal_p
	ereturn local cmd mynormal

	Replay , level(`level') `eform'
end

program Replay
	syntax [, Level(cilevel) EForm ]
	if `e(k_aux)' {
		local sigma diparm(lnsigma, exp label("sigma"))
	}
	ml display , level(`level') `sigma' `eform'
end
