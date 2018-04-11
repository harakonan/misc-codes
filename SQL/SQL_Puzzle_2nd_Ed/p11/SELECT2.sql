SELECT workorder_id
  FROM Projects
 GROUP BY workorder_id
HAVING SUM(CASE WHEN step_nbr <> 0 AND step_status = 'W' THEN 1
                WHEN step_nbr = 0  AND step_status = 'C' THEN 1
                ELSE 0 END) = COUNT(step_nbr);