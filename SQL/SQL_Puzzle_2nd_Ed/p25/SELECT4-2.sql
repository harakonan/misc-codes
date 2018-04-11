SELECT order_nbr,
       MAX(CASE WHEN sch_seq = 1
                THEN sch_date
                ELSE NULL END) processed,
       MAX(CASE WHEN sch_seq = 2
                THEN sch_date
                ELSE NULL END) completed,
       MAX(CASE WHEN sch_seq = 3
                THEN sch_date
                ELSE NULL END) confirmed
  FROM ServicesSchedule
 WHERE service_type = '01'
   AND order_nbr = '4155526710'
 GROUP BY order_nbr, service_type;