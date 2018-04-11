SELECT PS1.pilot
  FROM PilotSkills PS1 LEFT OUTER JOIN Hangar H1
    ON PS1.plane = H1.plane
 GROUP BY PS1.pilot
HAVING COUNT(PS1.plane) = (SELECT COUNT(plane) FROM Hangar)
   AND COUNT(H1.plane)  = (SELECT COUNT(plane) FROM Hangar);