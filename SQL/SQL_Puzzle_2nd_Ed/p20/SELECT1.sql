SELECT DISTINCT test_name
  FROM TestResults T1
 WHERE NOT EXISTS (SELECT *
                     FROM TestResults T2
                    WHERE T1.test_name = T2.test_name
                      AND T2.comp_date IS NULL);