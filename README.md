# GCP Data Engineering Portfolio

Production-style end-to-end data engineering projects built on Google Cloud Platform (GCP) using BigQuery, Cloud Storage, SQL, Python, ETL pipelines, and BI dashboards.

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


## 📬 Contact

- **LinkedIn:** https://www.linkedin.com/in/supreetkaursingh/
- **Email:** supreetkaur0101@yahoo.com
- **GitHub:** https://github.com/supreetkaur0101-web/gcp-data-engineering-portfolio
