CREATE VIEW Vprocs (id1, id2, total) AS
SELECT P1.proc_id, P2.proc_id, COUNT(*)
  FROM Procs P1, Procs P2, Procs P3
 WHERE P2.anest_name = P1.anest_name
   AND P3.anest_name = P1.anest_name
   AND P1.start_time <= P2.start_time
   AND P2.start_time < P1.end_time
   AND P3.start_time <= P2.start_time
   AND P2.start_time < P3.end_time
 GROUP BY P1.proc_id, P2.proc_id;