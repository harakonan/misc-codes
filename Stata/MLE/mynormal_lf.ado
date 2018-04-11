program mynormal_lf
	version 11
	args lnf mu lnsigma
	quietly replace `lnf' = ln(normalden($ML_y1,`mu',exp(`lnsigma')))
end
