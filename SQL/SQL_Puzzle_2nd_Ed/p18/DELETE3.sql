DELETE FROM Consumers
 WHERE fam IS NULL      
   AND EXISTS (SELECT *
                 FROM Consumers C1
                WHERE C1.fam = Consumers.con_id);

SELECT * FROM Consumers;