program mycox, properties(hr swml)
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mycox") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv min=2) [if] [in]	///
		[fweight] [,			///
		FAILure(varname numeric)	///
		noLOg				/// -ml model- options
		noLRTEST			///
		vce(passthru)			///
		Level(cilevel)			/// -Replay- options
		HR				///
		*				/// -mlopts- options
	]

	// check syntax
	local diopts level(`level') `hr'
	mlopts mlopts , `options'
	local cns `s(constraints)'
	gettoken time rhs : varlist
	tempvar negt
	quietly gen double `negt' = -`time'
	sort `negt' `failure'
	if "`failure'" == "" {
		tempvar failure
		gen byte `failure' = 1
	}
	if "`weight'" != "" {
		local wgt "[`weight'`exp']"
	}
	if "`cns'" != "" {
		local lrtest nolrtest
	}

	// mark the estimation sample
	marksample touse
	markout `touse' `failure'
	_vce_parse, optlist(OIM) :, `vce'

	// fit constant-only model
	if "`lrtest'" == "" {
		quietly ml model d0 mycox2_d0			///
			(xb: `negt' `failure' = `rhs',		///
				noconstant			///
			)					///
			`wgt' if `touse',			///
			iterate(0)				///
			nocnsnotes missing maximize
		local initopt lf0(0 `e(ll)')
	}

	// fit the full model
	`qui' di as txt _n "Fitting full model:"
	ml model d0 mycox2_d0				///
		(xb: `negt' `failure' = `rhs',		///
			noconstant			///
		)					///
		`wgt' if `touse',			///
		`log' `mlopts' `vce' `initopt'		///
		missing maximize

	// dependent variables
	ereturn local depvar `time' `failure'
	// save a title for -Replay- and the name of this command
	ereturn local title "My cox estimates"
	ereturn local cmd mycox

	Replay , `diopts'
end

program Replay
	syntax [, Level(cilevel) HR ]
	ml display , level(`level') `hr'
end
