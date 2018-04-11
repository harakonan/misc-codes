CREATE TABLE Foobar
(some_alpha VARCHAR(6) NOT NULL
          CHECK (UPPER(some_alpha) <> LOWER(some_alpha)));