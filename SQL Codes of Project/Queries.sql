-- Faculty Members With Types
SELECT fm.FId, fm.FName, CASE
	WHEN t = 1 THEN "Research Assistant"
    WHEN t = 2 THEN "Instructor - Professor"
    WHEN t = 3 THEN "Instructor - Associate Professor"
    WHEN t = 4 THEN "Instructor - Assistant Professor"
END AS "Type", FOffice, FPhone
FROM (
(SELECT ResAsId AS FId, 1 as t FROM res_assistant)
UNION
(SELECT PId AS FId, 2 as t FROM prof)
UNION
(SELECT AssocPId AS FId, 3 as t FROM associate_prof)
UNION
(SELECT AssistPId AS FId, 4 as t FROM assistant_prof)
) AS u, faculty_member AS fm
WHERE u.FId = fm.FId
ORDER BY u.FId;

-- Number of courses and students for each year and semeseter.

SELECT *
FROM (SELECT year, sem, COUNT(SId) AS Student_Number
	  FROM Section, Takes
	  WHERE Section.SecId = Takes.SecId
	  GROUP BY year, sem
	  ORDER BY year DESC, sem) AS STable
NATURAL JOIN 
	  (SELECT year, sem, count(DISTINCT(SecCCode)) AS Course_Number
	   FROM Section 
	   GROUP BY year, sem
	   ORDER BY year DESC) AS CTable;



-- Instructors of Courses with Course Names

SELECT C.CoName AS CourseName, SecCCode AS CourseCode, group_concat(DISTINCT Fname SEPARATOR ", ") AS Instructors
FROM section AS S, faculty_member, Course AS C
WHERE S.SecInsId = faculty_member.Fid
AND C.Ccode = s.SecCCode
GROUP BY C.CCode;


-- Common Rarea and Keyword Number for Instructor ID 12 and Course 102

SELECT COUNT(RArea)
            FROM RESEARCH_AREAS
            WHERE FId = 12 AND Rarea IN (SELECT keyword 
									   FROM KEYWORDS 
                                       WHERE CCode = 102);



-- Courses With Types
SELECT c.CCode, c.CoName, c.Credits, CASE
	WHEN t = 1 THEN "Mandatory"
    WHEN t = 2 THEN "Technical Optional"
    WHEN t = 3 THEN "Non-Technical Optional"
END AS "Type"
FROM (
(SELECT ManCCode AS CCode, 1 as t FROM mandatory)
UNION
(SELECT TOptCcode AS CCode, 2 as t FROM tech_opt)
UNION
(SELECT NTOptCcode AS CCode, 3 as t FROM non_tech_opt)
) AS u, course AS c
WHERE u.CCode = c.CCode
ORDER BY u.CCode;


-- -- Studentin aldığı dersin bağlı olduğu üniversitedeki varlığını gösterir
-- SET @studentID = 1;
-- SET @SecID = 50;
-- SELECT EXISTS (
-- 	SELECT *
--     FROM (
-- 		SELECT c.DCode
-- 		FROM curriculum AS c
-- 		WHERE EXISTS (
-- 			SELECT i.CurId
-- 			FROM include AS i
-- 			WHERE (
-- 				SELECT SecCCode
-- 				FROM section AS sec
-- 				WHERE @SecID = sec.SecId
--             ) = i.CCode AND c.CurId = i.CurId
-- 		)
--     ) AS x
--     WHERE x.DCode = (
-- 		SELECT DCode
-- 		FROM student AS s
-- 		WHERE @studentId = s.SId
-- 		)
-- ) AS isValid;