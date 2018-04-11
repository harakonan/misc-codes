program myweibull_bad_lf1
        version 11
        args todo b lnf g1 g2
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
                replace `g2' = `d' + `R'*`p'*(`M'-`d')
        }
end
