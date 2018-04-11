* greene.do
* version 1.0.1 11jan2006
* This do-file creates Stata datasets from raw data files downloaded from
* 	http://www.prenhall.com/greene

clear all
set type double
infile i t c q pf lf using TableF7-1.txt in 2/l
label var i "airline"
label var t "year"
label var c "total cost"
label var q "output"
label var pf "fuel price"
label var lf "load factor"
gen double lnC = ln(c)
label var lnC "ln(c)"
gen double lnQ = ln(q)
label var lnQ "ln(q)"
gen double lnPF = ln(pf)
label var lnPF "ln(pf)"
save tablef7-1, replace

clear all
set type double
infile year firm i f c using TableF13-1.txt in 2/l
label define firm 1 "GM" 2 "CH" 3 "GE" 4 "WE" 5 "US"
label val firm firm
decode firm, gen(lfirm)
drop firm
reshape wide i f c, i(year) j(lfirm) string
save tablef13-1wide, replace

* finished greene.do
