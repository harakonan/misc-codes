SELECT stand_name
  FROM Newsstands N1
 WHERE 1 =
   ANY ((SELECT SIGN(AVG(net_sold_qty) - 2)
           FROM Sales S1
          WHERE product_id IN (SELECT product_id
                                 FROM Titles
                                WHERE magazine_sku = 2667)
                    AND S1.stand_nbr = N1.stand_nbr
         INTERSECT
         SELECT SIGN(AVG(net_sold_qty) - 2)
           FROM Sales S2
          WHERE product_id IN (SELECT product_id
                                 FROM Titles
                                WHERE magazine_sku = 48632)
            AND S2.stand_nbr = N1.stand_nbr)
         UNION
         SELECT SIGN(AVG(net_sold_qty) - 5)
           FROM Sales S3
          WHERE product_id IN (SELECT product_id
                                 FROM Titles
                                WHERE magazine_sku = 1107)
            AND S3.stand_nbr = N1.stand_nbr);