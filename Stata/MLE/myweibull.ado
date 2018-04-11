program myweibull, properties(hr svyb svyj svyr swml)
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "myweibull") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in]		///
		[fweight pweight iweight] [,	///
		FAILure(varname numeric)	///
		noLOg noCONStant		/// -ml model- options
		noLRTEST			///
		vce(passthru)			///
		OFFset(varname numeric)		///
		EXPosure(varname numeric)	///
		Level(cilevel)			/// -Replay- options
		HR				///
		*				/// -mlopts- options
	]

	// check syntax
	mlopts mlopts, `options'
	local cns `s(constraints)'
	gettoken time rhs : varlist
	if "`failure'" == "" {
		tempvar failure
		gen byte `failure' = 1
	}
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
	markout `touse' `failure' `offset' `exposure'
	_vce_parse `touse', opt(Robust oim opg) argopt(CLuster): `wgt', `vce'

	if "`constant'" == "" {
		// initial value
		sum `time' `awgt' if `touse', mean
		local b0 = r(mean)
		sum `failure' `awgt' if `touse', mean
		local b0 = ln(`b0'/r(mean))
		local initopt init(_cons=`b0') search(quietly)

		`qui' di as txt _n "Fitting constant-only model:"
		ml model lf2 myweibull_lf2			///
			(lneta: `time' `failure' = ,		///
				`offopt' `expopt'		///
			)					///
			/lngamma				///
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
	ml model lf2 myweibull_lf2			///
		(lneta: `time' `failure'= `rhs',	///
			`constant' `offopt' `expopt'	///
		)					///
		/lngamma				///
		`wgt' if `touse',			///
		`log' `mlopts' `vce'			///
		`contin' missing maximize		///
		diparm(lngamma, exp label("gamma"))	///
		diparm(lngamma,				///
			function(exp(-@))		///
			derivative(exp(-@))		///
			label("1/gamma")		///
		)

	ereturn scalar k_aux = 1
	ereturn local failure `failure'
	ereturn local depvar `time' `failure'
	// save a title for -Replay- and the name of this command
	ereturn local title "My Weibull estimates"
	ereturn local cmd myweibull

	Replay , level(`level') `hr'
end

program Replay
	syntax [, Level(cilevel) HR ]
	ml display , level(`level') `hr'
end
