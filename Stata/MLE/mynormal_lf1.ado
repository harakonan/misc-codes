program mynormal_lf1
        version 11
        args todo b lnfj g1 g2
        tempvar mu lnsigma sigma
        mleval `mu' = `b', eq(1)
        mleval `lnsigma' = `b', eq(2)
        quietly {
                gen double `sigma' = exp(`lnsigma')
                replace `lnfj' = ln( normalden($ML_y1,`mu',`sigma') )
                if (`todo'==0) exit

                tempvar z
                gen double `z' = ($ML_y1-`mu')/`sigma'
                replace `g1' = `z'/`sigma'
                replace `g2' = `z'*`z'-1
        }
end
