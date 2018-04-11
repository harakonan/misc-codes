SELECT B.emp_name, B.maxdate, Y.sal_amt, B.maxdate2, Z.sal_amt
  FROM (SELECT A.emp_name, A.maxdate, MAX(X.sal_date) maxdate2
          FROM (SELECT W.emp_name, MAX(W.sal_date) maxdate
                  FROM Salaries W
                 GROUP BY W.emp_name) A
            LEFT OUTER JOIN Salaries X
              ON A.emp_name = X.emp_name
             AND A.maxdate > X.sal_date
         GROUP BY A.emp_name, A.maxdate) B
     LEFT OUTER JOIN Salaries Y
         ON B.emp_name = Y.emp_name AND B.maxdate = Y.sal_date
     LEFT OUTER JOIN Salaries Z
         ON B.emp_name = Z.emp_name AND B.maxdate2 = Z.sal_date;