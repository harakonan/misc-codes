SELECT J1.job_id, C1.candidate_id
  FROM (SELECT job_id, skill_group, COUNT(*) grp_cnt
          FROM JobOrders
         GROUP BY job_id, skill_group) J1 CROSS JOIN
       (SELECT R1.job_id, R1.skill_group, S1.candidate_id,
               COUNT(*) candidate_cnt
          FROM JobOrders R1, CandidateSkills S1
         WHERE R1.skill_code = S1.skill_code
GROUP BY R1.job_id, R1.skill_group, S1.candidate_id) C1
 WHERE J1.job_id = C1.job_id
   AND J1.skill_group = C1.skill_group
   AND J1.grp_cnt = C1.candidate_cnt
 GROUP BY J1.job_id, C1.candidate_id
 ORDER BY J1.job_id, C1.candidate_id;