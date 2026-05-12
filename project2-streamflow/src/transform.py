from google.cloud import bigquery

client = bigquery.Client()

queries = {

    "daily_sales_summary": """
    CREATE OR REPLACE TABLE streamflow_analytics.daily_sales_summary AS
    SELECT
        DATE(order_timestamp) AS order_date,
        COUNT(order_id) AS total_orders,
        SUM(quantity) AS total_quantity,
        ROUND(SUM(total_amount), 2) AS total_revenue
    FROM streamflow_raw.raw_orders
    GROUP BY order_date
    ORDER BY order_date DESC
    """,

    "category_performance": """
    CREATE OR REPLACE TABLE streamflow_analytics.category_performance AS
    SELECT
        product_category,
        COUNT(order_id) AS total_orders,
        SUM(quantity) AS total_quantity,
        ROUND(SUM(total_amount), 2) AS revenue
    FROM streamflow_raw.raw_orders
    GROUP BY product_category
    ORDER BY revenue DESC
    """
}

for table_name, query in queries.items():

    print(f"[INFO] Running transformation: {table_name}")

    query_job = client.query(query)

    query_job.result()

    print(f"[INFO] {table_name} completed")
