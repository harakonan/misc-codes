program myrereghet_d0
	version 11
	args todo b lnf
	tempvar xb z T S_z2 Sz_2 a last s_e S_se2
	tempname s_u
	mleval `xb'  = `b', eq(1)
	mleval `s_u' = `b', eq(2) scalar
	mleval `s_e' = `b', eq(3)
	scalar `s_u' = exp(`s_u')
	// MY_panel contains the panel ID
	local by $MY_panel
	sort `by'
	local y $ML_y1
	quietly {
		replace `s_e' = exp(`s_e')
		by `by': gen double `S_se2' = sum(ln(2*c(pi)*`s_e'^2))
		gen double `z' = `y' - `xb'
		by `by': gen double `a' = 1 / ( 1/`s_u'^2 + sum(1/`s_e'^2) )
		by `by': gen `last' = _n==_N
		by `by': gen `T' = _N
		by `by': gen double `S_z2' = sum(`z'^2/`s_e'^2)
		by `by': gen double `Sz_2' = sum(`z'/`s_e'^2)^2
		mlsum `lnf'= -.5 *				///
			(					///
				(`S_z2'-`a'*`Sz_2') -		///
				ln(`a') +			///
				`S_se2' +			///
				2*ln(`s_u')			///
			)					///
			if `last' == 1
	}
end
