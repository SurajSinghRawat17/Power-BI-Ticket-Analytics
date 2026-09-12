-- create database 
Create database Helpdesk_data

-- selecting database
Use Helpdesk_data

-- imported csv file into database
SELECT TOP 10 *
FROM synthetic_it_support_tickets;

-- finding total null values in each column
SELECT
    SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS ticket_id_nulls,
    SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS created_at_nulls,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN customer_segment IS NULL THEN 1 ELSE 0 END) AS customer_segment_nulls,
    SUM(CASE WHEN channel IS NULL THEN 1 ELSE 0 END) AS channel_nulls,
    SUM(CASE WHEN product_area IS NULL THEN 1 ELSE 0 END) AS product_area_nulls,
    SUM(CASE WHEN issue_type IS NULL THEN 1 ELSE 0 END) AS issue_type_nulls,
    SUM(CASE WHEN priority IS NULL THEN 1 ELSE 0 END) AS priority_nulls,
    SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS status_nulls,
    SUM(CASE WHEN sla_plan IS NULL THEN 1 ELSE 0 END) AS sla_plan_nulls,
    SUM(CASE WHEN initial_message IS NULL THEN 1 ELSE 0 END) AS initial_message_nulls,
    SUM(CASE WHEN agent_first_reply IS NULL THEN 1 ELSE 0 END) AS agent_first_reply_nulls,
    SUM(CASE WHEN resolution_summary IS NULL THEN 1 ELSE 0 END) AS resolution_summary_nulls,
    SUM(CASE WHEN resolution_time_hours IS NULL THEN 1 ELSE 0 END) AS resolution_time_hours_nulls,
    SUM(CASE WHEN reopened IS NULL THEN 1 ELSE 0 END) AS reopened_nulls,
    SUM(CASE WHEN customer_sentiment IS NULL THEN 1 ELSE 0 END) AS customer_sentiment_nulls,
    SUM(CASE WHEN csat_score IS NULL THEN 1 ELSE 0 END) AS csat_score_nulls,
    SUM(CASE WHEN has_attachment IS NULL THEN 1 ELSE 0 END) AS has_attachment_nulls,
    SUM(CASE WHEN platform IS NULL THEN 1 ELSE 0 END) AS platform_nulls,
    SUM(CASE WHEN region IS NULL THEN 1 ELSE 0 END) AS region_nulls
FROM synthetic_it_support_tickets;


--null values in resolution_time_hours
SELECT *
FROM dbo.synthetic_it_support_tickets
WHERE resolution_time_hours IS NULL;


--filling null values in resolution_time_hours
UPDATE dbo.synthetic_it_support_tickets
SET resolution_time_hours = 0.00
WHERE resolution_time_hours IS NULL;


-- creating a view that only contains data for Power BI
CREATE VIEW vw_PowerBI_ITSupport AS

SELECT
    ticket_id, created_at, customer_id, customer_segment, channel,
    product_area, issue_type, priority, status, sla_plan,
    resolution_time_hours, reopened, customer_sentiment, csat_score, has_attachment,
    platform, region
FROM dbo.synthetic_it_support_tickets;

Select * from dbo.vw_PowerBI_ITSupport