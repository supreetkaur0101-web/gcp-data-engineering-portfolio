-- =============================================================
-- FILE: 01_create_tables.sql
-- PROJECT: RetailPulse Analytics Pipeline
-- PURPOSE: Create raw ingestion tables in BigQuery
--          Run these AFTER loading CSV files from GCS
-- =============================================================

-- ── Raw Orders Table ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `retailpulse_raw.raw_orders`
(
  order_id                          STRING,
  customer_id                       STRING,
  order_status                      STRING,
  order_purchase_timestamp          TIMESTAMP,
  order_approved_at                 TIMESTAMP,
  order_delivered_carrier_date      TIMESTAMP,
  order_delivered_customer_date     TIMESTAMP,
  order_estimated_delivery_date     TIMESTAMP
);

-- ── Raw Order Items Table ─────────────────────────────────────
CREATE TABLE IF NOT EXISTS `retailpulse_raw.raw_order_items`
(
  order_id            STRING,
  order_item_id       INT64,
  product_id          STRING,
  seller_id           STRING,
  shipping_limit_date TIMESTAMP,
  price               FLOAT64,
  freight_value       FLOAT64
);

-- ── Raw Products Table ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `retailpulse_raw.raw_products`
(
  product_id                 STRING,
  product_category_name      STRING,
  product_name_length        INT64,
  product_description_length INT64,
  product_photos_qty         INT64,
  product_weight_g           FLOAT64,
  product_length_cm          FLOAT64,
  product_height_cm          FLOAT64,
  product_width_cm           FLOAT64
);

-- ── Raw Payments Table ────────────────────────────────────────
CREATE TABLE IF NOT EXISTS `retailpulse_raw.raw_payments`
(
  order_id             STRING,
  payment_sequential   INT64,
  payment_type         STRING,
  payment_installments INT64,
  payment_value        FLOAT64
);

-- ── Raw Customers Table ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS `retailpulse_raw.raw_customers`
(
  customer_id              STRING,
  customer_unique_id       STRING,
  customer_zip_code_prefix STRING,
  customer_city            STRING,
  customer_state           STRING
);

-- =============================================================
-- Verify tables were created
-- =============================================================
SELECT
  table_name,
  creation_time,
  row_count,
  size_bytes
FROM `retailpulse_raw.INFORMATION_SCHEMA.TABLES`
ORDER BY table_name;
