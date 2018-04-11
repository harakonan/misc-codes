SELECT P1.proc_id, P1.anest_name, MAX(E1.ecount) maxops
  FROM Procs P1,
       (SELECT P2.anest_name　anest_name, P2.start_time　etime, COUNT(*)　ecount
          FROM Procs P1, Procs P2
         WHERE P1.anest_name = P2.anest_name
           AND P1.start_time <= P2.start_time
           AND P1.end_time > P2.start_time
         GROUP BY P2.anest_name, P2.start_time)
         E1
 WHERE E1.anest_name = P1.anest_name
   AND E1.etime >= P1.start_time
   AND E1.etime <  P1.end_time
 GROUP BY P1.proc_id, P1.anest_name
 ORDER BY proc_id;