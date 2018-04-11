CREATE VIEW HomePhones
(last_name, first_name, emp_id, home_phone)
AS SELECT E1.last_name, E1.first_name, E1.emp_id, H1.phone_nbr
     FROM (Personnel E1 LEFT OUTER JOIN Phones H1
             ON E1.emp_id = H1.emp_id
            AND H1.phone_type = 'hom');

CREATE VIEW FaxPhones (last_name, first_name, emp_id, fax_phone)
AS SELECT E1.last_name, E1.first_name, E1.emp_id, F1.phone_nbr
     FROM (Personnel E1 LEFT OUTER JOIN Phones F1
              ON E1.emp_id = F1.emp_id
             AND F1.phone_type = 'fax');