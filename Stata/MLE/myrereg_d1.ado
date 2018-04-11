program myrereg_d1
	version 11
	args todo b lnf g
	tempvar xb z T S_z2 Sz_2 a last
	tempname s_u s_e
	mleval `xb'  = `b', eq(1)
	mleval `s_u' = `b', eq(2) scalar
	mleval `s_e' = `b', eq(3) scalar
	scalar `s_u' = exp(`s_u')
	scalar `s_e' = exp(`s_e')
	// MY_panel contains the panel id
	local by $MY_panel
	sort `by'
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
	}
end
