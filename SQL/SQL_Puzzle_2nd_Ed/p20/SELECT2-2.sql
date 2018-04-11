SELECT test_name,
       COUNT(*) test_steps_needed ,
      (COUNT(*) - COUNT(comp_date)) test_steps_missing
  FROM TestResults
 GROUP BY test_name
HAVING COUNT(*) <> COUNT(comp_date);