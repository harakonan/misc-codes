CREATE TABLE Personnel
(emp_id INTEGER PRIMARY KEY,
 first_name CHAR(20) NOT NULL,
 last_name CHAR(20) NOT NULL);

CREATE TABLE Phones
(emp_id INTEGER NOT NULL,
 phone_type CHAR(3) NOT NULL
    CHECK (phone_type IN ('hom', 'fax')),
 phone_nbr CHAR(12) NOT NULL,
    PRIMARY KEY (emp_id, phone_type),
    FOREIGN KEY (emp_id) REFERENCES Personnel(emp_id));

INSERT INTO Personnel VALUES(1, '山田', '太郎');
INSERT INTO Personnel VALUES(2, '上野', '二郎');
INSERT INTO Personnel VALUES(3, '高田', '三郎');
INSERT INTO Personnel VALUES(4, '松岡', '四郎');

INSERT INTO Phones VALUES(1, 'hom', 1111);
INSERT INTO Phones VALUES(1, 'fax', 2222);
INSERT INTO Phones VALUES(2, 'hom', 3333);
INSERT INTO Phones VALUES(3, 'fax', 4444);