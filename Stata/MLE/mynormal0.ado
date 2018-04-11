program mynormal0
	version 11
	syntax varlist [if] [in] [, vce(passthru) ]
	gettoken y rhs : varlist
	ml model lf mynormal_lf (`y' = `rhs') () `if' `in', `vce'
	ml maximize
end
