SELECT S0.emp_name,S0.curr_date, S0.curr_amt,
       S0.prev_date, S0.prev_amt
  FROM SalaryHistory S0
 WHERE S0.curr_date
          = (SELECT MAX(curr_date)
               FROM SalaryHistory S1
              WHERE S0.emp_name = S1.emp_name)
   AND (S0.prev_date = (SELECT MAX(prev_date)
                          FROM SalaryHistory S2
                         WHERE S0.emp_name = S2.emp_name)
                            OR S0.prev_date IS NULL);