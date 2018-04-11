CREATE VIEW Salaries2 (emp_name, sal_date, sal_amt)
AS SELECT S0.emp_name, S0.sal_date, MAX(S0.sal_amt)
     FROM Salaries S0, Salaries S1
    WHERE S0.sal_date <= S1.sal_date
      AND S0.emp_name = S1.emp_name
    GROUP BY S0.emp_name, S0.sal_date
   HAVING COUNT(*) <= 2;

SELECT * FROM Salaries2;