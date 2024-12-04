### Hedge Fund Performance Analysis Project  

---

## Project Overview  
This project provides a comprehensive analysis of hedge fund strategies by managing, analyzing, and interpreting their performance data. It demonstrates the end-to-end process of data preparation, transformation, and analysis by integrating data cleaning in Excel, reshaping in Python, and advanced querying in SQL.

The project highlights expertise in data preprocessing, data manipulation, data modeling, and advanced querying techniques, delivering actionable insights into hedge fund performance. By effectively using tools and methodologies, the project explores performance trends, compares strategies, and uncovers seasonal and volatility patterns, empowering informed decision-making for portfolio management and strategy evaluation.

---

## Workflow and Features  

### 1. **Data Cleaning in Excel**  
- Removed duplicate and inconsistent entries.  
- Standardized formatting for dates, numerical fields, and strategy names.  
- Ensured data integrity and compatibility for further processing.  

### 2. **Data Reshaping in Python**  
- Leveraged **Python** to transform data from a wide format to a long format, preparing it for database ingestion.  
- Steps performed:  
  - Loaded Excel data into Python using **Pandas**.  
  - Unpivoted columns (wide to long transformation) to align performance metrics with corresponding strategies and dates.  
  - Validated reshaped data for correctness and consistency.  
- Key Libraries:  
  - **Pandas** for data manipulation.  
  - **NumPy** for numerical checks.  

### 3. **Data Management and Analysis in SQL**  
- Created a relational database schema to manage hedge fund data efficiently.  
  - Tables created:  
    - `FundStrategies`: Stores metadata for each strategy.  
    - `FundPerformance`: Stores monthly returns for each strategy.  
  - Leveraged **PostgreSQL** for database operations.  
- Imported reshaped data from Python into the database.  

### 4. **SQL Queries for Analysis**  
Performed detailed analysis with SQL, including:  
- **Aggregations**:  
  - Calculated average monthly and yearly returns for each strategy.  
  - Identified the most volatile strategies using standard deviation.  
  - Found cumulative returns and rolling 3-month averages.  
- **Trend Analysis**:  
  - Seasonal performance trends (monthly and yearly).  
  - Strategy performance for specific months (e.g., August).  
- **Anomalies Detection**:  
  - Identified months with exceptionally high or low returns.  
- **Rankings**:  
  - Ranked strategies based on total returns over the dataset's timeframe.  
- **Performance Categorization**:  
  - Added a performance category based on monthly returns (High, Moderate, Low).  
- **Volatility and Risk**:  
  - Compared strategies based on volatility.  
  - Identified consistently positive-return strategies.  

### 5. **Outputs**  
- Generated actionable insights into the performance and risk profile of various hedge fund strategies.  
- Highlighted best- and worst-performing strategies, along with their trends over time.  

---

## Tools and Technologies  
- **Excel**: Data cleaning and initial formatting.  
- **Python**: Data reshaping and validation.  
  - Libraries: `Pandas`, `NumPy`.  
- **SQL (PostgreSQL)**: Database management and advanced querying.  

---
