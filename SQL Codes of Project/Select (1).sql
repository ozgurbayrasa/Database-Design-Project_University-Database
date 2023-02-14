-- SINGLE TABLES

-- Student List
SELECT SId AS ID, FName AS Name, LName AS Surname, Addr AS Address
FROM student
ORDER BY Fname;

-- Faculty Members of Department
SELECT *
FROM faculty_member
WHERE DCode = 30;

-- All Keywords
SELECT DISTINCT Keyword
FROM keywords;


-- DOUBLE TABLES

-- Department With Types
SELECT DName, DOffice, DPhone, TName
FROM dept, dept_type
WHERE DTypeId = TId;

-- College and Departments
SELECT CName, CONCAT(DOffice, ' - ', COffice) AS Office, DCode, DName
FROM college, dept
WHERE CName = AdmCName;

-- Courses With Their Keywords
SELECT DISTINCT CoName, (
	SELECT GROUP_CONCAT(keyword SEPARATOR ', ')
	FROM keywords AS kw
	WHERE kw.CCode = k.CCode
) AS All_Keywords
FROM course AS c, keywords AS k
WHERE c.CCode = k.CCode;

-- Student numbers of each department.
SELECT Dname, COUNT(*) AS student_number
FROM student, dept
WHERE student.Dcode = dept.Dcode
GROUP BY dept.Dcode;

-- Faculty Members With Their Research Areas
SELECT FName, DCode, (
	SELECT GROUP_CONCAT(RArea SEPARATOR ", ")
    FROM research_areas AS res
    WHERE res.FId = ra.FId
) AS Research_Areas
FROM faculty_member AS fm, research_areas AS ra
WHERE fm.FId = ra.FId;


-- TRIPLE TABLES

-- Students With Their Notes
SELECT stu.SId, FName, LName, Grade, CoName
FROM student AS stu, takes AS t, section AS sec, course AS c
WHERE stu.SId = t.SId AND t.SecId = sec.SecId AND sec.SecCCode = c.CCode;

-- Colleges Deans and Chairs
SELECT c.CName, fd.FName AS Dean_Name, c.COffice, d.DName, f.FName AS Chair_Name
FROM college AS c, faculty_member AS f, dept AS d, faculty_member AS fd
WHERE c.CName = d.AdmCName AND d.ChairId = f.FId AND fd.FId = c.DeanId;

-- Curriculum With Their Courses
SELECT cu.CurId, cu.CLang, cu.EndDate, GROUP_CONCAT(CoName SEPARATOR ", ") AS Courses
FROM curriculum AS cu, include AS i, course AS co
WHERE cu.CurId = i.CurId AND i.CCode = co.CCode
GROUP BY cu.CurId;

