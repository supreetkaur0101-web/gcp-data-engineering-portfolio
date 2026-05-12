import subprocess
import argparse
from datetime import datetime

parser = argparse.ArgumentParser()

parser.add_argument(
    "--rows",
    type=int,
    default=1000
)

args = parser.parse_args()

timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")

local_file = f"data/orders_{timestamp}.csv"

bucket_name = "streamflow-raw-streamflow-etl"

gcs_uri = f"gs://{bucket_name}/orders_{timestamp}.csv"

print("=" * 50)
print(" StreamFlow ETL Pipeline — Starting Run")
print("=" * 50)

# STEP 1 — Generate Data
print("\n[STEP 1/4] Generating data...")

subprocess.run([
    "python",
    "src/data_generator.py",
    "--rows",
    str(args.rows),
    "--output",
    local_file
], check=True)

print(f"✓ Generated file: {local_file}")

# STEP 2 — Upload to GCS
print("\n[STEP 2/4] Uploading to Cloud Storage...")

subprocess.run([
    "python",
    "src/uploader.py",
    "--file",
    local_file
], check=True)

print(f"✓ Uploaded to: {gcs_uri}")

# STEP 3 — Load to BigQuery
print("\n[STEP 3/4] Loading to BigQuery...")

subprocess.run([
    "python",
    "src/bq_loader.py",
    "--gcs-uri",
    gcs_uri,
    "--table",
    "streamflow_raw.raw_orders"
], check=True)

print("✓ BigQuery load complete")

# STEP 4 — Transformations
print("\n[STEP 4/4] Running transformations...")

subprocess.run([
    "python",
    "src/transform.py"
], check=True)

print("✓ Transformations complete")

print("\n" + "=" * 50)
print(" Pipeline Run SUCCESSFUL")
print("=" * 50)
