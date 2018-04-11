SELECT S1.emp_name, S1.sal_date curr_date,
       S1.sal_amt curr_amt,
       CASE WHEN S2.sal_date <> S1.sal_date
            THEN S2.sal_date END prev_date,
       CASE WHEN S2.sal_date <> S1.sal_date
            THEN S2.sal_amt  END prev_amt
  FROM Salaries S1 INNER JOIN Salaries S2
    ON S2.emp_name = S1.emp_name
   AND S2.sal_date =
         COALESCE((SELECT MAX(S4.sal_date)
                     FROM Salaries S4
                    WHERE S4.emp_name = S1.emp_name
                      AND S4.sal_date < S1.sal_date),
                  S2.sal_date)
 WHERE NOT EXISTS(SELECT *
                    FROM Salaries S3
                   WHERE S3.emp_name = S1.emp_name
                     AND S3.sal_date > S1.sal_date);