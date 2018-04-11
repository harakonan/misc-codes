SELECT DISTINCT workorder_id
  FROM Projects P1
 WHERE NOT EXISTS
       (SELECT step_status
          FROM Projects P2
         WHERE P1.workorder_id = P2. workorder_id     
           AND step_status <> CASE WHEN step_nbr = 0   
                                      THEN 'C'
                                  ELSE 'W' END);