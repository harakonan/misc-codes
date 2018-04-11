SELECT S1.emp_name,
       MAX(CASE WHEN rn = 1 THEN sal_date ELSE NULL END)
         curr_date,
       MAX(CASE WHEN rn = 1 THEN sal_amt ELSE NULL END)
         curr_amt,
       MAX(CASE WHEN rn = 2 THEN sal_date ELSE NULL END)
         prev_date,
       MAX(CASE WHEN rn = 2 THEN sal_amt ELSE NULL END)
         prev_amt
  FROM (SELECT emp_name, sal_date, sal_amt,
               RANK() OVER (PARTITION BY emp_name
                            ORDER BY sal_date DESC) rn
          FROM Salaries) S1
 WHERE rn < 3
 GROUP BY S1.emp_name;