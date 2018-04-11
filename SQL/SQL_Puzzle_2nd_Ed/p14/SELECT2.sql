SELECT E1.last_name, E1.first_name, H1.phone_nbr Home,
       F1.phone_nbr FAX
  FROM (Personnel E1 LEFT OUTER JOIN Phones H1
          ON E1.emp_id = H1.emp_id
         AND H1.phone_type = 'hom')
       LEFT OUTER JOIN Phones F1
            ON E1.emp_id = F1.emp_id
           AND F1.phone_type = 'fax';