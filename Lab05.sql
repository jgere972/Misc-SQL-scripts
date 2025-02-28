--1
SELECT loc_id, COUNT(c_sec_id)
FROM course_section RIGHT OUTER JOIN location USING(loc_id)
GROUP BY loc_id
ORDER BY loc_id;

--2
INSERT INTO course_section
VALUES(14, 1, 4, 3, 2, 'MTW', '2023-01-01', '0 00:00:15:00', NULL, 50);

DELETE FROM course_section WHERE c_sec_id = 14;

SELECT f_last, bldg_code, room, c_sec_id
FROM course_section CS LEFT OUTER JOIN location LO ON CS.loc_id = LO.loc_id
INNER JOIN faculty USING(f_id)
GROUP BY CS.f_id;

--3
INSERT INTO course_section
VALUES(15, 3, 6, 1, NULL, 'MTWRF', '0000-00-00','0 00:01:30.00', 4, 45);

SELECT f_last, bldg_code, room, c_sec_id
FROM course_section CS LEFT OUTER JOIN faculty USING(f_id)
LEFT OUTER JOIN location LO ON CS.loc_id = LO.loc_id;

--4
SELECT c_sec_id AS SectionID , COUNT(enrollment.s_id) AS Student_Count
FROM enrollment RIGHT OUTER JOIN course_section USING(c_sec_id)
GROUP BY course_section.c_sec_id;

--5
SELECT term_desc As Term_Description, COUNT(c_sec_id) AS Sections
FROM term T, course_section CS
WHERE T.term_id = CS.term_id
GROUP BY CS.term_id;

SELECT term_desc As Term_Description, COUNT(c_sec_id) AS Sections
FROM term T LEFT OUTER JOIN course_section CS ON T.term_id = CS.term_id
GROUP BY T.term_id;

--6
SELECT term_desc As Term_Description, COUNT(c_sec_id) AS Sections
FROM course_section CS RIGHT OUTER JOIN term T ON T.term_id = CS.term_id
GROUP BY T.term_id;

--7
SELECT course_section.term_id, term_desc, SUM(max_enrl) AS Total_Max_Enrol
FROM term INNER JOIN course_section USING(term_id)
GROUP BY course_section.term_id;

--8
SELECT course_section.term_id, term_desc, SUM(max_enrl) AS Total_Max_Enrol
FROM term LEFT OUTER JOIN course_section USING(term_id)
GROUP BY term.term_id;

--9
SELECT course_section.term_id AS Term_id, term_desc AS Term_description, SUM(max_enrl) AS Total_Max_Enrol
FROM term LEFT OUTER JOIN course_section USING(term_id)
GROUP BY term.term_id
HAVING SUM(max_enrl) < 200 OR SUM(max_enrl) IS NULL;

--Sub-Queries

--10
SELECT f_last AS Faculty_Members
FROM faculty F, course_section CS
WHERE F.f_id = CS.f_id
AND CS.term_id = (SELECT term_id
FROM term
WHERE term_desc LIKE 'Summer 2007');

--11 
SELECT c_sec_day AS Section_Days, loc_id, bldg_code, room
FROM course_section INNER JOIN location USING(loc_id)
WHERE course_id = (SELECT course_id
FROM course
WHERE course_name LIKE 'Database Management')
AND course_section.term_id IN (SELECT term_id
FROM term
WHERE status LIKE 'OPEN');

--12
SELECT faculty.f_id AS Faculty_id
FROM faculty
WHERE f_id IN (SELECT CS.f_id
FROM course_section CS INNER JOIN enrollment EN USING(c_sec_id)
INNER JOIN student S ON EN.s_id = S.s_id
INNER JOIN faculty F ON CS.f_id = F.f_id
WHERE S.s_first = F.f_first
AND S.s_last = F.f_last);

--13
SELECT c_sec_id, max_enrl
FROM course_section
WHERE c_sec_id = (SELECT c_sec_id
FROM course_section
HAVING MAX(max_enrl));

--14
SELECT c_sec_id, max_enrl
FROM course_section
WHERE c_sec_id <> (SELECT c_sec_id
FROM course_section
HAVING MAX(max_enrl));

--15
SELECT c_sec_id
FROM course_section
WHERE max_enrl < (SELECT AVG(max_enrl)
FROM course_section);

--16
SELECT grade, term_id
FROM course_section INNER JOIN enrollment EN USING(c_sec_id)
INNER JOIN student S ON S.s_id = EN.s_id
WHERE S.s_id = (SELECT s_id
FROM student
WHERE s_first LIKE 'Sarah'
AND s_last LIKE 'Miller')
AND course_section.course_id = (SELECT course_id
FROM course
WHERE course_name LIKE 'Systems Analysis');

--17
SELECT DISTINCT C2.course_name, C2.course_id
FROM course C1, course C2
WHERE C2.course_id IN (SELECT course_id
FROM course
WHERE C2.course_id = C1.preq);

--18
SELECT term_desc
FROM term
WHERE term_id NOT IN (SELECT term_id
FROM course_section
GROUP BY term_id
HAVING COUNT(c_sec_id) <> 0);

--19 
SELECT term_desc
FROM term T LEFT OUTER JOIN course_section CS USING(term_id)
GROUP BY T.term_id
HAVING COUNT(c_sec_id) = 0;

--20
SELECT s_last, s_first, 'STUDENT' AS Comment
FROM student
UNION
SELECT f_last, f_first, 'FACULTY' AS Comment
FROM faculty;

