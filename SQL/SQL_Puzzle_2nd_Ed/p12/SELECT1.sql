SELECT C1.claim_id, C1.patient_name, S1.claim_status
  FROM claims C1, ClaimStatusCodes S1
 WHERE S1.claim_seq IN
           (SELECT MIN(S2.claim_seq)
              FROM ClaimStatusCodes S2
             WHERE S2.claim_seq IN
                       (SELECT MAX(S3.claim_seq)
                          FROM LegalEvents E1,
                               ClaimStatusCodes S3
                         WHERE E1.claim_status = S3.claim_status
                           AND E1.claim_id = C1.claim_id
                         GROUP BY E1.defendant_name));