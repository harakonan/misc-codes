SELECT DISTINCT N1.stand_name
  FROM Newsstands N1
 WHERE N1.stand_nbr IN (SELECT S1.stand_nbr
                          FROM Sales S1
                         WHERE S1.product_id IN
                           (SELECT T1.product_id
                              FROM Titles T1
                             WHERE magazine_sku = 1107)
                         GROUP BY S1.stand_nbr
                        HAVING AVG(S1.net_sold_qty) > 5)
    OR (N1.stand_nbr IN (SELECT S1.stand_nbr
                           FROM Sales S1
                          WHERE S1.product_id IN
                                (SELECT T1.product_id
                                   FROM Titles T1
                                  WHERE magazine_sku = 2667)
                          GROUP BY S1.stand_nbr
                         HAVING AVG(S1.net_sold_qty) > 2)
        AND N1.stand_nbr IN (SELECT S1.stand_nbr
                               FROM Sales S1
                              WHERE S1.product_id IN
                                (SELECT T1.product_id
                                   FROM Titles T1
                                  WHERE magazine_sku = 48632)
                              GROUP BY S1.stand_nbr
                             HAVING AVG(S1.net_sold_qty) > 2));