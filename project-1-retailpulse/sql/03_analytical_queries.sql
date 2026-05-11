-- =============================================================
-- FILE: 03_analytical_queries.sql
-- PROJECT: RetailPulse Analytics Pipeline
-- PURPOSE: Final analytical queries + data quality checks
--          Run AFTER 02_transform_data.sql
-- =============================================================


-- =============================================================
-- SECTION A: DATA QUALITY CHECKS
-- Always run these after a pipeline run to catch issues early
-- =============================================================

-- Check 1: Row counts across all tables
SELECT 'raw_orders'       AS table_name, COUNT(*) AS row_count FROM `retailpulse_raw.raw_orders`
UNION ALL
SELECT 'raw_order_items',                COUNT(*) FROM `retailpulse_raw.raw_order_items`
UNION ALL
SELECT 'raw_products',                   COUNT(*) FROM `retailpulse_raw.raw_products`
UNION ALL
SELECT 'raw_payments',                   COUNT(*) FROM `retailpulse_raw.raw_payments`
UNION ALL
SELECT 'raw_customers',                  COUNT(*) FROM `retailpulse_raw.raw_customers`;

/*
Expected output:
table_name       | row_count
raw_orders       | 99441
raw_order_items  | 112650
raw_products     | 32951
raw_payments     | 103886
raw_customers    | 99441
*/


-- Check 2: Null check on critical columns
SELECT
  COUNTIF(order_id IS NULL)                         AS null_order_ids,
  COUNTIF(customer_id IS NULL)                      AS null_customer_ids,
  COUNTIF(order_purchase_timestamp IS NULL)         AS null_timestamps,
  COUNTIF(order_status IS NULL)                     AS null_status,
  ROUND(
    COUNTIF(order_delivered_customer_date IS NULL)
    * 100.0 / COUNT(*), 2
  )                                                 AS pct_null_delivery_date
FROM `retailpulse_raw.raw_orders`;

/*
Expected: null_order_ids = 0, null_customer_ids = 0
Some null delivery dates are OK (orders not yet delivered)
*/


-- Check 3: Duplicate order check
SELECT
  order_id,
  COUNT(*) AS duplicates
FROM `retailpulse_raw.raw_orders`
GROUP BY order_id
HAVING COUNT(*) > 1
LIMIT 10;

-- Expected: 0 rows (no duplicates). If you see rows, investigate!


-- Check 4: Date range validation
SELECT
  MIN(order_purchase_timestamp) AS earliest_order,
  MAX(order_purchase_timestamp) AS latest_order,
  DATE_DIFF(
    DATE(MAX(order_purchase_timestamp)),
    DATE(MIN(order_purchase_timestamp)),
    DAY
  )                             AS date_range_days
FROM `retailpulse_raw.raw_orders`;

/*
Expected:
earliest_order: 2016-09-04
latest_order:   2018-10-17
date_range_days: ~743 days of data
*/


-- =============================================================
-- SECTION B: BUSINESS ANALYTICS QUERIES
-- =============================================================

-- Query 1: Best month for sales
SELECT
  FORMAT_DATE('%B %Y', order_date)    AS month_name,
  SUM(total_revenue)                  AS monthly_revenue,
  SUM(total_orders)                   AS monthly_orders,
  ROUND(SUM(total_revenue) / SUM(total_orders), 2) AS avg_order_value
FROM `retailpulse_analytics.daily_sales_summary`
GROUP BY month_name, DATE_TRUNC(order_date, MONTH)
ORDER BY DATE_TRUNC(order_date, MONTH) DESC
LIMIT 12;


-- Query 2: Top 5 revenue-generating categories
SELECT
  category,
  total_revenue,
  items_sold,
  avg_item_price,
  revenue_rank
FROM `retailpulse_analytics.category_performance`
WHERE revenue_rank <= 5
ORDER BY revenue_rank;


-- Query 3: Delivery performance — on-time vs late
SELECT
  CASE
    WHEN order_delivered_customer_date <= order_estimated_delivery_date
    THEN 'On Time'
    ELSE 'Late'
  END                                               AS delivery_status,
  COUNT(*)                                          AS order_count,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM `retailpulse_raw.raw_orders`
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status;


-- Query 4: Revenue by payment type
SELECT
  payment_type,
  COUNT(DISTINCT order_id)               AS order_count,
  ROUND(SUM(payment_value), 2)           AS total_revenue,
  ROUND(AVG(payment_installments), 1)    AS avg_installments
FROM `retailpulse_raw.raw_payments`
GROUP BY payment_type
ORDER BY total_revenue DESC;


-- Query 5: Weekly sales pattern (which day of the week sells most?)
SELECT
  FORMAT_DATE('%A', order_date)          AS day_of_week,
  EXTRACT(DAYOFWEEK FROM order_date)     AS day_num,
  ROUND(AVG(total_revenue), 2)           AS avg_daily_revenue,
  ROUND(AVG(total_orders), 0)            AS avg_daily_orders
FROM `retailpulse_analytics.daily_sales_summary`
GROUP BY day_of_week, day_num
ORDER BY day_num;
