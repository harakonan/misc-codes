SELECT DISTINCT S1.district_nbr, S1.sales_person
  FROM (SELECT district_nbr, sales_person,
               DENSE_RANK() OVER (PARTITION BY district_nbr
                                  ORDER BY sales_amt DESC) rank_nbr
          FROM SalesData) S1
 WHERE S1.rank_nbr <= 3
 ORDER BY S1.district_nbr, S1.sales_person;