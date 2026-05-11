-- =============================================================
-- FILE: 02_transform_data.sql
-- PROJECT: RetailPulse Analytics Pipeline
-- PURPOSE: Transform raw data into analytics-ready tables
--          Run AFTER 01_create_tables.sql and after loading data
-- =============================================================

-- =============================================================
-- TRANSFORM 1: Daily Sales Summary
-- Business Question: How much revenue do we make each day?
-- =============================================================

CREATE OR REPLACE TABLE `retailpulse_analytics.daily_sales_summary` AS

SELECT
  DATE(o.order_purchase_timestamp)         AS order_date,
  COUNT(DISTINCT o.order_id)               AS total_orders,
  ROUND(SUM(p.payment_value), 2)           AS total_revenue,
  ROUND(AVG(p.payment_value), 2)           AS avg_order_value,
  COUNT(DISTINCT o.customer_id)            AS unique_customers,
  COUNTIF(o.order_status = 'delivered')    AS delivered_orders,
  COUNTIF(o.order_status = 'cancelled')    AS cancelled_orders

FROM `retailpulse_raw.raw_orders`          AS o
JOIN `retailpulse_raw.raw_payments`        AS p
  ON o.order_id = p.order_id

WHERE o.order_purchase_timestamp IS NOT NULL

GROUP BY order_date
ORDER BY order_date DESC;


-- =============================================================
-- TRANSFORM 2: Revenue by Product Category
-- Business Question: Which categories drive the most sales?
-- =============================================================

CREATE OR REPLACE TABLE `retailpulse_analytics.category_performance` AS

SELECT
  COALESCE(pr.product_category_name, 'unknown')  AS category,
  COUNT(oi.order_item_id)                         AS items_sold,
  COUNT(DISTINCT oi.order_id)                     AS total_orders,
  ROUND(SUM(oi.price), 2)                         AS total_revenue,
  ROUND(AVG(oi.price), 2)                         AS avg_item_price,
  ROUND(SUM(oi.freight_value), 2)                 AS total_freight,

  -- Revenue rank
  RANK() OVER (ORDER BY SUM(oi.price) DESC)       AS revenue_rank

FROM `retailpulse_raw.raw_order_items`     AS oi
JOIN `retailpulse_raw.raw_orders`          AS o
  ON oi.order_id = o.order_id
JOIN `retailpulse_raw.raw_products`        AS pr
  ON oi.product_id = pr.product_id

WHERE o.order_status = 'delivered'

GROUP BY category
ORDER BY total_revenue DESC;


-- =============================================================
-- TRANSFORM 3: Order Status KPI
-- Business Question: What % of orders are delivered vs cancelled?
-- =============================================================

CREATE OR REPLACE TABLE `retailpulse_analytics.order_status_kpi` AS

SELECT
  order_status,
  COUNT(*)                                                          AS order_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2)               AS percentage,
  ROUND(AVG(
    DATE_DIFF(
      DATE(order_delivered_customer_date),
      DATE(order_purchase_timestamp),
      DAY
    )
  ), 1)                                                             AS avg_days_to_complete

FROM `retailpulse_raw.raw_orders`
GROUP BY order_status
ORDER BY order_count DESC;


-- =============================================================
-- TRANSFORM 4: Customer State Performance
-- Business Question: Which Brazilian states have the most orders?
-- =============================================================

CREATE OR REPLACE TABLE `retailpulse_analytics.state_performance` AS

SELECT
  c.customer_state                              AS state,
  COUNT(DISTINCT o.order_id)                    AS total_orders,
  COUNT(DISTINCT o.customer_id)                 AS unique_customers,
  ROUND(SUM(p.payment_value), 2)                AS total_revenue,
  ROUND(AVG(p.payment_value), 2)                AS avg_order_value

FROM `retailpulse_raw.raw_orders`               AS o
JOIN `retailpulse_raw.raw_customers`            AS c
  ON o.customer_id = c.customer_id
JOIN `retailpulse_raw.raw_payments`             AS p
  ON o.order_id = p.order_id

WHERE o.order_status = 'delivered'

GROUP BY state
ORDER BY total_revenue DESC;


-- =============================================================
-- TRANSFORM 5: Monthly Revenue with MoM Growth
-- Business Question: Is the business growing month over month?
-- =============================================================

CREATE OR REPLACE TABLE `retailpulse_analytics.monthly_growth` AS

WITH monthly_revenue AS (
  SELECT
    FORMAT_DATE('%Y-%m', order_date)    AS month,
    SUM(total_revenue)                  AS monthly_revenue,
    SUM(total_orders)                   AS monthly_orders
  FROM `retailpulse_analytics.daily_sales_summary`
  GROUP BY month
)
SELECT
  month,
  monthly_revenue,
  monthly_orders,
  LAG(monthly_revenue) OVER (ORDER BY month) AS prev_month_revenue,

  -- Month-over-month growth percentage
  ROUND(
    (monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month))
    / NULLIF(LAG(monthly_revenue) OVER (ORDER BY month), 0)
    * 100, 2
  )                                           AS mom_growth_pct

FROM monthly_revenue
ORDER BY month DESC;
