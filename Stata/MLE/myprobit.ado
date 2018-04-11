program myprobit, properties(svyb svyj svyr swml)
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "myprobit") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist [if] [in]		///
		[fweight pweight iweight] [,	///
		noLOg noCONStant		/// -ml model- options
		noLRTEST			///
		vce(passthru)			///
		OFFset(varname numeric)		///
		EXPosure(varname numeric)	///
		Level(cilevel)			/// -Replay- options
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
		// initial value
		sum `lhs' `awgt' if `touse', mean
		local b0 = invnormal(r(mean))
		if "`weight'" == "iweight" {
			local n = r(sum_w)
		}
		else	local n = r(N)
		local initopt init(_cons=`b0') search(quietly)

		if "`lrtest'" == "" {
			local n1 = r(sum)
			local lf0 = `n1'*ln(normal(`b0'))	///
				+(`n'-`n1')*ln(normal(-`b0'))
			local initopt `initopt' lf0(1 `lf0')
		}
	}

	// fit the full model
	`qui' di as txt _n "Fitting full model:"
	ml model lf2 myprobit_lf2			///
		(xb: `lhs' = `rhs',			///
			`constant' `offopt' `expopt'	///
		)					///
		`wgt' if `touse',			///
		`log' `mlopts' `vce'			///
		`modopts' `initopt' missing maximize

	// save a title for -Replay- and the name of this command
	ereturn local title "My probit estimates"
	ereturn local cmd myprobit

	Replay , level(`level')
end

program Replay
	syntax [, Level(cilevel) ]
	ml display , level(`level')
end
