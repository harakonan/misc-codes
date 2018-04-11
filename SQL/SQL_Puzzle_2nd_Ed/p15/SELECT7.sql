WITH salaryRanks(emp_name, sal_date, sal_amt, pos)
AS (SELECT emp_name, sal_date, sal_amt,
           RANK() OVER (PARTITION BY emp_name
                            ORDER BY sal_date DESC)
      FROM Salaries)
SELECT C.emp_name, C.sal_date curr_date,
       C.sal_amt curr_amt,
       P.sal_date prev_date, P.sal_amt prev_amt
  FROM SalaryRanks C LEFT OUTER JOIN SalaryRanks P
    ON P.emp_name = C.emp_name
   AND P.pos = 2 WHERE C.pos = 1;