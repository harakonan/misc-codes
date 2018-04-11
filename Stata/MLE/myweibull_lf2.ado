program myweibull_lf2
        version 11
        args todo b lnf g1 g2 H
        tempvar leta lgam p M R
        mleval `leta' = `b', eq(1)
        mleval `lgam' = `b', eq(2)
        local t "$ML_y1"
        local d "$ML_y2"
        quietly {
                gen double `p' = exp(`lgam')
                gen double `M' = (`t'*exp(-`leta'))^`p'
                gen double `R' = ln(`t')-`leta'
                replace `lnf' = -`M' + `d'*(`lgam'-`leta' + (`p'-1)*`R')
                if (`todo'==0) exit

                replace `g1' = `p'*(`M'-`d')
                replace `g2' = `d' - `R'*`p'*(`M'-`d')
                if (`todo'==1) exit

                tempname d11 d12 d22
                mlmatsum `lnf' `d11' = -`p'^2 * `M'                   , eq(1)
                mlmatsum `lnf' `d12' = `p'*(`M'-`d'+`R'*`p'*`M')    , eq(1,2)
                mlmatsum `lnf' `d22' = -`p'*`R'*(`R'*`p'*`M'+`M'-`d') , eq(2)
                matrix `H' = (`d11',`d12' \ `d12'',`d22')
        }
end
