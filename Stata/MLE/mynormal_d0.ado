program mynormal_d0
	version 11
	args todo b lnf
	tempvar mu lnsigma sigma
	mleval `mu' = `b', eq(1)
	mleval `lnsigma' = `b', eq(2)
	quietly {
		gen double `sigma' = exp(`lnsigma')
		mlsum `lnf' = ln( normalden($ML_y1,`mu',`sigma') )
	}
end
