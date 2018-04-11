program mycox1_d0
	version 11
	args todo b lnf
	local t "$ML_y1"		// $ML_y1 is t
	local d "$ML_y2"		// $ML_y2 is d
	tempvar xb B A sumd negt last L
	mleval `xb' = `b'
	quietly gen double `negt' = -`t'
	local by "`negt' `d'"
	local byby "by `by'"
	sort `by'
	quietly {
		gen double `B' = sum(exp(`xb'))
		`byby': gen double `A' = cond(_n==_N, sum(`xb'), .) if `d'==1
		`byby': gen `sumd' = cond(_n==_N, sum(`d'), .)
		`byby': gen byte `last' = (_n==_N & `d' == 1)
		gen double `L' = `A' - `sumd'*ln(`B') if `last'
		mlsum `lnf' = `L' if `last'
	}
end
