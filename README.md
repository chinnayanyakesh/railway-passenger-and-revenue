# Railway Passengers and Revenue Analyst 🚆📊

A data analytics project focused on **Indian Railways passenger traffic, passenger classes, railway-zone performance, and revenue analysis for 2019–2024**.

The project combines **MySQL + SQL + Microsoft Power BI** to build a structured railway database, validate relationships and data quality, and present the results through interactive dashboards.

---

## 📌 Project Title

**Railway Passengers and Revenue Analyst**

## 🏭 Industry

**Railway Transportation & Data Analytics**

---

## 📖 Project Overview

The **Railway Passengers and Revenue Analyst** project analyzes railway passenger and financial performance using historical data from **2019 to 2024**.

The project covers:

- Passenger traffic and originating passengers
- Passenger kilometres
- Passenger earnings
- Passenger classes
- Railway-zone performance
- Passenger revenue
- Freight revenue
- Total revenue
- Revenue trends
- Train and route information
- Train schedules
- Station information

The data is stored and validated in **MySQL**, analyzed using **SQL**, and visualized in **Power BI**.

---

## 🎯 Project Objectives

- Analyze railway passenger trends from 2019–2024.
- Measure total passenger traffic and passenger kilometres.
- Analyze passenger performance by passenger class.
- Compare railway-zone passenger performance.
- Analyze passenger, freight, and total revenue.
- Identify yearly revenue trends.
- Compare revenue performance across railway zones.
- Validate primary-key and foreign-key relationships.
- Check duplicate and invalid records using SQL.
- Build interactive Power BI dashboards.
- Present railway performance through business-focused KPIs and visualizations.

---

## 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **MySQL** | Database creation, storage and validation |
| **SQL** | Data analysis and data-quality checks |
| **Microsoft Power BI** | Dashboard development and visualization |
| **Power Query** | Data preparation/transformation |
| **DAX** | KPI and analytical calculations |
| **CSV** | Source data format |
| **GitHub** | Repository and project sharing |

---

## 📂 Dataset Description

The repository contains **10 CSV files** divided into dimension and fact data.

### Dimension Tables

| File | Description | Rows* |
|---|---|---:|
| `dim_zone.csv` | Railway-zone master data | 5 |
| `dim_station.csv` | Station information | 112 |
| `dim_train.csv` | Train master information | 2,500 |
| `dim_passenger_class.csv` | Passenger class master data | 5 |

### Fact Tables

| File | Description | Rows* |
|---|---|---:|
| `fact_revenue.csv` | Railway revenue information | 6 |
| `fact_passenger_class.csv` | Passenger performance by class and year | 30 |
| `fact_passenger_traffic.csv` | Passenger traffic by year, zone and category | 96 |
| `fact_zone_performance.csv` | Zone-level passenger and revenue performance | 96 |
| `fact_route.csv` | Train route information | 2,500 |
| `fact_train_schedule.csv` | Train schedule and station sequence information | 12,000 |

\*Row counts are based on the uploaded CSV files excluding header rows.

---

## 🗄️ Database Structure

The MySQL database is named:

```sql
railway
```

### Main tables

```text
dim_zone
dim_station
dim_train
dim_passenger_class

fact_revenue
fact_passenger_class
fact_passenger_traffic
fact_zone_performance
fact_route
fact_train_schedule
```

The SQL script creates primary keys, foreign-key relationships, unique constraints, and indexes for the railway data model.

---

## 🔍 SQL Analysis

SQL was used for both database creation and data validation.

### Database Operations

- Created the `railway` database.
- Created dimension and fact tables.
- Defined primary keys.
- Defined foreign-key relationships.
- Created indexes.
- Loaded CSV data.
- Checked table structures.
- Checked row counts.

### Data Validation

The SQL analysis includes checks for:

- Invalid Train IDs
- Invalid Station Codes
- Invalid Railway Zones
- Invalid Passenger Classes
- Duplicate Train IDs
- Duplicate Train Numbers
- Duplicate Zone Codes
- Duplicate route relationships
- Missing values
- Foreign-key relationships

Example:

```sql
SELECT COUNT(*) AS Invalid_Train_IDs
FROM fact_route r
LEFT JOIN dim_train t
    ON r.Train_ID = t.Train_ID
WHERE t.Train_ID IS NULL;
```

---

## 📊 Power BI Dashboards

The Power BI report contains **3 dashboard pages**.

### 1. Railway Performance Overview

This dashboard provides an overall view of railway passenger performance.

#### Main KPIs

- Total Passengers — **285M**
- Total Passenger KM — **127.08bn**
- Total Earnings — **33.81bn**
- Average Fare — **118.59**

#### Main Visuals

- Passenger Trend by Year
- Revenue by Railway Zone
- Passenger Traffic by Railway Zone
- Passengers by Class
- Railway Zone filter
- Year filter
- Passenger Class filter

---

### 2. Passenger Analysis Dashboard

This dashboard focuses on passenger trends, passenger classes, and traffic patterns.

#### Main KPIs

- Total Passengers — **285M**
- Total Passenger KM — **127.08bn**
- Total Revenue — **33.81bn**
- Average Fare — **3.56K**

#### Main Visuals

- Passenger Trend by Year
- Passenger Share by Class
- Passenger Trend by Passenger Class
- City map
- Year filter
- Passenger Class filter
- Zone-related filtering

---

### 3. Revenue Analysis Dashboard

This dashboard focuses on railway financial performance from **2019–2024**.

#### Main KPIs

- Total Revenue — **1.94T**
- Passenger Revenue — **227.19bn**
- Freight Revenue — **1.72T**
- Average Passenger Revenue — **2.37bn**
- Revenue Growth % — **-13.1%**

#### Main Visuals

- Total Revenue Trend | 2019–2024
- Passenger vs Freight Revenue
- Passenger & Freight Revenue vs Total Revenue
- Total Revenue by Railway Zone
- Total Revenue gauge
- Year slicer
- Railway Zone slicer

---

## 📌 Key KPIs

| KPI | Value |
|---|---:|
| Total Passengers | **285M** |
| Total Passenger KM | **127.08bn** |
| Total Earnings | **33.81bn** |
| Average Fare | **118.59** |
| Total Revenue | **1.94T** |
| Passenger Revenue | **227.19bn** |
| Freight Revenue | **1.72T** |
| Average Passenger Revenue | **2.37bn** |
| Revenue Growth | **-13.1%** |

---

## 💡 Key Insights

Based on the Power BI dashboards included in this project:

1. The project analyzes railway performance across **2019–2024**.
2. Total passenger volume shown in the overview dashboard is approximately **285M**.
3. Total passenger kilometres are approximately **127.08bn**.
4. Total earnings shown in the overview are approximately **33.81bn**.
5. Freight revenue is substantially higher than passenger revenue in the Revenue Analysis dashboard.
6. Total revenue shown in the Revenue Analysis dashboard is approximately **1.94T**.
7. Freight revenue contributes approximately **1.72T**, compared with approximately **227.19bn** from passenger revenue.
8. Revenue varies considerably across railway zones.
9. Passenger traffic and passenger-class distributions can be compared using the interactive Power BI visuals.
10. The revenue dashboard shows a **-13.1% Revenue Growth %** KPI for the measure used in the report.

---

## 🔄 Project Workflow

```text
CSV Dataset
     ↓
Data Understanding
     ↓
MySQL Database Creation
     ↓
Table Creation
     ↓
CSV Data Loading
     ↓
SQL Data Validation
     ↓
SQL Analysis
     ↓
Power BI Data Connection
     ↓
Data Modeling
     ↓
DAX Measures / KPIs
     ↓
Dashboard Development
     ↓
Data Visualization
     ↓
Business Insights
```

---

## 📁 Repository Structure

```text
Railway-Passengers-and-Revenue-Analyst/
│
├── Dataset/
│   ├── dim_passenger_class.csv
│   ├── dim_station.csv
│   ├── dim_train.csv
│   ├── dim_zone.csv
│   ├── fact_passenger_class.csv
│   ├── fact_passenger_traffic.csv
│   ├── fact_revenue.csv
│   ├── fact_route.csv
│   ├── fact_train_schedule.csv
│   └── fact_zone_performance.csv
│
├── Documentation/
│
├── Power BI/
│   └── Railway Passenger.pbix
│
├── Screenshot/
│   ├── Railway Performence Overview.png
│   ├── Passenger Analyst Dashboard.png
│   └── Revenue Analysis Dashboard.png
│
├── SQL/
│   └── Railway_Passenger.sql
│
└── README.md
```

---

## 🖼️ Dashboard Screenshots

### Railway Performance Overview

<img width="870" height="490" alt="Railway Performance Overview" src="https://github.com/user-attachments/assets/d01d51f1-fad2-4c1e-8097-2b4370c3d8f7" />


### Passenger Analysis Dashboard

<img width="872" height="490" alt="Passenger Analyst Dashboard" src="https://github.com/user-attachments/assets/d0850abc-4b9d-42c1-a059-c15a1cd186c7" />


### Revenue Analysis Dashboard

<img width="872" height="492" alt="Revenue Analysis Dashboard" src="https://github.com/user-attachments/assets/9ff279ec-c5fc-4edc-92d7-5a5cf86e7c02" />


---

## ▶️ How to Run the Project

### Step 1 — Clone the Repository

```bash
git clone <your-github-repository-url>
cd Railway-Passengers-and-Revenue-Analyst
```

### Step 2 — Prepare MySQL

Install **MySQL Server** and **MySQL Workbench**.

Open MySQL Workbench and create/use the railway database:

```sql
CREATE DATABASE railway;
USE railway;
```

### Step 3 — Run the SQL Script

Open:

```text
SQL/Railway_Passenger.sql
```

Run the database/table creation statements.

> **Important:** The SQL script contains local CSV file paths. Update the `LOAD DATA LOCAL INFILE` paths to match the location of the `Dataset` folder on your computer before running those data-loading statements.

For example:

```sql
LOAD DATA LOCAL INFILE 'YOUR_LOCAL_PATH/fact_train_schedule.csv'
INTO TABLE fact_train_schedule;
```

### Step 4 — Load the CSV Data

The CSV files are available inside:

```text
Dataset/
```

Load the required files into their corresponding MySQL tables.

### Step 5 — Open Power BI

Open:

```text
Power BI/Railway Passenger.pbix
```

### Step 6 — Update the Data Source

If Power BI asks for database credentials or the MySQL server connection:

1. Select the MySQL connection.
2. Enter your MySQL server details.
3. Select the `railway` database.
4. Confirm the tables.
5. Refresh the dataset.

### Step 7 — Explore the Dashboards

Navigate through the three Power BI pages:

- Railway Performance Overview
- Passenger Analysis Dashboard
- Revenue Analysis

Use the available year, railway-zone, and passenger-class filters to interact with the report.

---

## 📈 Project Deliverables

This repository contains:

- ✅ Railway CSV datasets
- ✅ MySQL SQL script
- ✅ Power BI dashboard file
- ✅ Dashboard screenshots
- ✅ Project documentation
- ✅ GitHub README

---

## 👨‍💻 Author

**Yakesh Chinnayan**

**Project:** Railway Passengers and Revenue Analyst

**Focus:** Data Analytics | SQL | Power BI | Data Visualization

---

## ⭐ Skills Demonstrated

- SQL
- MySQL
- Data Cleaning & Validation
- Relational Database Design
- Data Modeling
- Power BI
- DAX
- Power Query
- KPI Development
- Data Visualization
- Business Intelligence
- Dashboard Development
- Data Analysis

---

## 📜 License

This project is intended for **educational, portfolio, and demonstration purposes**.

