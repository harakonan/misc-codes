program mynonlin_lf
	version 11
	args lnfj theta1 theta2 theta3 sigma
	quietly replace `lnfj' = ///
	        ln(normalden($ML_y1,`theta1'+`theta2'*X3^`theta3',`sigma'))
end
