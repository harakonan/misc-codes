UPDATE Absenteeism A1
   SET severity_points = 0,
       reason_code = 'long term illness'
 WHERE EXISTS
   (SELECT *
      FROM Absenteeism A2
     WHERE A1.emp_id = A2.emp_id
       AND (A2.absent_date + INTERVAL '1' DAY) = A1.absent_date);