program mysureg, properties(svyb svyj svyr)
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mysureg") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax anything(id="equations" equalok)	///
		[if] [in]			///
		[fweight pweight iweight] [,	///
		noLOg				/// -ml model- options
		noLRTEST			///
		vce(passthru)			///
		Level(cilevel)			/// -Replay- options
		corr				///
		*				/// -mlopts- options
	]

	// parse equations
	ParseEqns `anything'
	local p `s(p)'
	local k_eq   `s(k_eq)'
	local yvars  `s(yvars)'
	local xvars  `s(xvars)'
	local eqns   `s(eqns)'
	local eqns0  `s(eqns0)'
	local ceqns  `s(ceqns)'
	local myeqns `anything'
	local nocons 0
	forval i = 1/`p' {
		local xvars`i' `s(xvars`i')'
		local xvars`i'_cns `s(xvars`i'_cns)'
		if "`xvars`i'_cns'" != "" {
			local nocons 1
		}
	}

	// check syntax
	mlopts mlopts, `options'
	local cns `s(constraints)'
	if "`weight'" != "" {
		local wgt "[`weight'`exp']"
		// for initial value calculations
		local iwgt "[iw`exp']"
	}
	if "`log'" != "" {
		local qui quietly
	}

	// mark the estimation sample
	marksample touse
	markout `touse' `yvars' `xvars'
	markout `touse' `offset' `exposure'
	_vce_parse `touse', opt(Robust oim opg) argopt(CLuster): `wgt', `vce'

	// initial values
	tempname b0
	InitialValues `yvars' `iwgt' if `touse' , init(`b0')
	local initopt init(`b0', skip) search(quietly)

	`qui' di as txt _n "Fitting constant-only model:"
	ml model d2 mysuregc_d2 `eqns0'		///
		`iwgt' if `touse',		///
		`log' `mlopts' `initopt'	///
		nocnsnotes missing maximize
	if `nocons' {
		mat `b0' = e(b)
		local initopt init(`b0', skip) search(off)
	}
	else	local initopt continue search(off)
	if "`lrtest'" == "" & `nocons' == 0 {
		local lf0 lf0(`k_eq' `e(ll)')
	}

	// iterate to solution using concentrated likelihood
	`qui' di as txt _n "Fitting concentrated model:"
	ml model d2 mysuregc_d2 `ceqns'			///
		`iwgt' if `touse',			///
		`log' `mlopts'				///
		`initopt' 				///
		missing maximize
	UnConcentrate `yvars' `iwgt' if `touse', b(`b0')
	local initopt init(`b0', copy) search(quietly)

	// fit the full unconcentrated likelihood
	`qui' di as txt _n "Fitting full model:"
	ml model lf0 mysureg_lf0 `eqns'			///
		`wgt' if `touse',			///
		`log' `mlopts' `vce'			///
		`initopt' `lf0' missing maximize waldtest(-`k_eq')

	// build saved results
	tempname Sigma sd
	matrix `Sigma' = I(`p')
	matrix `sd'  = I(`p')
	matrix colnames `Sigma' = `yvars'
	matrix rownames `Sigma' = `yvars'
	forval i = `p'(-1)1 {
		mat `Sigma'[`i',`i'] = [sigma`i'_`i']_b[_cons]
		forval j = `=`i'+1'/`p' {
			mat `Sigma'[`i',`j'] = [sigma`i'_`j']_b[_cons]
			mat `Sigma'[`j',`i'] = `Sigma'[`i',`j']
		}
		ereturn local xvars`i' `xvars`i''
		ereturn local xvars`i'_cns `xvars`i'_cns'
	}
	ereturn local xvars `xvars'
	ereturn local mleqns `ceqns'
	ereturn local myeqns `myeqns'
	ereturn matrix Sigma = `Sigma'
	ereturn matrix Vars = `sd'
	ereturn scalar k_aux = `k_eq'-`p'
	// save a title for -Replay- and the name of this command
	ereturn local title "My sureg estimates"
	ereturn local cmd mysureg

	Replay , `diopts' `corr'
end

program Replay
	syntax [, Level(cilevel) notable corr ]
	if "`table'" == "" {
		ml display , level(`level')
	}
	if "`corr'" != "" {
		di
		di as txt "Correlation matrix of residuals:"
		tempname corr
		matrix `corr' = corr(e(Sigma))
		matrix list `corr', noheader format(%6.4g)
	}
end

// Syntax:
//     ParseEqns (y1 xvars1) (y2 xvars2) ...
//
// Build the -ml- equivalent equations, including the equations for the
// variance matrix.
//
// Saved results:
// 	s(p)		number of dependent variables
// 	s(k_eq)		number of -ml- equations : unconcentrated model
// 	s(yvars)	the dependent variables
// 	s(xvars)	the independent variables from all the equations
// 	s(xvars`i')	the independent variables from equation `i'
// 	s(xvars`i'_cns)	"noconstant" or ""
// 	s(eqns)		-ml- equations : unconcentrated model
// 	s(ceqns)	-ml- equations : concentrated model
// 	s(eqns0)	-ml- equations : constant-only concentrated model
program ParseEqns, sclass
	gettoken eq eqns : 0 , match(paren) parse("()") bind
	local p 0
	while "`eq'" != "" {
		local ++p
		local 0 `eq'
		syntax varlist [, noCONStant]
		gettoken yi xvarsi : varlist
		local xvars`p' `xvarsi'
		local xvars`p'_cns `constant'
		local meqns `meqns' (`yi' : `yi' = `xvarsi', `constant')
		local meqns0 `meqns0' (`yi' : `yi' = )
		local yvars `yvars' `yi'
		local xvars `xvars' `xvarsi'
		gettoken eq eqns : eqns , match(paren) parse("()") bind
	}
	forval i = 1/`p' {
		forval j = `i'/`p' {
			local seqns `seqns' /sigma`i'_`j'
		}
	}
	sreturn clear
	sreturn local p `p'
	sreturn local k_eq = `p'*(`p'+3)/2
	sreturn local yvars	`yvars'
	sreturn local xvars	`: list uniq xvars'
	sreturn local eqns	`meqns' `seqns'
	sreturn local ceqns	`meqns'
	sreturn local myeqns	`myeqns'
	sreturn local eqns0	`meqns0'
	forval i = 1/`p' {
		sreturn local xvars`i' `xvars`i''
		sreturn local xvars`i'_cns `xvars`i'_cns'
	}
end

// Take e(b) from the concentrated model and return the equivalent
// unconcentrated coefficents vector.
program UnConcentrate
	syntax varlist if [iw] , b(name)

	local wgt [`weight'`exp']

	local p : word count `varlist'
	tempname b0 s0 sv
	mat `b0' = e(b)
	forval i = 1/`p' {
		tempvar r`i'
		local y : word `i' of `varlist'
		matrix score `r`i'' = `b0' `if', eq(`y')
		quietly replace `r`i'' = `y' - `r`i''
		local resids `resids' `r`i''
	}
	quietly matrix accum `s0' = `resids' `wgt' `if', noconstant
	matrix `s0' = `s0'/r(N)
	forval i = 1/`p' {
		matrix `sv' = nullmat(`sv') , `s0'[`i',`i'...]
	}
	matrix `b' = e(b) , `sv'
end

// Compute the initial values for the concentrated constant-only model.
program InitialValues
	syntax varlist if [iw] , init(name)
	tempname m
	tempvar one
	quietly gen double `one' = 1
	quietly matrix vecaccum `m' = `one' `varlist'	///
		[`weight'`exp'] `if', noconstant
	matrix `init' = `m'/r(N)
	matrix colnames `init' = _cons
	matrix coleq    `init' = `varlist'
end
