SELECT S1.emp_name, S1.sal_date, S1.sal_amt, S2.sal_date,
       S2.sal_amt
  FROM Salaries2 S1, salaries2 S2
 WHERE S1.emp_name = S2.emp_name
   AND S1.sal_date > S2.sal_date
UNION ALL
SELECT emp_name, MAX(sal_date), MAX(sal_amt), NULL, NULL
  FROM Salaries2
 GROUP BY emp_name
HAVING COUNT(*) = 1;