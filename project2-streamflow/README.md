# ⚡ Project 2: StreamFlow ETL Engine
### *Python + CLI | GCP SDK | End-to-End from Scratch*
 
---
 
## 📌 Project Summary Card
 
| Field | Detail |
|---|---|
| **Business Problem** | A retail startup receives hourly order data and needs a fully automated ETL pipeline with monitoring |
| **Your Role** | Data Engineer — design, code, test, and deploy the full pipeline from scratch |
| **Approach** | Python scripts + GCP SDK + CLI (bq, gsutil, gcloud commands) |
| **Dataset** | Custom-generated realistic order data (50,000+ records) |
| **Pipeline** | Python Generator → GCS → BigQuery → SQL Transform → Analytics |
| **Duration** | ~4–6 hours to build |
| **Cost** | ~$0 (Free tier covers everything) |
 
---
 
## 🏗️ Architecture
 
```
┌─────────────────────────────────────────────────────────────────────┐
│                    StreamFlow ETL Architecture                       │
│                                                                      │
│  ┌──────────────────┐                                                │
│  │  data_generator  │  Python script generating fake orders         │
│  │  (Python)        │  ~1000 orders/run, realistic data             │
│  └────────┬─────────┘                                                │
│           │ CSV file                                                  │
│           ▼                                                           │
│  ┌──────────────────┐                                                │
│  │  uploader.py     │  Uploads CSV to Cloud Storage                 │
│  │  (gsutil / SDK)  │  Partitioned by date: raw/2024/01/15/         │
│  └────────┬─────────┘                                                │
│           │                                                           │
│           ▼                                                           │
│  ┌──────────────────┐                                                │
│  │  bq_loader.py    │  Loads GCS file → BigQuery raw table          │
│  │  (BigQuery SDK)  │  Schema validation + error handling            │
│  └────────┬─────────┘                                                │
│           │                                                           │
│           ▼                                                           │
│  ┌──────────────────┐                                                │
│  │  transform.py    │  Runs SQL transformations in BigQuery          │
│  │  (BigQuery SDK)  │  Raw → Staging → Analytics                    │
│  └────────┬─────────┘                                                │
│           │                                                           │
│           ▼                                                           │
│  ┌──────────────────┐                                                │
│  │  Analytics       │  Final queryable tables for dashboards        │
│  │  Tables          │  Ready for Looker Studio / any BI tool        │
│  └──────────────────┘                                                │
│                                                                      │
│  pipeline.py  ← Orchestrator: runs all steps in sequence            │
│  Makefile     ← make run  → runs entire pipeline with one command   │
└─────────────────────────────────────────────────────────────────────┘
```
 
---
 
## 🎯 Business Requirements
 
You're working at **QuickCart** — a fast-growing e-commerce startup. The data team needs:
 
1. **Hourly data ingestion** — orders stream in every hour as CSV files
2. **Automated ETL** — no manual steps, everything runs via code
3. **Data quality gates** — reject bad data before it reaches analytics
4. **Revenue analytics** — real-time sales metrics for the business team
5. **Audit trail** — log every pipeline run with success/failure status
---
 
## 📁 Project Structure
 
```
project-2-streamflow/
├── README.md
├── requirements.txt           ← pip install -r requirements.txt
├── .env.example               ← Copy to .env and fill in your values
├── Makefile                   ← make setup / make run / make test
├── config/
│   └── config.yaml            ← All settings in one place
├── src/
│   ├── __init__.py
│   ├── data_generator.py      ← Generates fake order data
│   ├── uploader.py            ← Uploads files to GCS
│   ├── bq_loader.py           ← Loads data into BigQuery
│   ├── transform.py           ← Runs SQL transformations
│   ├── pipeline.py            ← Main orchestrator
│   └── logger.py              ← Logging utility
├── sql/
│   ├── schema.json            ← BigQuery table schema
│   ├── transform.sql          ← Transformation queries
│   └── analytics.sql          ← Analytics queries
└── tests/
    └── test_pipeline.py       ← Unit tests
```
 
---
