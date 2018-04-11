program mynormal7
	version 11
	if replay() {
		if (`"`e(cmd)'"' != "mynormal7") error 301
		Replay `0'
	}
	else	Estimate `0'
end

program Estimate, eclass sortpreserve
	syntax varlist(fv) [if] [in]		///
		[fweight pweight] [,		///
		noLOg				/// -ml model- options
		noCONStant			///
		vce(passthru)			///
		HETero(varlist fv)		///
		noLRTEST			///
		Level(cilevel)			/// -Replay- option
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
		if "`weight'" == "pweight" {	// <- NEW block
			local awgt "[aw`exp']"
		}
		else	local awgt "`wgt'"

	}
	if "`log'" != "" {
		local qui quietly
	}
	// mark the estimation sample
	marksample touse
	markout `touse' `hetero'
	_vce_parse `touse', opt(Robust oim opg)	argopt(CLuster): `wgt', `vce'

	if "`constant'" == "" {
		// initial values			-- NEW block
		quietly sum `lhs' `awgt' if `touse'
		local mean = r(mean)
		local lnsd = ln(r(sd))+ln((r(N)-1)/r(N))/2
		local initopt init(/mu=`mean' /lnsigma=`lnsd') search(off)

		`qui' di as txt _n "Fitting constant-only model:"
		ml model lf mynormal_lf				///
			(mu: `lhs' = )				///
			(lnsigma: `hetero')			///
			`wgt' if `touse',			///
			`log'					///
			`mlopts'				///
			`initopt'				/// <- NEW
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
		(mu: `lhs' = `rhs', `constant')		///
		(lnsigma: `hetero')			///
		`wgt' if `touse',			///
		`vce'					///
		`log'					///
		`mlopts'				///
		`contin'				///
		missing					///
		maximize

	ereturn local cmd mynormal7

	Replay , level(`level')
end

program Replay
	syntax [, Level(cilevel) ]
	ml display , level(`level')
end
