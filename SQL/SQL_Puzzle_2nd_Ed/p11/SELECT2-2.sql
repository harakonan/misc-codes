SELECT workorder_id
  FROM Projects P1
 GROUP BY workorder_id
HAVING SUM(SIGN(step_nbr) * INSTR(step_status, 'W') 
	+ (1 - SIGN(step_nbr)) * INSTR(step_status, 'C'))
       = COUNT(step_nbr);