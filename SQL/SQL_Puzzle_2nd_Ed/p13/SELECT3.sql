SELECT CASE WHEN teacher_name
              = (SELECT MIN(teacher_name)
                   FROM Register R1
                  WHERE R1.course_nbr = R0.course_nbr
                    AND R1.student_name = R0.student_name)
            THEN course_nbr
            ELSE NULL END course_nbr_hdr,
       CASE WHEN teacher_name
              = (SELECT MIN(teacher_name)
                   FROM Register R1
                  WHERE R1.course_nbr = R0.course_nbr
                    AND R1.student_name = R0.student_name)
            THEN student_name
            ELSE NULL END student_name_hdr,
       teacher_name
  FROM Register R0
 ORDER BY course_nbr, student_name, teacher_name;