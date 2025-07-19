SELECT
    count(job_id) AS number_of_jobs,
    AVG(salary_year_avg) AS average_salary,
    CASE
        WHEN salary_year_avg BETWEEN 0 AND 50000 THEN 'Low Salary'
        WHEN salary_year_avg BETWEEN 50001 AND 100000 THEN 'Standard Salary'
        WHEN salary_year_avg > 100000 THEN 'High Salary'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND job_title_short = 'Data Analyst'
GROUP BY
    salary_category
ORDER BY
    number_of_jobs DESC;