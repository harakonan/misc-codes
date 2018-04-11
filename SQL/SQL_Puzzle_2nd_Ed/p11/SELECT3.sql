SELECT workorder_id
  FROM Projects
 GROUP BY workorder_id
HAVING COUNT(*)     
        = COUNT(CASE WHEN step_nbr = 0 AND step_status = 'C'
                     THEN 1
                     ELSE NULL END)  
        + COUNT(CASE WHEN step_nbr <> 0 AND step_status = 'W'
                     THEN 1
                     ELSE NULL END); 