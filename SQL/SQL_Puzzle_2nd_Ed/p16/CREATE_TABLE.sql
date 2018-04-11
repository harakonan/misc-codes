CREATE TABLE Personnel
(emp_id INTEGER NOT NULL PRIMARY KEY,
 emp_name CHAR(20) NOT NULL,
 mech_type CHAR(10) NOT NULL
    CHECK (mech_type IN ('Primary', 'Assistant')),
    UNIQUE (emp_id, mech_type));

CREATE TABLE Jobs
(job_id INTEGER NOT NULL PRIMARY KEY,
 start_date DATE NOT NULL);

CREATE TABLE Teams
(job_id INTEGER NOT NULL REFERENCES Jobs(job_id),
 primary_mech INTEGER NOT NULL,
 primary_type CHAR(10) DEFAULT 'Primary' NOT NULL
    CHECK (primary_type = 'Primary'),
 assist_mech INTEGER NOT NULL ,
 assist_type CHAR(10) DEFAULT 'Assistant' NOT NULL
    CHECK (assist_type = 'Assistant') ,
    CONSTRAINT fk_primary FOREIGN KEY (primary_mech, primary_type)
        REFERENCES Personnel(emp_id, mech_type),
    CONSTRAINT fk_assist FOREIGN KEY (assist_mech, assist_type)
        REFERENCES Personnel(emp_id, mech_type),
    CONSTRAINT at_least_one_mechanic
        CHECK(COALESCE (primary_mech, assist_mech) IS NOT NULL)) ;

INSERT INTO Personnel VALUES(1, '赤木',  'Primary');
INSERT INTO Personnel VALUES(2, '伊藤',  'Assistant');
INSERT INTO Personnel VALUES(3, '宇佐美','Primary');

INSERT INTO Jobs VALUES(1, '2007-01-01');
INSERT INTO Jobs VALUES(2, '2007-02-01');
INSERT INTO Jobs VALUES(3, '2007-03-01');
INSERT INTO Jobs VALUES(4, '2007-04-01');

INSERT INTO Teams VALUES(1, 1, 'Primary', 2, 'Assistant');
INSERT INTO Teams VALUES(2, 3, 'Primary', 2, 'Assistant');