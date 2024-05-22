# UNION

WITH `team` AS (
SELECT "IND" AS `team`
UNION ALL
SELECT "ENG"
UNION ALL
SELECT "NZ"
)

SELECT * from team AS A
CROSS JOIN team AS B;

SELECT * from team AS A
CROSS JOIN team AS B
WHERE A.team != B.team;

SELECT * from team AS A
CROSS JOIN team AS B
WHERE A.team = B.team;

SELECT * from team AS A
CROSS JOIN team AS B
WHERE A.team < B.team ;
