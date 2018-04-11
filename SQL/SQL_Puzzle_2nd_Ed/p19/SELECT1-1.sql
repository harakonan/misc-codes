SELECT S0.district_nbr, S0.sales_person,
       S0.sales_id, S0.sales_amt
  FROM SalesData S1, SalesData S0
 WHERE S0.district_nbr = S1.district_nbr
   AND S0.sales_amt <= S1.sales_amt
 GROUP BY S0.district_nbr, S0.sales_person, S0.sales_id,
          S0.sales_amt
HAVING COUNT(*) <= 3
ORDER BY S0.district_nbr, S0.sales_amt DESC, S0.sales_person, S0.sales_id;