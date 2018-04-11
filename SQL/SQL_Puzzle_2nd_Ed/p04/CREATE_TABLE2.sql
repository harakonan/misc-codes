CREATE TABLE Badges
(badge_nbr INTEGER NOT NULL PRIMARY KEY, 
 emp_id INTEGER NOT NULL, 
 issued_date DATE NOT NULL, 
 badge_seq INTEGER NOT NULL CHECK (badge_seq > 0), 
    UNIQUE (emp_id, badge_seq));

INSERT INTO Badges VALUES(100, 1, '2007-01-01', 1);
INSERT INTO Badges VALUES(200, 1, '2007-02-01', 2);
INSERT INTO Badges VALUES(10,  2, '2007-03-01', 1);
INSERT INTO Badges VALUES(2000,3, '2007-03-01', 1);  
INSERT INTO Badges VALUES(3,   3, '2007-04-01', 2);  
INSERT INTO Badges VALUES(50,  3, '2007-05-01', 3);