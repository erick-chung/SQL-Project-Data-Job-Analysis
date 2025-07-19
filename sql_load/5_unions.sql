SELECT *
FROM january_jobs;

SELECT *
FROM february_jobs;

SELECT *
FROM march_jobs;


-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
-- now we want to join this with the february table using union operator
UNION ALL

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION ALL--combine another table 

-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs





/*DIFFERENCE BETWEEN UNION AND UNION ALL
1. UNION WILL REMOVE DUPLICATES
2. UNION ALL WILL INCLUDE ALL DATA INCLUDING DUPLICATES
3. UNION ALL IS USED MORE OFTEN CUZ U USUALLY WANT TO COMBINE TABLES AND SEE ALL DATA
*/





/*Practice Problem 1
- Get the corresponding skill and skill type for each job posting in Q1
- Includes those without any skills too
- Why? Look at the skills and the type for each job in the first quarter that has a salary > $70,000
*/
SELECT
    q1_jobs.job_id,
    skills_job_dim.skill_id,
    skills_dim.skills,
    skills_dim.type,
    q1_jobs.salary_year_avg
FROM (
SELECT
    *
FROM
    january_jobs
-- now we want to join this with the february table using union operator
UNION

-- Get jobs and companies from February
SELECT
    *
FROM
    february_jobs

UNION--combine another table 

-- Get jobs and companies from March
SELECT
    *
FROM
    march_jobs
) AS q1_jobs
LEFT JOIN skills_job_dim ON skills_job_dim.job_id = q1_jobs.job_id
LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    q1_jobs.salary_year_avg > 70000
ORDER BY
    q1_jobs.salary_year_avg
