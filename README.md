📘 Banggood Product Scraping & Analytics Pipeline

A complete end-to-end Data Engineering project that extracts product data from Banggood.com using Selenium, cleans and transforms it with pandas, loads it into SQL Server, and performs analytical SQL queries and Python visualizations.

This project demonstrates real-world ETL workflows, data cleaning, currency normalization, database integration, and analytical reporting.

flowchart LR
    A[Banggood Category Pages] --> B[Python + Selenium Scraper]
    B --> C[Raw DataFrame]
    C --> D[Cleaning and Transformation (pandas)]
    D --> E[Cleaned CSV File]
    E --> F[SQL Server Database - BanggoodDB]
    F --> G[SQL Analytical Queries]
    D --> H[Python Visualizations - Charts]
    G --> I[Final Report]
    H --> I

    <img width="1192" height="464" alt="image" src="https://github.com/user-attachments/assets/cb65f24c-8d82-441f-bc68-9fae31d8b339" />


    /banggood-analysis/
│
├── data/
│   ├── banggood_raw.csv                  # optional raw dump
│   └── banggood_cleaned_with_usd.csv     # final cleaned dataset
│
├── notebooks/
│   ├── 01_scraping_banggood.ipynb
│   ├── 02_cleaning_and_enrichment.ipynb
│   ├── 03_python_analysis.ipynb
│   └── 04_sql_queries_reference.ipynb
│
├── sql/
│   ├── create_table.sql
│   └── analysis_queries.sql
│
├── images/
│   └── architecture_diagram.png
│
├── README.md

📦 Technologies Used
Python Libraries

Selenium

pandas

pyodbc

matplotlib / seaborn

regex (re)

Tools

Jupyter Notebook

SQL Server (Windows Authentication)

Chrome WebDriver (headless)

🕸️ Part 1 — Web Scraping

The scraper uses Selenium WebDriver to load multiple Banggood category pages:
CATEGORY_URLS = [
    "https://www.banggood.com/Wholesale-Sports-Camera-and-Accessories-ca-2345.html",
    "https://www.banggood.com/Wholesale-Microphones-ca-2352.html",
    "https://www.banggood.com/Wholesale-RC-Drones-ca-7002.html",
    "https://www.banggood.com/Wholesale-3D-Printer-Accessories-ca-2005.html"
]
Extraction Includes:

Product name

Product URL

Raw price

Price currency detection

Rating text

Review count text

Pagination is handled automatically, and the script stops when no more product cards are found.

🧹 Part 2 — Data Cleaning & Transformation

Cleaning performed using pandas:

✔ Currency Normalization

Detect USD / GBP

Convert GBP → USD using fixed rate (1 GBP ≈ 1.25 USD)

New fields:
price_raw
PRICE_USD
currency
converted_from_foreign
✔ Ratings

Parsed values like "4.8" or "4.8 out of 5" into numeric rating.

✔ Reviews

Extracted numeric review counts from strings like "125 Reviews", "70 Sold", etc.

✔ Final Cleaned Dataset

Exported to:
data/banggood_cleaned_with_usd.csv

🗄️ Part 3 — SQL Server Storage
CREATE DATABASE BanggoodDB;

Table Schema:
CREATE TABLE dbo.BanggoodProducts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(255),
    category_url VARCHAR(500),
    product_name VARCHAR(MAX),
    price_raw VARCHAR(50),
    PRICE_USD FLOAT,
    rating_raw VARCHAR(50),
    rating FLOAT,
    reviews_raw VARCHAR(50),
    reviews_count INT,
    product_url VARCHAR(500),
    currency VARCHAR(20),
    converted_from_foreign BIT
);

Python → SQL Insert

Using pyodbc, the cleaned DataFrame is inserted into SQL Server.

📊 Part 4 — Analytical SQL Queries

Stored in sql/analysis_queries.sql.

Example Queries:

✔ Average price per category
✔ Average rating per category
✔ Review coverage %
✔ Top 5 reviewed products per category
✔ Best value products (rating × log(reviews) / price)

These were used to generate insights for the final report.

📈 Part 5 — Python Visualizations

Notebooks generate:

Bar chart: products per category

Bar chart: average price per category

Scatter plot: rating vs price

Distribution of review counts

These help validate SQL findings visually.

📝 Part 6 — Final Insights
Key Findings:

Large price differences exist between categories (RC Drones highest).

Review coverage is uneven—only some products receive significant engagement.

Best-value products balance price, rating, and popularity.

Converting all prices to USD allowed fair comparison across categories.

Recommendations:

Promote low-review products for better engagement.

Add discount history, stock levels, and seller metadata in future versions.

Automate scraping with Airflow or a cloud scheduler.

Build a Power BI dashboard for continuous monitoring.

A full written report is included separately.

⚙️ Installation
pip install -r requirements.txt

If Selenium requires ChromeDriver:

from webdriver_manager.chrome import ChromeDriverManager

▶️ How to Run the Pipeline

Run 01_scraping_banggood.ipynb

Run 02_cleaning_and_enrichment.ipynb

Load CSV into SQL Server using the provided SQL file

Execute SQL queries from analysis_queries.sql

View visualizations in 03_python_analysis.ipynb

📄 License

This project is for educational purposes only. No commercial use of Banggood data is permitted.

🤝 Contributions

Pull requests are welcome!


