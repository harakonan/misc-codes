SELECT
    EMPLOYEE_NAME
,   HOURS
,   FIRST_VALUE(EMPLOYEE_NAME) OVER(
        ORDER BY
            HOURS
    )               LEAST_OVER_TIME
FROM
    OVERTIME
;
SELECT
    EMPLOYEE_NAME
,   DEPARTMENT
,   HOURS
,   FIRST_VALUE(EMPLOYEE_NAME) OVER(
        PARTITION BY
            DEPARTMENT
        ORDER BY
            HOURS
    )               LEAST_OVER_TIME
FROM
    OVERTIME
;
SELECT
    EMPLOYEE_NAME
,   DEPARTMENT
,   HOURS
FROM
    (
        SELECT
            *
        ,   RANK() OVER(
                PARTITION BY
                    DEPARTMENT
                ORDER BY
                    HOURS
            )       AS  RNK
        FROM
            OVERTIME
    )   AS  TEMP
WHERE
    RNK =   1
;
SELECT
    EMPLOYEE_NAME
,   DEPARTMENT
,   MAX(HOURS)
FROM
    (
        SELECT
            *
        ,   RANK() OVER(
                PARTITION BY
                    DEPARTMENT
                ORDER BY
                    HOURS
            )       AS  RNK
        FROM
            OVERTIME
    )   AS  TEMP
WHERE
    RNK =   1
GROUP BY
    EMPLOYEE_NAME
,   DEPARTMENT
;
