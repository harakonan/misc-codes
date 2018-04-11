SELECT test_name
  FROM TestResults
 GROUP BY test_name
HAVING COUNT(*) = COUNT(comp_date);