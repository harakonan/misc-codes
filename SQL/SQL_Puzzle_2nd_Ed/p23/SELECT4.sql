SELECT N1.stand_name
  FROM Sales S1, Titles T1, Newsstands N1
 WHERE T1.magazine_sku IN (2667, 48632, 1107)
   AND S1.product_id = T1.product_id
   AND S1.stand_nbr = N1.stand_nbr
 GROUP BY N1.stand_name
HAVING (AVG(CASE WHEN T1.magazine_sku = 2667
                 THEN S1.net_sold_qty ELSE NULL END) > 2
        AND AVG(CASE WHEN T1.magazine_sku  = 48632
                     THEN S1.net_sold_qty ELSE NULL END) > 2)
    OR AVG(CASE WHEN T1.magazine_sku  = 1107
                THEN S1.net_sold_qty ELSE NULL END) > 5;