program myprobit_lf1
        version 11
        args todo b lnfj g1
        tempvar xb lj
        mleval `xb' = `b'
        quietly {
        	// Create temporary variable used in both likelihood
        	// and scores
                gen double `lj'  = normal( `xb')  if $ML_y1 == 1
                replace    `lj'  = normal(-`xb')  if $ML_y1 == 0
                replace    `lnfj' = log(`lj')
                if (`todo'==0) exit

                replace `g1' =  normalden(`xb')/`lj'  if $ML_y1 == 1
                replace `g1' = -normalden(`xb')/`lj'  if $ML_y1 == 0
        }
end
