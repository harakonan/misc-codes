CREATE VIEW ConcurrentProcs
(proc_id, event_time, instantaneous_count) AS
SELECT E1.proc_id, E1.event_time,
      (SELECT SUM(E2.event_type)
         FROM Events E2
        WHERE E2.proc_id = E1.proc_id
          AND E2.event_time < E1.event_time)
  FROM Events E1
 ORDER BY E1.proc_id, E1.event_time;