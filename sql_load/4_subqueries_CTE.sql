/* SELECT *
FROM ( -- subquery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;
-- subquery ends here */

-- WITH january_jobs AS ( -- CTE definition starts here
--         SELECT *
--         FROM job_postings_fact
--         WHERE EXTRACT(MONTH FROM job_posted_date) = 1
-- ) -- CTE definition ends here

-- SELECT *
-- FROM january_jobs;

-- SELECT
--     company_id,
--     name AS company_name
-- FROM
--     company_dim
-- WHERE
--     company_id IN (
-- SELECT
--     company_id
-- FROM
--     job_postings_fact
-- WHERE
--     job_no_degree_mention = true
-- ORDER BY
--     company_id
--     )



/*
Find the companies that have the most job openings
- get the total number of job postings per company id (job_posting_fact)
- return the total number of jobs with the company name (company_dim)
*/


-- WITH company_job_count AS (
-- SELECT
--     company_id,
--     COUNT(*) AS total_jobs
-- FROM
--     job_postings_fact
-- GROUP BY
--     company_id
-- )

-- SELECT 
--     company_dim.name AS company_name,
--     company_job_count.total_jobs
-- FROM company_dim
-- LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
-- ORDER BY
--     total_jobs DESC


/*
Practice Problem 1:
Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to find the skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim table to get the skill names
*/


/*
time stamp 2:42:06
try practice problems 1 and 2 after some more practice and after ur more comfortable with subqueries and ctes and learning how to incorporate join with them also
*/
-- Practice Problem 1
SELECT
    skill_count,
    skills_dim.skills
FROM (
SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim
GROUP BY
    skill_id
ORDER BY
    skill_count DESC
LIMIT 5
) AS skill_count_table
INNER JOIN skills_dim ON skills_dim.skill_id = skill_count_table.skill_id
ORDER BY
    skill_count DESC


-- Practice Problem 2
SELECT 
    *,
    CASE
        WHEN job_count < 10 THEN 'Small Company'
        WHEN job_count BETWEEN 10 AND 50 THEN 'Medium Company'
        WHEN job_count > 50 THEN 'Large Company'
    END AS company_size_category
FROM (
SELECT
    COUNT(*) AS job_count,
    company_dim.name AS company_name
FROM
    job_postings_fact
INNER JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
GROUP BY
    company_dim.name
) AS company_job_count





















/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/
WITH remote_job_skills AS (
    SELECT
        -- job_postings.job_id, now that were counting skill, this column is no longer useful and actually messes with the group by so get rid of it
        skills_to_job.skill_id,
        -- job_postings.job_work_from_home (once u confirm that all listings have the value true for work from home, u can just take it out cuz its redundant. once u check that its all true anyways, u dont need it to be there telling u the true values)
        COUNT(*) AS skill_count
    FROM 
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE AND job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skills_to_job.skill_id
)

SELECT
    skills.skill_id,
    skills as skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;