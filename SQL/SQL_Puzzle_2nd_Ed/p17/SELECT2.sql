SELECT DISTINCT J1.job_id, C1.candidate_id
  FROM JobOrders J1 INNER JOIN CandidateSkills C1
    ON J1.skill_code = C1.skill_code
 GROUP BY candidate_id, skill_group, job_id
HAVING COUNT(*) = (SELECT COUNT(*)
                      FROM JobOrders J2
                     WHERE J1.skill_group = J2.skill_group
                       AND J1.job_id = J2.job_id)
ORDER BY J1.job_id, C1.candidate_id;