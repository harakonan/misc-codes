SELECT DISTINCT C1.candidate_id, 'job_id #2'
  FROM CandidateSkills C1,
       CandidateSkills C2, 
       CandidateSkills C3,
       CandidateSkills C4
WHERE C1.candidate_id = C2.candidate_id
  AND C1.candidate_id = C3.candidate_id
  AND C1.candidate_id = C4.candidate_id
  AND
     (   (    C1.skill_code = '在庫管理'
          AND C2.skill_code = '製造')
      OR (    C3.skill_code = '会計'
          AND C4.skill_code = '製造'));