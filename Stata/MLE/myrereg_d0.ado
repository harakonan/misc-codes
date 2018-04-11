program myrereg_d0
	version 11
	args todo b lnf
	tempvar xb z T S_z2 Sz_2 a last
	tempname s_u s_e
	mleval `xb'  = `b', eq(1)
	mleval `s_u' = `b', eq(2) scalar
	mleval `s_e' = `b', eq(3) scalar
	scalar `s_u' = exp(`s_u')
	scalar `s_e' = exp(`s_e')
	// MY_panel contains the panel ID
	local by $MY_panel
	sort `by'
	local y $ML_y1
	quietly {
		gen double `z' = `y' - `xb'
		by `by': gen `last' = _n==_N
		by `by': gen `T' = _N
		by `by': gen double `S_z2' = sum(`z'^2)
		by `by': gen double `Sz_2' = sum(`z')^2
		gen double `a' = `s_u'^2 / (`T'*`s_u'^2 + `s_e'^2)
		mlsum `lnf'= -.5 *				///
			(					///
				(`S_z2'-`a'*`Sz_2')/`s_e'^2 +	///
				ln(`T'*`s_u'^2/`s_e'^2 + 1) +	///
				`T'*ln(2*c(pi)*`s_e'^2)		///
			)					///
			if `last' == 1
	}
end
