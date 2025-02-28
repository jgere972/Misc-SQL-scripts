--COURSe 2521-001
--01-03-23
--Assignment 2
--Joseph Geres

--Queries

--1
SELECT COUNT(course_no) AS NoPrereqCourseAmount
FROM course
WHERE prerequisite IS NULL;

--2
SELECT DISTINCT MIN(YEAR(enroll_date)) + 4 AS GraduationYear 
FROM enrollment;

--3
SELECT student_id, COUNT(section_id) AS CoursesTaken
FROM enrollment
GROUP BY student_id
HAVING COUNT(section_id) >= 3;

--4
SELECT grade_type_code AS Submissions, percent_of_final_grade AS WeightForFinalGrade
FROM grade_type_weight
WHERE section_id = '131';

--5
SELECT employer, COUNT(student_id) AS TotalStudentsHired
FROM student
GROUP BY employer
ORDER BY COUNT(student_id) DESC
LIMIT 1;

--6
SELECT location, COUNT(*) AS NumberOfTimesLocationIsUsed, SUM(capacity) AS TotalCapacity
FROM section
WHERE section_no = 3 AND location LIKE 'L%2%'
GROUP BY location
HAVING SUM(capacity) >= 50;

--7
SELECT SUM(Instructors) AS NumOfInstructors  --Subquery used to count the instructors first them sum them up to find the total
FROM (
      SELECT COUNT(DISTINCT instructor_id) AS Instructors  --distinct COUNT used to show the instructors represented by 1s, who meet the condition in the HAVING clause
      FROM section
      GROUP BY section.instructor_id
      HAVING COUNT(section_id) >= 1
     ) AS InstructorCounter;
     

--8
SELECT section_id, MAX(enroll_date) AS MostRecentEnrollment
FROM enrollment
GROUP BY section_id
HAVING COUNT(student_id) IS NOT NULL;

--9
SELECT instructor.first_name AS InstructorFirst, instructor.last_name AS InstructorLast, course.description
FROM section JOIN instructor USING (instructor_id)
     	     JOIN enrollment ON section.section_id = enrollment.section_id
	     JOIN course USING(course_no)
WHERE enrollment.final_grade IS NOT NULL;

--10
SELECT section_id
FROM section, course
WHERE section.course_no = course.course_no
AND course.prerequisite IS NULL;

--11
SELECT description, instructor.last_name AS InstructorLast
FROM section JOIN course USING(course_no)
     	     JOIN instructor ON section.instructor_id = instructor.instructor_id
WHERE course.prerequisite = '350'
GROUP BY section.course_no
HAVING COUNT(section_no) IS NOT NULL;

--12
SELECT numeric_grade As LarryWalterGrades
FROM grade, student
WHERE grade.student_id = student.student_id
AND student.first_name = 'Larry'
AND student.last_name = 'Walter'
AND grade.grade_type_code IN('HM', 'QZ');


--13
SELECT numeric_grade AS FinalExaminationGrades
FROM student, zipcode, grade, section, enrollment
WHERE student.zip = zipcode.zip
AND enrollment.student_id = student.student_id
AND section.section_id = enrollment.section_id
AND grade.section_id = section.section_id
AND zipcode.state = 'NJ' AND section.course_no = '350';

--14
SELECT description AS Course , numeric_grade AS LowestGrades
FROM section JOIN grade USING(section_id)
     	     JOIN course ON section.course_no = course.course_no
GROUP BY grade.section_id
HAVING MIN(numeric_grade)
ORDER BY numeric_grade DESC;

--15
SELECT * 
FROM grade_type_weight
WHERE section_id = '95'
      UNION ALL		--Combine queries
SELECT *
FROM grade_type_weight
WHERE section_id = '125';

--16
SELECT course.course_no As Course				
FROM section JOIN enrollment USING(section_id)
     	     JOIN course ON section.course_no = course.course_no
GROUP BY section.course_no, enrollment.section_id			
HAVING COUNT(enrollment.student_id > 1;
