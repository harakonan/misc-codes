SELECT R1.course_nbr, R1.student_name, MIN(R1.teacher_name) teacher_1, NULL teacher_2
  FROM Register R1
 GROUP BY R1.course_nbr, R1.student_name
HAVING COUNT(*) = 1
UNION
SELECT R1.course_nbr, R1.student_name,
       MIN(R1.teacher_name), MAX(R1.teacher_name)
  FROM Register R1
 GROUP BY R1.course_nbr, R1.student_name
HAVING COUNT(*) = 2
UNION
SELECT R1.course_nbr, R1.student_name,
       MIN(R1.teacher_name), '--More--'
  FROM Register R1
 GROUP BY R1.course_nbr, R1.student_name
HAVING COUNT(*) > 2;