CREATE DATABASE netflix_project;
USE netflix_project;
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50),
city VARCHAR(50),
plan_type VARCHAR(20),
monthly_fee INT,
watch_hours INT,
status VARCHAR(20)
);
INSERT INTO customers VALUES
(1,'Rahul','Mumbai','Premium',799,45,'Active'),
(2,'Aman','Delhi','Basic',299,5,'Churned'),
(3,'Priya','Pune','Standard',499,30,'Active'),
(4,'Neha','Delhi','Premium',799,10,'Churned'),
(5,'Ravi','Bangalore','Standard',499,50,'Active'),
(6,'Anjali','Mumbai','Basic',299,15,'Active'),
(7,'Karan','Delhi','Premium',799,60,'Active'),
(8,'Sneha','Pune','Basic',299,8,'Churned'),
(9,'Arjun','Bangalore','Premium',799,40,'Active'),
(10,'Meera','Mumbai','Standard',499,20,'Active');
SELECT COUNT(*) AS total_customers
FROM customers;
SELECT SUM(monthly_fee) AS revenue
FROM customers;
SELECT
    plan_type,
    SUM(monthly_fee) AS revenue
FROM customers
GROUP BY plan_type;
SELECT
ROUND(
    SUM(CASE WHEN status = 'Churned' THEN 1 ELSE 0 END) * 100.0 /
    COUNT(*),
    2
) AS churn_rate
FROM customers;
SELECT
    city,
    SUM(monthly_fee) AS revenue
FROM customers
GROUP BY city
ORDER BY revenue DESC;
SELECT
    customer_name,
    watch_hours,
    CASE
        WHEN watch_hours >= 40 THEN 'Heavy User'
        WHEN watch_hours >= 20 THEN 'Medium User'
        ELSE 'Low User'
    END AS user_segment
FROM customers;
CREATE VIEW customer_segments AS
SELECT
    customer_id,
    customer_name,
    city,
    plan_type,
    monthly_fee,
    watch_hours,
    status,
    CASE
        WHEN watch_hours >= 40 THEN 'Heavy User'
        WHEN watch_hours >= 20 THEN 'Medium User'
        ELSE 'Low User'
    END AS user_segment
FROM customers;
SELECT * FROM customer_segments;
SHOW FULL TABLES IN netflix_project;
SELECT * FROM customer_segments;
SELECT VERSION();
SELECT
    customer_name,
    monthly_fee,
    RANK() OVER (ORDER BY monthly_fee DESC) AS revenue_rank
FROM customers;
SELECT
    status,
    COUNT(*) AS customers,
    SUM(monthly_fee) AS revenue
FROM customers
GROUP BY status;
SELECT
    COUNT(*) AS total_customers,
    SUM(monthly_fee) AS total_revenue,
    AVG(watch_hours) AS avg_watch_hours,
    ROUND(
        SUM(CASE WHEN status='Churned' THEN 1 ELSE 0 END)
        *100/COUNT(*),2
    ) AS churn_rate
FROM customers;
CREATE TABLE customers_large AS
SELECT * FROM customers;
INSERT INTO customers_large
SELECT
customer_id + 100,
customer_name,
city,
plan_type,
monthly_fee,
watch_hours,
status
FROM customers_large;
SELECT COUNT(*) FROM customers_large;
INSERT INTO customers_large
SELECT
customer_id + 100,
customer_name,
city,
plan_type,
monthly_fee,
watch_hours,
status
FROM customers_large;
SELECT COUNT(*) FROM customers_large;
INSERT INTO customers_large
SELECT
customer_id + 100,
customer_name,
city,
plan_type,
monthly_fee,
watch_hours,
status
FROM customers_large;
SELECT COUNT(*) FROM customers_large;
INSERT INTO customers_large
SELECT
customer_id + 100,
customer_name,
city,
plan_type,
monthly_fee,
watch_hours,
status
FROM customers_large;
SELECT COUNT(*) FROM customers_large;
INSERT INTO customers_large
SELECT
customer_id + 100,
customer_name,
city,
plan_type,
monthly_fee,
watch_hours,
status
FROM customers_large;
SELECT COUNT(*) FROM customers_large;
INSERT INTO customers_large
SELECT
customer_id + 100,
customer_name,
city,
plan_type,
monthly_fee,
watch_hours,
status
FROM customers_large;
SELECT COUNT(*) FROM customers_large;
SELECT
city,
SUM(monthly_fee) revenue
FROM customers_large
GROUP BY city
ORDER BY revenue DESC;
SELECT
plan_type,
COUNT(*) customers
FROM customers_large
GROUP BY plan_type;
SELECT *
FROM (
    SELECT
        customer_name,
        watch_hours,
        DENSE_RANK() OVER (ORDER BY watch_hours DESC) AS rnk
    FROM customers_large
) t
WHERE rnk <= 3;
SELECT
    city,
    SUM(monthly_fee) AS revenue,
    ROUND(
        SUM(monthly_fee) * 100 /
        (SELECT SUM(monthly_fee) FROM customers_large),
        2
    ) AS revenue_pct
FROM customers_large
GROUP BY city
ORDER BY revenue DESC;
SELECT COUNT(*) FROM customers_large;

