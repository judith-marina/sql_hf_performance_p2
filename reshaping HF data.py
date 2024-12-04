import pandas as pd

hedge_fund_data = pd.read_csv('C:\\Users\\Hp\\Documents\\HF data.csv')

print(hedge_fund_data.head())

reshaped_data = hedge_fund_data.melt(id_vars=["date"], 
                                      var_name="StrategyName", 
                                      value_name="MonthlyReturn")

reshaped_data.to_csv('C:\\Users\\Hp\\Documents\\reshaped_data.csv', index=False)

pip install pyodbc pandas

import pandas as pd
import pyodbc

# Step 1: Load reshaped hedge fund data
file_path = 'c:\\Users\\Hp\\Documents\\reshaped_data.csv'  # Replace with the path to your CSV file
data = pd.read_csv(file_path)

# Step 2: Connect to SQL Server
connection = pyodbc.connect(
    "Driver={ODBC Driver 17 for SQL Server};"  # Ensure the driver is installed
    "Server=YOUR_SERVER_NAME;"  # Replace with your SQL Server name or localhost
    "Database=YOUR_DATABASE_NAME;"  # Replace with your database name
    "Trusted_Connection=yes;"  # Use for Windows Authentication
    # Uncomment if using username/password authentication
    # "UID=YOUR_USERNAME;PWD=YOUR_PASSWORD;"
)

cursor = connection.cursor()

# Step 3: Create Tables
cursor.execute("""
CREATE TABLE IF NOT EXISTS FundStrategies (
    StrategyID INT PRIMARY KEY IDENTITY(1,1),
    StrategyName NVARCHAR(255) NOT NULL
);
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS FundPerformance (
    PerformanceID INT PRIMARY KEY IDENTITY(1,1),
    StrategyID INT NOT NULL,
    PerformanceDate DATE NOT NULL,
    MonthlyReturn FLOAT,
    FOREIGN KEY (StrategyID) REFERENCES FundStrategies(StrategyID)
);
""")
connection.commit()

# Step 4: Insert Strategy Metadata
strategy_names = data['StrategyName'].unique()
for strategy in strategy_names:
    cursor.execute("INSERT INTO FundStrategies (StrategyName) VALUES (?)", strategy)
connection.commit()

# Step 5: Get StrategyID Mapping
cursor.execute("SELECT StrategyID, StrategyName FROM FundStrategies")
strategy_mapping = {row[1]: row[0] for row in cursor.fetchall()}

# Step 6: Insert Performance Data
for _, row in data.iterrows():
    cursor.execute("""
    INSERT INTO FundPerformance (StrategyID, PerformanceDate, MonthlyReturn)
    VALUES (?, ?, ?)
    """, strategy_mapping[row['StrategyName']], row['date'], row['MonthlyReturn'])
connection.commit()

# Step 7: Close Connection
cursor.close()
connection.close()
print("Data successfully loaded into SQL Server!")

print(strategy_mapping)

# Step 1: Insert strategy names into FundStrategies table
strategy_names = data['StrategyName'].unique()
for strategy in strategy_names:
    cursor.execute("INSERT INTO FundStrategies (StrategyName) VALUES (?)", strategy)
connection.commit()

# Step 2: Get StrategyID mapping after inserting the strategies
cursor.execute("SELECT StrategyID, StrategyName FROM FundStrategies")
strategy_mapping = {row[1]: row[0] for row in cursor.fetchall()}

# Step 3: Print the mapping to confirm it's correct
print(strategy_mapping)

import pyodbc

# Step 1: Reconnect to SQL Server
connection = pyodbc.connect(
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=YOUR_SERVER_NAME;"  # Replace with your SQL Server name or localhost
    "Database=YOUR_DATABASE_NAME;"  # Replace with your database name
    "Trusted_Connection=yes;"  # Use for Windows Authentication
)
cursor = connection.cursor()
