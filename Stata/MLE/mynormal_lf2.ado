program mynormal_lf2
        version 11
        args todo b lnfj g1 g2 H
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
                if (`todo'==1) exit

                tempname d11 d12 d22
                mlmatsum `lnfj' `d11' = -1/`sigma'^2      , eq(1)
                mlmatsum `lnfj' `d12' = -2*`z'/`sigma'    , eq(1,2)
                mlmatsum `lnfj' `d22' = -2*`z'*`z'        , eq(2)
                matrix `H' = (`d11', `d12' \ `d12'', `d22')
        }
end
