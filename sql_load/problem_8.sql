/*
Find job postings from the first quarter that have a salary greater than $70k
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $ 70,000
*/

SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    job_posted_date
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS q1_jobs
WHERE
    salary_year_avg > 70000 and job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg