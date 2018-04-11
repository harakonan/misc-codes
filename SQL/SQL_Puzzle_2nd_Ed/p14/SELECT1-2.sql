SELECT COALESCE(H1.last_name, F1.last_name),
       COALESCE(H1.first_name, F1.first_name),
       home_phone, fax_phone
  FROM HomePhones H1 FULL OUTER JOIN FaxPhones F1
    ON H1.emp_id = F1.emp_id;