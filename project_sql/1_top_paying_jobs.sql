/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job openings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into emp...
*/
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND job_location = 'Anywhere' AND salary_year_avg IS NOT NULL
-- remember that you cant use <> or = NULL. null is an unknown value and has to be used with either IS or IS NOT. Also, if you have multiple conditions (i.e more than 2), you can use MULTIPLE AND STATEMENTS.
ORDER BY
    salary_year_avg DESC
LIMIT 10
