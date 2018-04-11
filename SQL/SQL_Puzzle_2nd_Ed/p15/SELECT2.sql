SELECT S0.emp_name, S0.sal_date, S0.sal_amt, S1.sal_date,
       S1.sal_amt
  FROM Salaries S0, Salaries S1
 WHERE S0.emp_name = S1.emp_name
   AND S0.sal_date =
            (SELECT MAX(S2.sal_date)
               FROM Salaries S2
              WHERE S0.emp_name = S2.emp_name)
   AND S1.sal_date =
            (SELECT MAX(S3.sal_date)
               FROM Salaries S3
              WHERE S0.emp_name = S3.emp_name
                AND S3.sal_date < S0.sal_date)
UNION ALL
SELECT S4.emp_name, MAX(S4.sal_date), MAX(S4.sal_amt),
       NULL, NULL
  FROM Salaries S4
 GROUP BY S4.emp_name
HAVING COUNT(*) = 1;