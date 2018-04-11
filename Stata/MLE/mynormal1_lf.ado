program mynormal1_lf
	version 11
	args lnfj mu sigma
	quietly replace `lnfj' = ln(normalden($ML_y1,`mu',`sigma'))
end
