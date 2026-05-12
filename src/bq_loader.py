import argparse
from google.cloud import bigquery

parser = argparse.ArgumentParser()

parser.add_argument(
    "--gcs-uri",
    required=True,
    help="GCS file path"
)

parser.add_argument(
    "--table",
    required=True,
    help="BigQuery table name"
)

args = parser.parse_args()

client = bigquery.Client()

job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV,
    skip_leading_rows=1,
    write_disposition="WRITE_APPEND",
    schema=[
        bigquery.SchemaField("order_id", "STRING", mode="REQUIRED"),
        bigquery.SchemaField("customer_id", "STRING"),
        bigquery.SchemaField("product_category", "STRING"),
        bigquery.SchemaField("quantity", "INTEGER"),
        bigquery.SchemaField("unit_price", "FLOAT"),
        bigquery.SchemaField("total_amount", "FLOAT"),
        bigquery.SchemaField("order_timestamp", "TIMESTAMP"),
    ]
)

print(f"[INFO] Loading {args.gcs_uri}")
print(f"[INFO] Target table: {args.table}")

load_job = client.load_table_from_uri(
    args.gcs_uri,
    args.table,
    job_config=job_config
)

load_job.result()

table = client.get_table(args.table)

print("[INFO] Load completed!")
print(f"[INFO] Rows in table: {table.num_rows}")
