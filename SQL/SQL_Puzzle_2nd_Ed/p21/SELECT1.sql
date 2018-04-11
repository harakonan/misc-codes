SELECT DISTINCT pilot
  FROM PilotSkills PS1
 WHERE NOT EXISTS
          (SELECT *
             FROM Hangar
            WHERE NOT EXISTS
                     (SELECT *
                        FROM PilotSkills PS2
                       WHERE (PS1.pilot = PS2.pilot)
                         AND (PS2.plane = Hangar.plane)));