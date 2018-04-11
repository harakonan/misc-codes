SELECT proc_id, MAX(instantaneous_count) max_inst
  FROM ConcurrentProcs
 GROUP BY proc_id
 ORDER BY proc_id;