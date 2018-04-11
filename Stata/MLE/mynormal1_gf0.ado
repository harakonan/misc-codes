program mynormal1_gf0

	args todo b lnfj

	tempvar xb
	quietly generate double `xb' = `b'[1,1]*length + 	         ///
				       `b'[1,2]*headroom + `b'[1,3]

	quietly replace `lnfj' = ln(normalden((turn - `xb')/`b'[1,4])) - ///
				 ln(`b'[1,4])
end
