SELECT E1.emp_id, E1.first_name, E1.last_name,
       MAX(CASE WHEN P1.phone_type = 'hom'
                THEN P1.phone_nbr
           ELSE NULL END) home_phone,
       MAX(CASE WHEN P1.phone_type = 'fax'
                THEN P1.phone_nbr
           ELSE NULL END) fax_phone
  FROM Personnel E1 LEFT OUTER JOIN Phones P1
    ON P1.emp_id = E1.emp_id
 GROUP BY E1.emp_id, E1.first_name, E1.last_name;