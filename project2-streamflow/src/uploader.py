import argparse
from google.cloud import storage
from pathlib import Path

parser = argparse.ArgumentParser()

parser.add_argument(
    "--file",
    required=True,
    help="Path to CSV file"
)

parser.add_argument(
    "--bucket",
    default="streamflow-raw-streamflow-etl",
    help="GCS bucket name"
)

args = parser.parse_args()

file_path = args.file

if not Path(file_path).exists():
    raise FileNotFoundError(f"File not found: {file_path}")

client = storage.Client()

bucket = client.bucket(args.bucket)

blob_name = Path(file_path).name

blob = bucket.blob(blob_name)

print(f"[INFO] Uploading {file_path} to gs://{args.bucket}/{blob_name}")

blob.upload_from_filename(file_path)

print("[INFO] Upload complete!")
