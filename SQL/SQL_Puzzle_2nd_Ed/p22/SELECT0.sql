SELECT *
  FROM Units U1 LEFT OUTER JOIN
         (Tenants T1 LEFT OUTER JOIN RentPayments RP1
            ON T1.tenant_id = RP1.tenant_id)
         ON U1.unit_nbr = T1.unit_nbr
 WHERE U1.complex_id = 32
   AND U1.unit_nbr = RP1.unit_nbr
   AND T1.vacated_date IS NULL
   AND ((RP1.payment_date >= '2007-01-01'
         AND RP1.payment_date < '2007-04-01')
        OR RP1.payment_date IS NULL)
 ORDER BY U1.unit_nbr, RP1.payment_date;