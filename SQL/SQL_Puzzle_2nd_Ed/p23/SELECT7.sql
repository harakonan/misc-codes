SELECT stand_nbr
  FROM (SELECT stand_nbr,
               AVG(CASE WHEN magazine_sku = 2667
                        THEN net_sold_qty END) avg_2667,
               AVG(CASE WHEN magazine_sku = 48632
                        THEN net_sold_qty END) avg_48632,
               AVG(CASE WHEN magazine_sku = 1107
                        THEN net_sold_qty END) avg_1107
          FROM Sales, Titles
         WHERE Sales.product_id = Titles.product_id
         GROUP BY stand_nbr
        )
 WHERE avg_1107 > 5 OR (avg_2667 > 2 AND avg_48632 > 2);