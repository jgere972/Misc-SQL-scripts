--1
SELECT s_last AS STUDENTNAME, f_last AS ADVISOR
FROM student, faculty
WHERE student.f_id = faculty.f_id;

--2
SELECT f_last AS LName,f_first AS Surname, COUNT(s_id)
FROM student JOIN faculty USING(f_id)
GROUP BY f_id;

--3
SELECT f_last AS LName, SUM(max_enrl)
FROM faculty, course_section
WHERE faculty.f_id = course_section.f_id
GROUP BY course_section.f_id;

--4A
SELECT course.course_id, course_name, max_enrl
FROM course_section JOIN course ON course_section.course_id = course.course_id;

--4B
SELECT course_id, course_name, max_enrl
FROM course_section JOIN course USING(course_id);

--5
SELECT course_id, course_name, SUM(max_enrl)
FROM course_section JOIN course USING(course_id)
GROUP BY course.course_id;

--6
SELECT course_id, course_name, SUM(max_enrl)
FROM course_section JOIN course USING(course_id)
GROUP BY course.course_id
HAVING SUM(max_enrl) > 200;

--7
SELECT location.loc_id, bldg_code AS CODE, room
FROM course_section JOIN location ON course_section.loc_id = location.loc_id
GROUP BY course_section.loc_id;

--8
SELECT course_name, term_desc AS tDescription, f_last AS Instructor, room
FROM course, term, faculty, location, course_section
WHERE course_section.course_id = course.course_id
AND course_section.term_id = term.term_id
AND course_section.f_id = faculty.f_id
AND course_section.loc_id = location.loc_id;

--9
INSERT INTO course_section
VALUES (14,5,3,2,5,'MWF',0000-00-00,'0 00:01:20.00',NULL,40);
--Explain: insert inputs additional records/data into the table selected
--Data must match the data type of the values/fields and must respect the
--range of "bit" to store. ex: char(5,0) mean 5 "bits" allowed/stored.

--10
SELECT Course.course_name AS COURSE, Prereq.course_name AS PREQ
FROM course Course, course Prereq
Where  Prereq.course_id = Course.preq;
WHERE Course.preq = Prereq.course_id;  -- Why did Prereq.preq = Course.course_id give the reverse?

--11
SELECT Faculty2.f_first AS Surname, Faculty2.f_last AS Name
FROM faculty Faculty1, faculty Faculty2
WHERE Faculty1.f_first = 'Kim'	
AND Faculty1.f_rank = Faculty2.f_rank
AND Faculty1.f_id <> Faculty2.f_id;

--12
SELECT S2.s_last AS STUDENTNAME
FROM student S1, student S2
WHERE S1.s_first = 'Sarah' AND S1.s_last = 'Miller'  --Last name is added in case another student is called Sarah
AND S1.f_id = S2.f_id
AND S1.s_id <> S2.s_id;
