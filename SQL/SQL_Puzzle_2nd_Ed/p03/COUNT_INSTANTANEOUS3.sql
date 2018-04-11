SELECT id1 AS proc_id, MAX(total) AS max_inst_count
  FROM Vprocs
 GROUP BY id1
 ORDER BY proc_id;