CREATE VIEW MagazineSales(stand_name, magazine_sku, net_sold_qty)
AS SELECT Newsstands.stand_name, Titles.magazine_sku,
          net_sold_qty
     FROM Titles, Sales, Newsstands
    WHERE Sales.stand_nbr   = Newsstands.stand_nbr
      AND Titles.product_id = Sales.product_id;

SELECT stand_name
  FROM MagazineSales M0
 GROUP BY stand_name
HAVING
     ((SELECT AVG(net_sold_qty)
         FROM MagazineSales M1
        WHERE M1.stand_name = M0.stand_name
          AND magazine_sku = 1107) > 5)
  OR ((SELECT AVG(net_sold_qty)
         FROM MagazineSales M2
        WHERE M2.stand_name = M0.stand_name
          AND magazine_sku IN (2667, 48632)) > 2)
 AND NOT
     ((SELECT AVG(net_sold_qty)
         FROM MagazineSales M3
        WHERE M3.stand_name = M0.stand_name
          AND magazine_sku = 2667) < 2
      OR
      (SELECT AVG(net_sold_qty)
         FROM MagazineSales M4
        WHERE M4.stand_name = M0.stand_name
          AND magazine_sku = 48632) < 2);