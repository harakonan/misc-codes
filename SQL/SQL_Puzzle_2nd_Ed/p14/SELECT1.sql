SELECT H1.last_name, H1.first_name, home_phone, fax_phone
  FROM HomePhones H1, FaxPhones F1
 WHERE H1.emp_id = F1.emp_id;