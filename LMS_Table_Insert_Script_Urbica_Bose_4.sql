use lms;

#--- 1.List All Courses with Their Category Names
#Retrieve a list of courses along with the name of the category to which each course belongs.

select * from courses;

select * from categories;

select c.course_name, ca.category_name from courses c inner join categories ca 
on c.category_id = ca.category_id;

#---2. Count the Number of Courses in Each Category
#Question: For each category, count how many courses exist.

select * from courses;

select * from categories;

select count(*) as course_count, ca.category_name
from courses c inner join categories ca on c.category_id = ca.category_id 
group by ca.category_name order by course_count desc;

#-- 3. List All Students’ Full Names and Email Addresses
# Question: Retrieve the full names and email addresses for all users with the role 'student.'

select * from user;

select concat(first_name,' ',last_name) as Full_Name, email as Email_Address
from user where role = 'student';

#-- 4. Retrieve All Modules for a Specific Course Sorted by Module Order
#Question: For a given course (e.g., course_id = 1), list its modules sorted by their order.

select * from courses;

select * from modules;

select c.course_id,c.course_name, m.module_name, m.module_order 
from modules m inner join courses c on c.course_id = m.course_id order by c.course_id, m.module_order;

use lms;

#--5. List All Content Items for a Specifi c Module
#Question: Retrieve all content items for a specific module (for example, module_id = 2).

select * from content;

select content_id, title, content_type as Content_Items, url from content
where module_id = 4;

#--6. Find the Average Score for a Specifi c Assessment
#Question: Calculate the average score of submissions for a given assessment (e.g., assessment_id = 1).

select * from assessment_submission;

select assessment_id, submission_data as Submissions, round(avg(score),2) as Average_score from 
assessment_submission where assessment_id = 28 
group by assessment_id, submission_data;

#--7. List All Enrollments with Student Names and Course Names
#Question: Retrieve a list of enrollments that shows the student’s full name, the course name, 
#and the enrollment date.

select * from enrollments;

select * from user;

select * from courses;

select concat(u.first_name,' ', u.last_name) as Full_name, c.course_name, 
date(en.enrolled_at) as enrollment_date from enrollments en inner join 
user u on en.user_id = u.user_id inner join courses c on en.course_id = c.course_id
where role = 'student';

#--8. Retrieve All Instructors’ Full Names
#Question: List the full names and email addresses of all users with the role 'instructor'.

select * from user;

select concat(first_name,' ', last_name) as Full_Names, email as Email_Addresses
from user where role = 'instructor';

#-- 9. Count the Number of Assessment Submissions per Assessment
#Question: For each assessment, count how many submissions have been made.

select * from assessment_submission;

SELECT assessment_id, COUNT(assessment_id) AS Number_of_Assessment_Submission
FROM assessment_submission GROUP BY assessment_id;

#--10. List the Top Scoring Submission for Each Assessment
#Question: Retrieve, for each assessment, the submission that achieved the highest score.

select * from assessment_submission;

SELECT s.submission_id, s.assessment_id, s.user_id, s.submitted_at, s.score
FROM assessment_submission AS s
LEFT JOIN ( SELECT assessment_id, MAX(score) AS max_score
FROM assessment_submission GROUP BY assessment_id) AS x
ON  s.assessment_id = x.assessment_id AND s.score = x.max_score;

# alternative way
select assessment_id, submission_id, user_id, score from assessment_submission;

#--11. Retrieve Courses Created After a Specifi c Date
#Question: List courses that were created after '2023-04-01'.

select * from courses;

SELECT course_id, course_name, description, created_at
FROM courses WHERE created_at > '2023-04-01';

# ALternative Way:- 

select * from courses where (created_at)> '2023-04-01';

#--12. Find Students Who Have Not Submitted Any Assessments
#Question: Retrieve a list of students who do not have any records in the assessment_submission table.

select * from user;

select * from assessment_submission;

SELECT u.user_id, CONCAT(u.first_name, ' ', u.last_name)
AS full_name, u.email
FROM user u LEFT JOIN 
assessment_submission s ON u.user_id = s.user_id
WHERE u.role = 'student' AND s.submission_id IS NULL;

#--13. List the Content for Courses in the 'Programming' Category
#Question: Retrieve all content items for courses whose category is 'Programming'.

select * from courses;

select * from categories;

select c.course_id, c.course_name as Content_Items, c.description, ca.category_name,
ca.category_id from courses c inner join categories ca on c.category_id = ca.category_id
where ca.category_name = 'Programming'; 

#-- 14. Retrieve Modules That Have No Associated Content
#Question: List modules that do not have any content items linked to them.

select * from modules;

select * from content;

SELECT m.module_id, m.module_name, m.course_id
FROM modules m LEFT JOIN content c ON m.module_id = c.module_id
WHERE c.content_id IS NULL;

#--15. List Courses with the Total Number of Enrollments
#Question: For each course, display the course name along with the count of enrollments.

select * from enrollments;

select * from courses;

select c.course_id, c.course_name, count(e.enrollment_id) as Count_of_Enrollments
from courses c inner join enrollments e on c.course_id = e.course_id 
group by c.course_id, c.course_name;

#-- 16. Find the Average Assessment Submission Score for Each Course
#Question: Calculate the average score of all assessment submissions for each course by joining courses, modules, assessments, and submissions.

select * from courses;

select * from modules;

select * from assessments;

select * from assessment_submission;

SELECT c.course_id, c.course_name, m.module_name, AVG(s.score) AS average_score
FROM courses c INNER JOIN modules m ON c.course_id = m.course_id
INNER JOIN assessments a ON m.module_id = a.module_id
INNER JOIN assessment_submission s ON a.assessment_id = s.assessment_id
GROUP BY c.course_id, c.course_name, m.module_name;

#-- 17. List Users with Their Number of Enrollments
#Question: Retrieve a list of all users along with the count of courses they are enrolled in.

SELECT * FROM user;

select * from enrollments;

SELECT u.user_id, CONCAT(u.first_name, ' ', u.last_name) AS full_name,
COUNT(e.enrollment_id) AS enrollments_count FROM user u
LEFT JOIN enrollments e ON u.user_id = e.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY enrollments_count DESC;     

use lms;

#--18. Find the Assessment with the Highest Average Score
#Question: Identify the assessment that has the highest average submission score.

select * from assessments;

select * from assessment_submission;

SELECT a.assessment_id,a.assessment_name, ROUND(AVG(s.score),2) AS average_score
FROM assessments a INNER JOIN assessment_submission s 
ON a.assessment_id = s.assessment_id GROUP BY 
a.assessment_id, a.assessment_name
ORDER BY average_score DESC
LIMIT 1;

#--19. List Courses Along with Their Modules and Content in Hierarchical Order
#Question: Retrieve a hierarchical list that shows each course, its modules, and the content items within each module.

SELECT * from courses;

select * from content;

select * from modules;

SELECT c.course_id, c.course_name, m.module_id, m.module_name,
ctt.content_id, ctt.title AS content_title, ctt.content_type
FROM courses c INNER JOIN modules m ON c.course_id = m.course_id
LEFT JOIN content ctt ON m.module_id = ctt.module_id
ORDER BY c.course_name, m.module_order, ctt.title;

#-- 20. Find the Total Number of Assessments Per Course
#Question: For each course, count the total number of assessments available by joining courses, modules, and assessments.

SELECT * FROM courses;

select * from modules;

select * from assessments;

SELECT  c.course_id, c.course_name, COUNT(a.assessment_id) AS total_assessments
FROM  courses c INNER JOIN modules m ON c.course_id = m.course_id
INNER JOIN assessments a ON m.module_id = a.module_id
GROUP BY c.course_id, c.course_name
ORDER BY total_assessments DESC;

#--21. List All Enrollments from May 2023
#Question: Retrieve all enrollment records where the enrollment date falls within May 2023.

SELECT * FROM enrollments;


SELECT enrollment_id, course_id, user_id, enrolled_at
FROM enrollments
WHERE enrolled_at >= '2023-05-01' AND enrolled_at < '2023-06-01';

#-- 22. Retrieve Assessment Submission Details Along with Course and Student Information
#Question: For each assessment submission, display the submission details along with the corresponding course name, student name, and assessment name.

select * from assessments;

select * from modules;

select * from courses;

SELECT s.submission_id, s.score, s.submitted_at,
a.assessment_name,c.course_name,
CONCAT(u.first_name, ' ', u.last_name) AS student_name, u.email
FROM assessment_submission s
INNER JOIN assessments a ON s.assessment_id = a.assessment_id
INNER JOIN modules m ON a.module_id = m.module_id
INNER JOIN courses c ON m.course_id = c.course_id
INNER JOIN user u ON s.user_id = u.user_id
WHERE u.role = 'student' ORDER BY s.submitted_at DESC;


#-- 23. List All Users with Their Roles
#Question: Retrieve a list of all users showing their full names and roles.

SELECT * FROM user;

SELECT  user_id, CONCAT(first_name, ' ', last_name) AS full_name,
role FROM user ORDER BY user_id asc;

#-- 24. Find the Percentage of Passing Submissions for Each Assessment
#Question: Assuming a passing score is 60 or above, calculate the passing percentage for each assessment.

SELECT a.assessment_id, a.assessment_name, ROUND(SUM(CASE WHEN s.score >= 60 THEN 1 ELSE 0 END)        
/ NULLIF(COUNT(s.submission_id), 0) * 100 ,2) AS passing_percentage
FROM assessments AS a LEFT JOIN assessment_submission AS s
ON a.assessment_id = s.assessment_id 
GROUP  BY a.assessment_id, a.assessment_name
ORDER  BY passing_percentage DESC;

#-- 25. Find Courses That Do Not Have Any Enrollments
#Question: List the courses for which there are no enrollment records.

select * from courses;

select * from enrollments;

SELECT c.course_id, c.course_name, c.description, c.created_at
FROM courses c LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE e.enrollment_id IS NULL;

##################END#######################





                   





















































