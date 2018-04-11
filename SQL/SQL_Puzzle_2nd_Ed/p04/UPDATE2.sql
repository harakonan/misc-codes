UPDATE Badges
   SET badge_seq = (SELECT COUNT(*)
                      FROM Badges B1
                     WHERE Badges.emp_id = B1.emp_id
                       AND Badges.badge_seq >= B1.badge_seq);