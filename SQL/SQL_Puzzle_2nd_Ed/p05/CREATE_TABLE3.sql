CREATE TABLE Foobar
(all_alpha VARCHAR(6) NOT NULL 
    CHECK (REGEXP_LIKE(all_alpha, '^[a-zA-Z]+$')));