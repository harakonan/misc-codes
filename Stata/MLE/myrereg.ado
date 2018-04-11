program myrereg
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "myrereg") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in] ,		///
		panel(varname)			///
	[					///
		noLOg noCONStant		/// -ml model- options
		noLRTEST			///
		vce(passthru)			///
		Level(cilevel)			/// -Replay- options
		*				/// -mlopts- options
	]

	// check syntax
	local diopts level(`level')
	mlopts mlopts , `options'
	local cns `s(constraints)'
	gettoken lhs rhs : varlist
	if "`cns'" != "" {
		local lrtest nolrtest
	}
	if "`log'" != "" {
		local qui quietly
	}

	// mark the estimation sample
	marksample touse
	markout `touse' `panel', strok
	_vce_parse, optlist(OIM) :, `vce'

	// capture block to ensure removal of global macro
capture noisily {

	// identify the panel variable for the evaluator
	global MY_panel `panel'
	sort `panel'

	if "`constant'" == "" {
		// initial values: variance components from one-way ANOVA
		sum `lhs' if `touse', mean
		local mean = r(mean)
		quietly oneway `lhs' `panel' if `touse'
		local np  = r(df_m) + 1
		local N   = r(N)
		local bms = r(mss)/r(df_m)	// between mean squares
		local wms = r(rss)/r(df_r)	// within mean squares
		local lns_u = log( (`bms'-`wms')*`np'/`N' )/2
		if missing(`lns_u') {
			local lns_u = 0
		}
		local lns_e = log(`wms')/2
		local	initopt search(off)		///
			init(/xb=`mean' /lns_u=`lns_u' /lns_e=`lns_e')

		`qui' di as txt _n "Fitting constant-only model:"
		ml model d2 myrereg2_d2				///
			(xb: `lhs' = , `offopt' `expopt' )	///
			/lns_u					///
			/lns_e					///
			if `touse',				///
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
	ml model d2 myrereg2_d2				///
		(xb: `lhs' = `rhs',			///
			`constant' `offopt' `expopt'	///
		)					///
		/lns_u					///
		/lns_e					///
		if `touse',				///
		`log' `mlopts' `contin'			///
		missing maximize

	// clear MY global
	global MY_panel

} // capture noisily

	// exit in case of error
	if c(rc) exit `c(rc)'

	ereturn scalar k_aux = 2
	// save the panel variable
	ereturn local panel `panel'
	// save a title for -Replay- and the name of this command
	ereturn local title "My rereg estimates"
	ereturn local cmd myrereg

	Replay , `diopts'
end

program Replay
	syntax [, Level(cilevel) ]
	ml display , level(`level')			///
		diparm(lns_u, exp label("sigma_u"))	///
		diparm(lns_e, exp label("sigma_e"))
end
