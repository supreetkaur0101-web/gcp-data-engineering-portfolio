# Project 2: StreamFlow ETL Engine  
### *Python + CLI | GCP SDK | End-to-End from Scratch*

---

## Overview

Production-style ETL pipeline built on Google Cloud Platform using:

- Python for data generation
- GCS (Cloud Storage) for file staging
- BigQuery for data warehousing
- SQL transformations
- Automated orchestration using CLI tools and Makefile

This project simulates a retail startup receiving hourly order data (50,000+ records) and automates the ETL process from raw data generation to analytics.

---

## Architecture

Python Data Generator → GCS → BigQuery Raw Table → SQL Transformations → Analytics Tables → Dashboards

---

## Technologies Used

- Google Cloud Platform (GCP)
- Python (CLI scripts)
- GCS (Cloud Storage)
- BigQuery
- SQL
- GCP SDK (Python)
- Makefile for automation

---

## Business Problem

QuickCart, a fast-growing e-commerce startup, needs a fully automated ETL pipeline to process hourly order data and produce real-time revenue analytics.

---

## Features

- Realistic order data generation
- Automated GCS file upload
- BigQuery loading with schema validation
- SQL transformations from raw to analytics layer
- Orchestration via a Makefile (single command run)
- Data quality checks and audit logging

---

## Dataset

Custom-generated synthetic order data (50,000+ records), simulating real e-commerce transactions.

---

## Dashboards

Ready-to-use analytics tables can be connected to Looker Studio, enabling real-time revenue and order analysis.

---

## BigQuery

Sample queries transform raw data into staging and analytics tables, enabling flexible and dynamic reporting.

---



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

## Business Requirements

At QuickCart, the data team needs:

1. **Hourly Ingestion** — automating the pipeline to process orders every hour.
2. **End-to-End Automation** — no manual steps; everything runs from scripts.
3. **Data Quality** — reject incomplete or incorrect data before analytics.
4. **Real-Time Revenue Insights** — instant visibility into hourly sales.
5. **Audit Trail** — log each pipeline run, ensuring full traceability.

---

## Outcomes

- Built a fully automated ETL pipeline from scratch.
- Generated 50,000+ realistic order records.
- Loaded, transformed, and prepared data for analytics.
- Created a scalable architecture for hourly e-commerce data processing.

 
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
