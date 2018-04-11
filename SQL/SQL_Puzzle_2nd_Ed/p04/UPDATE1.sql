UPDATE Badges
   SET badge_status = 'A'
 WHERE ('I' = ALL (SELECT badge_status
                     FROM Badges B1
                    WHERE Badges.emp_id = B1.emp_id))
   AND (issued_date = (SELECT MAX(issued_date)
                         FROM Badges B2
                        WHERE Badges.emp_id = B2.emp_id));