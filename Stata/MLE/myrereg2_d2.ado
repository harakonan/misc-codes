program myrereg2_d2
	version 11
	args todo b lnf g H
	tempvar xb z T S_z2 Sz_2 a last
	tempname s_u s_e
	mleval `xb'  = `b', eq(1)
	mleval `s_u' = `b', eq(2) scalar
	mleval `s_e' = `b', eq(3) scalar
	scalar `s_u' = exp(`s_u')
	scalar `s_e' = exp(`s_e')
	// MY_panel contains the panel ID
	local by $MY_panel
	local y $ML_y1
	quietly {
		gen double `z' = `y' - `xb'
		by `by': gen `last' = _n==_N
		by `by': gen `T' = _N
		by `by': gen double `S_z2' = sum(`z'^2)
		by `by': replace    `S_z2' = `S_z2'[_N]
		by `by': gen double `Sz_2' = sum(`z')^2
		by `by': replace    `Sz_2' = `Sz_2'[_N]
		gen double `a' = `s_u'^2 / (`T'*`s_u'^2 + `s_e'^2)
		mlsum `lnf'= -.5 *				///
			(					///
				(`S_z2'-`a'*`Sz_2')/`s_e'^2 +	///
				ln(`T'*`s_u'^2/`s_e'^2 + 1) +	///
				`T'*ln(2*c(pi)*`s_e'^2)		///
			)					///
			if `last' == 1
		if (`todo'==0 | `lnf'>=.) exit

		// compute the gradient
		tempvar S_z
		tempname dxb du de
		by `by': gen double `S_z' = sum(`z')
		by `by': replace `S_z' = `S_z'[_N]
		mlvecsum `lnf' `dxb' = (`z'-`a'*`S_z')/`s_e'^2	, eq(1)
		mlvecsum `lnf' `du' = `a'^2*`Sz_2'/`s_u'^2	///
			-`T'*`a'				///
			if `last'==1				, eq(2)
		mlvecsum `lnf' `de' = `S_z2'/`s_e'^2 -		///
			`a'*`Sz_2'/`s_e'^2 -			///
			`a'^2*`Sz_2'/`s_u'^2 -			///
			`T'+1-`a'*`s_e'^2/`s_u'^2		///
			if `last'==1				, eq(3)
		mat `g' = (`dxb',`du',`de')
		if (`todo'==1 | `lnf'>=.) exit

		// compute the Hessian
		tempname d2xb1 d2xb2 d2xb d2u d2e dxbdu dxbde dude one
		mlmatsum `lnf' `d2u' = 2*`a'^2*`Sz_2'/`s_u'^2 -	///
			4*`s_e'^2*`a'^3*`Sz_2'/`s_u'^4 +	///
			2*`T'*`a'^2*`s_e'^2/`s_u'^2		///
			if `last'==1				, eq(2)
		mlmatsum `lnf' `d2e' =				///
			2*(`S_z2'-`a'*`Sz_2')/`s_e'^2 -		///
			2*`a'^2*`Sz_2'/`s_u'^2 -		///
			4*`a'^3*`Sz_2'*`s_e'^2/`s_u'^4 +	///
			2*`a'*`s_e'^2/`s_u'^2 -			///
			2*`a'^2*`s_e'^4/`s_u'^4			///
			if `last'==1				, eq(3)
		mlmatsum `lnf' `dude' =				///
			4*`a'^3*`Sz_2'*`s_e'^2/`s_u'^4 -	///
			2*`T'*`a'^2*`s_e'^2/`s_u'^2		///
			if `last'==1				, eq(2,3)
		mlmatsum `lnf' `dxbdu' = 2*`a'^2*`S_z'/`s_u'^2	, eq(1,2)
		mlmatsum `lnf' `dxbde' =			///
			2*(`z'-`a'*`S_z')/`s_e'^2 -		///
			2*`a'^2*`S_z'/`s_u'^2			, eq(1,3)
		// `a' is constant within panel; and
		// -mlmatbysum- treats missing as 0 for `a'
		by `by': replace `a' = . if !`last'
		mlmatsum `lnf' `d2xb2' = 1			, eq(1)
		gen double `one' = 1
		mlmatbysum `lnf' `d2xb1' `a' `one', by($MY_panel) eq(1)
		mat `d2xb' = (`d2xb2'-`d2xb1')/`s_e'^2
		mat `H' = -(					///
			`d2xb',   `dxbdu', `dxbde'	\	///
			`dxbdu'', `d2u',   `dude'	\	///
			`dxbde'', `dude',  `d2e'		///
		)
	}
end
