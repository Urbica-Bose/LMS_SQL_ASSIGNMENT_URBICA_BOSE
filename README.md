# LMS_SQL_ASSIGNMENT_URBICA_BOSE

 Project Introduction

This project showcases a full‑cycle SQL exploration of an LMS (Learning Management System) schema using MySQL Workbench: we began by mapping table relationships, then wrote targeted queries to answer real business questions. We identified course–category links, counted courses per category, and listed student emails via simple joins; drilled into course structures by pulling ordered modules and their content; calculated metrics such as average scores per assessment, top‑scoring submissions, and course‑level averages through multi‑table joins; produced operational reports like enrollments‑per‑user, May 2023 enrollment extracts, and assessments‑per‑course; surfaced data‑quality insights by flagging modules without content and courses without enrollments; and built performance dashboards—passing‑rate percentages, highest‑average assessments, and booking of assessments—using grouped aggregates, CASE logic, and LEFT JOINs to preserve zero‑activity rows. Throughout, we emphasized best practices: date‑range filtering instead of functions for index use, LEFT JOIN vs INNER JOIN to control result completeness, and clear ordering for hierarchical output. Together these queries form a reusable library that answers 20 + core analytics questions, illustrating relational‑model reasoning, aggregation, and query optimization—ready for immediate use or extension in any LMS analytics project.

Through this project, I aimed to strengthen my SQL skills using MySQL Workbench, with a focus on writing clean, efficient, and production-ready queries for reporting and insights.


1. Schema Understanding & Relationship Mapping

Reviewed and documented the structure of all 8 tables: users, courses, categories, enrollments, modules, contents, assessments, and assessment_submission.

Identified key relationships:

courses → modules → assessments → submissions

courses → categories

users → enrollments

modules → contents

🔍 2. Descriptive Analysis
Retrieved and listed:

Courses with their respective categories.

All users with their roles and full names.

Modules and content for a given course.

Enrollments that occurred during May 2023.

📊 3. Aggregation & Count Metrics
Counted:

Total number of courses per category.

Number of assessment submissions per assessment.

Total assessments per course.

Enrollments per user.

Identified:

Courses with no enrollments.

Modules with no content.

Students with no submissions.

📈 4. Score-Based and Statistical Insights
Calculated:

Average assessment submission scores (by assessment and course).

Percentage of passing submissions per assessment (pass = score ≥ 60).

Identified:

Assessment with the highest average score.

Top-scoring submission per assessment.

🧾 5. Hierarchical & Detailed Views


Generated a hierarchical view showing:

Courses → Modules → Content.

Pulled detailed submission data showing:

Student name, course name, and assessment name for each submission.

🛠️ 6. Query Best Practices Applied

Used:  INNER JOIN, LEFT JOIN, GROUP BY, ORDER BY, HAVING, CASE, RANK() window function, and filtering via WHERE.

Optimized:

Date-based filters using ranges (not functions) for better performance.

Aggregation logic using conditional counting with CASE.

This end-to-end analysis covers descriptive, diagnostic, and performance-related queries, forming a comprehensive analytical foundation for any LMS-based reporting or dashboarding system.


