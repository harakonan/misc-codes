SELECT P1.last_name, P1.first_name,
       (SELECT T1.phone_nbr
          FROM Phones T1
         WHERE T1.emp_id = P1.emp_id
           AND T1.phone_type = 'hom') home_phone,
       (SELECT T2.phone_nbr
          FROM Phones T2
         WHERE T2.emp_id = P1.emp_id
           AND T2.phone_type = 'fax') fax_phone
  FROM Personnel P1;