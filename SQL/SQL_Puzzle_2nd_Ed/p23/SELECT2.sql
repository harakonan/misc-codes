CREATE VIEW MagazineSales
(stand_nbr, magazine_sku, avg_qty_sold)
 AS SELECT Sales.stand_nbr, Titles.magazine_sku,
           AVG(Sales.net_sold_qty)
      FROM Titles, Newsstands, Sales
     WHERE Titles.product_id = Sales.product_id
       AND Newsstands.stand_nbr = Sales.stand_nbr
       AND Titles.magazine_sku IN (1107, 2667, 48632)
     GROUP BY Sales.stand_nbr, Titles.magazine_sku;

SELECT DISTINCT N0.stand_name
  FROM MagazineSales M0, Newsstands N0
 WHERE N0.stand_nbr = M0.stand_nbr
   AND ((M0.magazine_sku = 1107 AND M0.avg_qty_sold > 5)
        OR (M0.magazine_sku = 2667 AND M0.avg_qty_sold > 2
            AND EXISTS (SELECT *
                          FROM MagazineSales Other
                         WHERE Other.magazine_sku = 48632
                           AND Other.stand_nbr = M0.stand_nbr
                           AND Other.avg_qty_sold > 2)));