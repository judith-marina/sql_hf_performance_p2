### Hedge Fund Strategy Performance Analysis Project

---

## Project Overview  
This project provides a comprehensive analysis of hedge fund strategies by managing and analyzing their performance data. It uses SQL to create and manipulate tables, import raw data, perform calculations, and generate insights on fund strategy performance over time. 

The project involves key data operations, such as **data modeling**, **data manipulation**, and **advanced querying techniques**. Outputs include performance trends, strategy comparisons, seasonal performance patterns, volatility analysis, and more. This repository is structured to enable efficient exploration and reporting of hedge fund strategies.

---

## Key Features  

### 1. **Data Modeling**  
- **Tables Created:**
  - `FundStrategies`: Stores metadata about hedge fund strategies.  
  - `FundPerformance`: Stores historical performance data associated with strategies.  
  - `raw_data`: Temporary table to load raw CSV data for processing.  
  - `fsfp`: Consolidated table created as a subquery to simplify performance analysis.  

---

### 2. **Data Manipulation**  
- Imported raw data from a CSV file and mapped it to normalized database tables using `INSERT` and `JOIN` queries.  
- Performed transformations such as:  
  - Adding metadata links between fund strategies and their performance data.  
  - Filtering data for specific strategies, timeframes, and thresholds.  
  - Categorizing monthly returns into performance levels.  

---

### 3. **Advanced Analytics**  
- **Trend Analysis:**
  - Calculated average monthly and yearly returns for each strategy.  
  - Identified seasonal trends and performance categories (e.g., high, moderate, low).  

- **Volatility and Risk Assessment:**
  - Found the most volatile strategy based on standard deviation of returns.  
  - Detected anomalies in returns above or below specified thresholds.  

- **Cumulative and Rolling Metrics:**
  - Calculated cumulative returns for each strategy over time.  
  - Generated rolling 3-month average returns to smooth short-term performance trends.  

- **Performance Rankings:**
  - Ranked strategies based on total returns over time.  

- **Historical Insights:**
  - Filtered and analyzed returns during specific timeframes (e.g., 2020).  
  - Compared returns across strategies by year.  

---

## Key SQL Commands  
Here’s an overview of SQL operations used in the project:  

1. **Data Definition (DDL)**  
   - `CREATE TABLE`, `DROP TABLE`: To define and clean up database schema.  

2. **Data Manipulation (DML)**  
   - `INSERT INTO`, `SELECT`, `UPDATE`, `DELETE`: To handle and process data effectively.  
   - `COPY FROM`: For importing raw data from CSV files.  

3. **Data Querying**  
   - `JOIN`: To combine data across tables.  
   - `GROUP BY`, `ORDER BY`: For summarization and sorting.  
   - `HAVING`, `CASE`: For conditional filtering and creating derived categories.  
   - Window Functions (`SUM() OVER`, `RANK()`): To compute rolling and ranked metrics.  

4. **Data Aggregation**  
   - `AVG`, `STDDEV`, `SUM`: For statistical and financial calculations.  

---

## Project Workflow  

1. **Setup:**  
   - Define database schema with normalized tables (`FundStrategies`, `FundPerformance`, `raw_data`).  
   - Clean data and import into the database.  

2. **Transformation:**  
   - Map raw data to main tables.  
   - Consolidate performance data into a single table (`fsfp`) for streamlined analysis.  

3. **Analysis:**  
   - Perform data exploration for key insights, trends, and metrics.  
   - Filter data for specific strategies or timeframes.  

4. **Reporting:**  
   - Generate outputs for:
     - Yearly and monthly averages.
     - Performance categories.
     - Strategy rankings and anomalies.

---

