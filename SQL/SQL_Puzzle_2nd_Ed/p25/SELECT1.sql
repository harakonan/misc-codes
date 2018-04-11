SELECT DISTINCT S1.order_nbr, S1.sch_date,  S2.sch_date,
                S3.sch_date
  FROM ServicesSchedule S1, ServicesSchedule S2,
       ServicesSchedule S3
 WHERE S1.service_type = '01'
   AND S1.order_nbr = '4155526710' 
   AND S1.sch_seq = 1
   AND S2.order_nbr = S1.order_nbr
   AND S2.sch_seq = 2
   AND S3.order_nbr = S1.order_nbr
   AND S3.sch_seq = 3;