CREATE TABLE CandidateSkills
(candidate_id INTEGER NOT NULL,
 skill_code CHAR(15) NOT NULL,
    PRIMARY KEY (candidate_id, skill_code));

CREATE TABLE JobOrders
(job_id INTEGER NOT NULL,
 skill_group INTEGER NOT NULL,
 skill_code CHAR(15) NOT NULL,
    PRIMARY KEY (job_id, skill_group, skill_code));

INSERT INTO CandidateSkills VALUES(100, '会計');
INSERT INTO CandidateSkills VALUES(100, '在庫管理');
INSERT INTO CandidateSkills VALUES(100, '製造'); 
INSERT INTO CandidateSkills VALUES(200, '会計');
INSERT INTO CandidateSkills VALUES(200, '在庫管理');
INSERT INTO CandidateSkills VALUES(300, '製造');
INSERT INTO CandidateSkills VALUES(400, '在庫管理');
INSERT INTO CandidateSkills VALUES(400, '製造'); 
INSERT INTO CandidateSkills VALUES(500, '会計'); 
INSERT INTO CandidateSkills VALUES(500, '製造');

INSERT INTO JobOrders VALUES(1, 1, '在庫管理');
INSERT INTO JobOrders VALUES(1, 1, '製造'); 
INSERT INTO JobOrders VALUES(1, 2, '会計');
INSERT INTO JobOrders VALUES(2, 1, '在庫管理');
INSERT INTO JobOrders VALUES(2, 1, '製造'); 
INSERT INTO JobOrders VALUES(2, 2, '会計'); 
INSERT INTO JobOrders VALUES(2, 2, '製造'); 
INSERT INTO JobOrders VALUES(3, 1, '製造');
INSERT INTO JobOrders VALUES(4, 1, '在庫管理');
INSERT INTO JobOrders VALUES(4, 1, '製造'); 
INSERT INTO JobOrders VALUES(4, 1, '会計');