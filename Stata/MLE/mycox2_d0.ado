program mycox2_d0
	version 11
	args todo b lnf
	local negt "$ML_y1"		// $ML_y1 is -t
	local d "$ML_y2"		// $ML_y2 is d
	tempvar xb B A sumd last L
	mleval `xb' = `b'
	// data assumed already sorted by `negt' and `d'
	local byby "by `negt' `d'"
	local wxb "$ML_w*`xb'"
	quietly {
		gen double `B' = sum($ML_w*exp(`xb'))
		`byby': gen double `A' = cond(_n==_N, sum(`wxb'), .) if `d'==1
		`byby': gen `sumd' = cond(_n==_N, sum($ML_w*`d'), .)
		`byby': gen byte `last' = (_n==_N & `d' == 1)
		gen double `L' = `A' - `sumd'*ln(`B') if `last'
		mlsum `lnf' = `L' if `last', noweight
	}
end
