CREATE TABLE Foobar
(no_alpha VARCHAR(6) NOT NULL
          CHECK (UPPER(no_alpha) = LOWER(no_alpha)));