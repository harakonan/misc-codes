SELECT emp_id, badge_nbr
  FROM Badges  B1
 WHERE badge_seq = (SELECT MAX(badge_seq)
                      FROM Badges B2
                     WHERE B1.emp_id = B2.emp_id);