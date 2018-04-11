SELECT C1.claim_id, C1.patient_name,
       CASE MIN(S1.claim_seq) WHEN 2 THEN 'AP'
                              WHEN 3 THEN 'OR'
                              WHEN 4 THEN 'SF'
                              ELSE 'CL' END
  FROM ((Claims C1
          INNER JOIN
          Defendants D1
          ON C1.claim_id = D1.claim_id)
        CROSS JOIN
        ClaimStatusCodes S1)
       LEFT OUTER JOIN
       LegalEvents E1
       ON C1.claim_id  = E1.claim_id
          AND D1.defendant_name = E1.defendant_name
          AND S1.claim_status = E1.Claim_status
 WHERE E1.claim_id IS NULL
 GROUP BY C1.claim_id, C1.patient_name;