--1
SELECT f_first, f_last
FROM faculty
WHERE  f_rank = 'FULL' OR f_rank = 'INST';

--2
SELECT f_first, f_last
FROM faculty
WHERE f_rank in('FULL','INST');

--3
SELECT DISTINCT s_class
FROM student;

--4
SELECT s_first, s_last, s_dob
FROM student
WHERE s_dob >= '1985-01-01' AND s_dob <= '1985-12-31';

--5
SELECT s_first, s_last, s_dob
FROM student
WHERE s_dob BETWEEN '1985-01-01' AND '1985-12-31';

--6
SELECT *
FROM student
WHERE s_mi IS NOT NULL;

--7
SELECT *
FROM enrollment
WHERE grade IS NULL;

--8
SELECT DISTINCT f_id
FROM student
WHERE f_id;

--9 (Advisors with Ids less than 5 are all advisors)
SELECT DISTINCT f_id
FROM student
WHERE f_id < 5;

--10
SELECT DISTINCT loc_id
FROM location
WHERE loc_id >= 9;

--11
SELECT DISTINCT loc_id
FROM course_section
WHERE (loc_id >= 1 AND loc_id <= 3) OR (loc_id >= 5 AND loc_id <= 7);

--12
SELECT c_sec_id
FROM course_section
where c_sec_day NOT LIKE '%W%';

--13
SELECT c_sec_id
FROM course_section
where c_sec_day NOT LIKE '%W%' OR '%F%';

--14
SELECT AVG(max_enrl)
FROM course_section
WHERE course_id = '1' AND term_id = '4';

--15
SELECT COUNT('B')
FROM enrollment
WHERE c_sec_id = '6';

--16
SELECT *
FROM enrollment
WHERE grade LIKE 'C' OR grade IS NULL;

--17 (Unable to find the other way without the grouping, may need feedback)
SELECT f_id, COUNT(s_id)
FROM student;

--17 2nd way
SELECT f_id, COUNT(s_id)
FROM student
GROUP BY f_id;
--18
SELECT COUNT(c_sec_id)
FROM course_section
GROUP By loc_id
ORDER BY COUNT(c_sec_id) DESC;

--19
SELECT loc_id
FROM course_section
GROUP BY loc_Id
HAVING COUNT(c_sec_id) > 3;
