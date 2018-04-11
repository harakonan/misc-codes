program mylogit, properties(or svyb svyj svyr swml)
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mylogit") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in]		///
		[fweight pweight iweight] [,	///
		noLOg noCONStant		/// -ml model- options
		noLRTEST			///
		vce(passthru)			///
		OFFset(varname numeric)		///
		EXPosure(varname numeric)	///
		Level(cilevel)			/// -Replay- options
		OR				///
		*				/// -mlopts- options
	]

	// mark the estimation sample
	marksample touse

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

	// markout missing values from the estimation sample
	markout `touse' `offset' `exposure'
	_vce_parse `touse', opt(Robust oim opg) argopt(CLuster): `wgt', `vce'

	if "`constant'" == "" {
		// initial value
		sum `lhs' `awgt' if `touse', mean
		local b0 = logit(r(mean))
		if "`weight'" == "iweight" {
			local n = r(sum_w)
		}
		else	local n = r(N)
		local initopt init(_cons=`b0') search(quietly)

		if "`lrtest'" == "" {
			local n1 = r(sum)
			local lf0 = `n1'*ln(invlogit(`b0'))	///
				+(`n'-`n1')*ln(invlogit(-`b0'))
			local initopt `initopt' lf0(1 `lf0')
		}
	}

	// fit the full model
	`qui' di as txt _n "Fitting full model:"
	ml model lf2 mylogit_lf2			///
		(xb: `lhs' = `rhs',			///
			`constant' `offopt' `expopt'	///
		)					///
		`wgt' if `touse',			///
		`log' `mlopts' `vce'			///
		`modopts' `initopt'			///
		missing maximize

	// save a title for -Replay- and the name of this command
	ereturn local title "My logit estimates"
	ereturn local cmd mylogit

	Replay , level(`level') `or'
end

program Replay
	syntax [, Level(cilevel) OR ]
	ml display , level(`level') `or'
end
