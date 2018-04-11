SELECT test_name
  FROM TestResults
 GROUP BY test_name
HAVING COUNT(*) = SUM(CASE WHEN comp_date IS NOT NULL 
                           THEN 1 
                           ELSE 0 END);