program mynormal2_lf
	version 11
	args lnfj mu lnsigma
	quietly replace `lnfj' = ln(normalden($ML_y1,`mu',exp(`lnsigma')))
end
