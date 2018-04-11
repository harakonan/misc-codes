CREATE TABLE Personnel
 (emp_id INTEGER NOT NULL PRIMARY KEY);

 CREATE TABLE ExcuseList
 ( reason_code CHAR (40) NOT NULL PRIMARY KEY);

CREATE TABLE Absenteeism
(emp_id INTEGER NOT NULL 
		REFERENCES Personnel (emp_id)
		ON DELETE CASCADE,
 absent_date DATE NOT NULL,
 reason_code CHAR(40) NOT NULL
             REFERENCES ExcuseList (reason_code),
 severity_points INTEGER NOT NULL
             CHECK (severity_points BETWEEN 0 AND 4),
 PRIMARY KEY (emp_id, absent_date));

INSERT INTO Personnel VALUES(1);
INSERT INTO Personnel VALUES(2);

INSERT INTO ExcuseList VALUES('ずる');
INSERT INTO ExcuseList VALUES('病気');
INSERT INTO ExcuseList VALUES('ケガ');
INSERT INTO ExcuseList VALUES('サボリ');
INSERT INTO ExcuseList VALUES('long term illness');

INSERT INTO Absenteeism VALUES(1, '2007-05-01', 'ずる', 4);
INSERT INTO Absenteeism VALUES(1, '2007-05-02', '病気', 2);
INSERT INTO Absenteeism VALUES(1, '2007-05-03', '病気', 2);
INSERT INTO Absenteeism VALUES(1, '2007-05-05', 'ケガ', 1);
INSERT INTO Absenteeism VALUES(1, '2007-05-06', '病気', 3);
INSERT INTO Absenteeism VALUES(2, '2007-05-01', 'ずる', 4);
INSERT INTO Absenteeism VALUES(2, '2007-05-03', '病気', 2);
INSERT INTO Absenteeism VALUES(2, '2007-05-05', 'サボリ', 2);
INSERT INTO Absenteeism VALUES(2, '2007-05-06', 'サボリ', 2);