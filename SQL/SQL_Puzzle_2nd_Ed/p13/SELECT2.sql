SELECT course_nbr, student_name, MIN(teacher_name) teacher_1,
       CASE COUNT(*) WHEN 1 THEN NULL
                     WHEN 2 THEN MAX(teacher_name)
                     ELSE '--More--' END teacher_2
  FROM Register
 GROUP BY course_nbr, student_name;