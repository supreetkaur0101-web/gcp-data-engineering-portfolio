# RetailPulse Analytics Pipeline

## Overview

Production-style retail analytics pipeline built on Google Cloud Platform using:

- Cloud Storage
- BigQuery
- SQL transformations
- BigQuery Data Transfer Service
- Looker Studio dashboards

The project uses the Olist Brazilian E-Commerce dataset containing 100k+ real-world retail orders.

---

## Architecture

CSV Files → Cloud Storage → BigQuery Raw Layer → SQL Transformations → Analytics Layer → Looker Studio Dashboard

---

## Technologies Used

- Google Cloud Platform (GCP)
- BigQuery
- Cloud Storage
- SQL
- Looker Studio
- BigQuery Data Transfer Service

---

## Business Problem

A retail company receives daily CSV exports and requires automated reporting dashboards for executive analytics and KPI monitoring.

---

## Features

- Automated CSV ingestion
- Raw + analytics data layers
- SQL transformations
- KPI dashboards
- Scheduled ingestion workflows
- Production-style architecture

---

## Dataset

<a href="https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce">Brazilian E-Commerce Public Dataset by Olist</a>

---

## Dashboard

<img width="1229" height="823" alt="image" src="https://github.com/user-attachments/assets/5a0367a4-7dfb-4a36-990b-eeba861038c5" />


---

## 🏗️ Architecture
 
```
┌─────────────────────────────────────────────────────────────────┐
│                    RetailPulse Architecture                      │
│                                                                  │
│  [CSV Files]                                                     │
│      │                                                           │
│      ▼                                                           │
│  ┌─────────────────┐     Manual Upload                          │
│  │  Cloud Storage  │ ◄── (or scheduled via Transfer Service)    │
│  │  (Raw Data Lake)│                                             │
│  └────────┬────────┘                                             │
│           │  BigQuery Data Transfer / Load Job                   │
│           ▼                                                       │
│  ┌─────────────────┐                                             │
│  │    BigQuery     │                                             │
│  │  ┌───────────┐  │                                             │
│  │  │raw_orders │  │  ← Raw table (ingestion layer)             │
│  │  └─────┬─────┘  │                                             │
│  │        │ SQL    │                                             │
│  │  ┌─────▼─────┐  │                                             │
│  │  │sales_agg  │  │  ← Transformed table (analytics layer)    │
│  │  └───────────┘  │                                             │
│  └────────┬────────┘                                             │
│           │                                                       │
│           ▼                                                       │
│  ┌─────────────────┐                                             │
│  │  Looker Studio  │  ← Dashboard (Business layer)              │
│  │   (Dashboard)   │                                             │
│  └─────────────────┘                                             │
└─────────────────────────────────────────────────────────────────┘
```
---

## Production Issue Resolved

During implementation, automated ingestion initially failed due to CSV header parsing conflicts.

### Resolution

- Configured:
  - Header rows to skip = 1
  - Append write mode
  - Proper schema alignment

---

## Outcomes

- Built end-to-end analytics pipeline
- Processed 100k+ retail records
- Created executive dashboards
- Implemented scheduled ingestion workflows
