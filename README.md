# GCP Data Engineering Portfolio

Production-style end-to-end data engineering projects built on Google Cloud Platform (GCP) using BigQuery, Cloud Storage, SQL, Python, ETL pipelines, and BI dashboards.

---


<img width="1229" height="823" alt="image" src="https://github.com/user-attachments/assets/5a0367a4-7dfb-4a36-990b-eeba861038c5" />



---

## 👋 About This Portfolio

Hi! I'm a data engineer passionate about building scalable, cloud-native data pipelines on GCP.
This portfolio contains **two complete projects** — each tackling a real business problem using
different approaches — from no-code/low-code UI-driven workflows to fully coded Python pipelines.

| | Project 1 | Project 2 |
|---|---|---|
| **Title** | 🛒 RetailPulse Analytics | ⚡ StreamFlow ETL Engine |
| **Approach** | No-code / Low-code (GCP Console) | Python + CLI (fully coded) |
| **Scenario** | E-commerce sales reporting | Real-time order ingestion & analytics |
| **GCP Services** | GCS, BigQuery, Looker Studio, Data Transfer | GCS, BigQuery, Cloud Functions, Pub/Sub |
| **Skill Level** | Beginner-friendly | Intermediate |
| **Dataset** | Brazilian E-Commerce (Olist) | Simulated retail orders (custom generator) |

---

## 📁 Repository Structure

```
gcp-data-engineering-portfolio/
│
├── README.md                          ← You are here
│
├── project-1-retailpulse/             ← No-code/Low-code project
│   ├── README.md                      ← Full step-by-step guide
│   ├── sql/
│   │   ├── 01_create_tables.sql
│   │   ├── 02_transform_data.sql
│   │   └── 03_analytical_queries.sql
│   ├── data/
│   │   └── sample_orders.csv          ← Sample data to upload
│   ├── screenshots/                   ← Add your own GCP console screenshots here
│   │   └── .gitkeep
│   └── architecture/
│       └── architecture.md
│
└── project-2-streamflow/              ← Python + CLI project
    ├── README.md                      ← Full guide with CLI commands
    ├── src/
    │   ├── data_generator.py          ← Generates fake order data
    │   ├── uploader.py                ← Uploads CSV to GCS
    │   ├── bq_loader.py               ← Loads GCS data to BigQuery
    │   ├── transform.py               ← Runs SQL transformations
    │   └── pipeline.py                ← Orchestrates full pipeline
    ├── sql/
    │   ├── schema.json                ← BigQuery table schema
    │   ├── transform.sql              ← Transformation queries
    │   └── analytics.sql              ← Final analytics queries
    ├── config/
    │   └── config.yaml                ← Project configuration
    ├── tests/
    │   └── test_pipeline.py           ← Unit tests
    ├── requirements.txt
    ├── .env.example
    └── Makefile                       ← One-command pipeline runner
```

---

## 🛠️ GCP Services Used (Quick Reference)

| Service | What It Does | Used In |
|---|---|---|
| **Cloud Storage (GCS)** | Store raw CSV/JSON files (like S3) | Both projects |
| **BigQuery** | Serverless SQL data warehouse | Both projects |
| **Looker Studio** | BI dashboards (like Tableau, free) | Project 1 |
| **Cloud Functions** | Serverless Python functions | Project 2 |
| **Pub/Sub** | Message queue for real-time data | Project 2 (concept) |
| **IAM** | Access control and permissions | Both projects |

---
## 🎯 Skills Demonstrated

- Cloud Data Engineering
- ETL / ELT Pipelines
- BigQuery SQL
- Data Warehouse Design
- Dashboard Development
- Data Automation
- Cloud Architecture
- Python Data Engineering
- Batch Processing
- Scheduled Workflows

---

## 📊 Portfolio Highlights

- Built production-style GCP pipelines
- Processed and transformed large datasets
- Created business KPI dashboards
- Implemented automated ingestion workflows
- Structured cloud-native analytics architecture

---


## 📬 Contact

- **LinkedIn:** https://www.linkedin.com/in/supreetkaursingh/
- **Email:** supreetkaur0101@yahoo.com
- **GitHub:** https://github.com/supreetkaur0101-web/gcp-data-engineering-portfolio
=======
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

