SELECT workorder_id
  FROM Projects
 WHERE step_status = 'C'
 GROUP BY workorder_id
HAVING SUM(step_nbr) = 0;