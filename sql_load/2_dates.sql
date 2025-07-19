    SELECT DISTINCT
        comp.name
    FROM
        company_dim as comp
    LEFT JOIN job_postings_fact AS job ON comp.company_id = job.company_id
    WHERE
        (EXTRACT(MONTH FROM job.job_posted_date) BETWEEN 4 AND 6) AND job.job_health_insurance = TRUE;