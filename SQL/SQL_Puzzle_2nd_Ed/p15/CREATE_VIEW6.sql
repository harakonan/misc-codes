CREATE VIEW SalaryHistory
(emp_name, curr_date, curr_amt, prev_date, prev_amt)
AS SELECT S0.emp_name,
          S0.sal_date curr_date,
          S0.sal_amt curr_amt,
          S1.sal_date prev_date,
          S1.sal_amt prev_amt
     FROM Salaries S0
          LEFT OUTER JOIN Salaries S1
            ON S0.emp_name = S1.emp_name
           AND S0.sal_date > S1.sal_date;

SELECT * FROM SalaryHistory;