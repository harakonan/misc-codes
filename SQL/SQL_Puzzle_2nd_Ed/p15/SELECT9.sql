WITH CTE (emp_name, sal_date, sal_amt, rn)
AS (SELECT emp_name, sal_date, sal_amt ,
           ROW_NUMBER() OVER (PARTITION BY emp_name
                              ORDER BY sal_date DESC) rn                      
      FROM Salaries)
SELECT O.emp_name,
       O.sal_date curr_date, O.sal_amt curr_amt,
       I.sal_date prev_date, I.sal_amt prev_amt
  FROM CTE O LEFT OUTER JOIN CTE I
    ON O.emp_name = I.emp_name
   AND I.rn = 2
 WHERE O.rn = 1;