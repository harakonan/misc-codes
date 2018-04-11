SELECT DISTINCT S0.order_nbr,
      (SELECT sch_date
         FROM ServicesSchedule S1
        WHERE S1.sch_seq = 1
          AND S1.order_nbr = S0.order_nbr) processed,
      (SELECT sch_date
         FROM ServicesSchedule S2
        WHERE S2.sch_seq = 2
          AND S2.order_nbr = S0.order_nbr) completed,
      (SELECT sch_date
         FROM ServicesSchedule S3
        WHERE S3.sch_seq =3
          AND S3.order_nbr = S0.order_nbr) confirmed
  FROM ServicesSchedule S0
 WHERE service_type = '01' ;