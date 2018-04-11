SELECT emp_name, curr_date, curr_amt, prev_date, prev_amt
  FROM (SELECT emp_name, sal_date curr_date,
               sal_amt curr_amt,
               MIN(sal_date) OVER (PARTITION BY emp_name
                                   ORDER BY sal_date DESC
                                   ROWS BETWEEN 1 FOLLOWING
                                   AND 1 FOLLOWING) prev_date,
               MIN(sal_amt)  OVER (PARTITION BY emp_name
                                   ORDER BY sal_date DESC
                                   ROWS BETWEEN 1 FOLLOWING
                                   AND 1 FOLLOWING) prev_amt,
               ROW_NUMBER() OVER (PARTITION BY emp_name
                                  ORDER BY sal_date DESC) rn
          FROM Salaries) DT
  WHERE rn = 1;