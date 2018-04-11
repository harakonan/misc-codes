CREATE TABLE Work
(order_nbr CHAR(10) NOT NULL,
 processed DATE,
 completed DATE,
 confirmed DATE);

INSERT INTO Work (order_nbr, processed, completed, confirmed)
SELECT order_nbr, sch_date, NULL, NULL
  FROM ServicesSchedule S1
 WHERE S1.sch_seq = 1
   AND S1.order_nbr = '4155526710'
   AND service_type = '01' 
UNION ALL
SELECT order_nbr, NULL, sch_date, NULL
  FROM ServicesSchedule S2
 WHERE S2.sch_seq = 2
   AND S2.order_nbr = '4155526710'
   AND service_type = '01' 
UNION ALL
SELECT order_nbr, NULL, NULL, sch_date
  FROM ServicesSchedule S3
 WHERE S3.sch_seq = 3
   AND S3.order_nbr = '4155526710'
   AND service_type = '01';

SELECT order_nbr, MAX(processed), MAX(completed), MAX(confirmed)
  FROM Work
 GROUP BY order_nbr;

 DROP TABLE Work;