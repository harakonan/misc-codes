CREATE TABLE TestResults
(test_name CHAR(20) NOT NULL,
 test_step INTEGER NOT NULL,
 comp_date DATE,
    PRIMARY KEY (test_name, test_step));

INSERT INTO TestResults VALUES('読解', 1, '2006-03-10');
INSERT INTO TestResults VALUES('読解', 2, '2006-03-12');
INSERT INTO TestResults VALUES('数学', 1, NULL);
INSERT INTO TestResults VALUES('数学', 2, '2006-03-12');
INSERT INTO TestResults VALUES('化学', 1, '2006-03-08');
INSERT INTO TestResults VALUES('化学', 2, '2006-03-12');
INSERT INTO TestResults VALUES('化学', 3, '2006-03-15');