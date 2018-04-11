SELECT *
  FROM (Units U1 LEFT OUTER JOIN Tenants T1
         ON U1.unit_nbr = T1.unit_nbr
        AND T1.vacated_date IS NULL
        AND U1.complex_id = 32)
          LEFT OUTER JOIN RentPayments RP1
            ON (T1.tenant_id = RP1.tenant_id
           AND U1.unit_nbr = RP1.unit_nbr)
 WHERE RP1.payment_date BETWEEN '2007-01-01' AND '2007-04-01'
    OR RP1.payment_date IS NULL;