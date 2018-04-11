program myprobit_d0
	version 11
	args todo b lnf
	tempvar xb lj
	mleval `xb' = `b'
	quietly {
		gen double `lj'  = normal( `xb')  if $ML_y1 == 1
		replace    `lj'  = normal(-`xb')  if $ML_y1 == 0
		mlsum `lnf' = ln(`lj')
	}
end
