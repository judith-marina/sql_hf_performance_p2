-- Table for strategy metadata
CREATE TABLE FundStrategies (
    StrategyID SERIAL PRIMARY KEY,
    StrategyName TEXT NOT NULL,
    Description TEXT
);

-- Table for fund performance data
CREATE TABLE FundPerformance (
    PerformanceID SERIAL PRIMARY KEY,
    StrategyID INT NOT NULL REFERENCES FundStrategies(StrategyID),
    PerformanceDate DATE NOT NULL,
    MonthlyReturn NUMERIC
);

SELECT * FROM FundStrategies;
SELECT * FROM FundPerformance;  

INSERT INTO FundStrategies (StrategyName) 
VALUES 
('Convertible_Arbitrage'),
('CTA_Global'),
('Distressed_Securities'),
('Emerging_Markets'),
('Equity_Market_Neutral'),
('Event_Driven'),
('Fixed_Income_Arbitrage'),
('Global_Macro'),
('Long_Short_Equity'),
('Merger_Arbitrage'),
('Relative_Value'),
('Short_Selling'),
('Funds_of_Funds');


--Creating another table to insert data
CREATE TABLE raw_data (
    StrategyName TEXT,
    PerformanceDate DATE,
    MonthlyReturn FLOAT
);

SELECT * FROM TABLE public.raw_data;

copy raw_data (StrategyName, PerformanceDate, MonthlyReturn )
FROM 'C:\\Users\\Hp\\Documents\\reshaped_data.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*) FROM public.raw_data;

INSERT INTO FundPerformance (StrategyID, PerformanceDate, MonthlyReturn)
SELECT fs.StrategyID, rd.PerformanceDate, rd.MonthlyReturn
FROM public.raw_data rd
JOIN FundStrategies fs ON rd.StrategyName = fs.StrategyName;

SELECT * FROM FundPerformance;

DROP TABLE public.raw_data;


--Join Tables to Analyze Data
SELECT 
    fp.PerformanceID,
    fs.StrategyName,
    fp.PerformanceDate,
    fp.MonthlyReturn
FROM 
    FundPerformance fp
JOIN 
    FundStrategies fs
ON 
    fp.StrategyID = fs.StrategyID
ORDER BY 
    fp.PerformanceDate;


--Save the above table as subquery

CREATE TABLE fsfp AS 
     (
	 SELECT 
    fp.PerformanceID,
    fs.StrategyName,
    fp.PerformanceDate,
    fp.MonthlyReturn
FROM 
    FundPerformance fp
JOIN 
    FundStrategies fs
ON 
    fp.StrategyID = fs.StrategyID
ORDER BY 
    fp.PerformanceDate
	);

SELECT * FROM fsfp;

--Filter data for specific strategies

--Convertible_Arbitrage
SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Convertible_Arbitrage';

--CTA_Global
SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'CTA_Global';

--Distressed_Securities
SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Distressed_Securities';

--Emerging_Markets
SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Emerging_Markets';

--Equity_Market_Neutral
SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Equity_Market_Neutral';

--Event_Driven
SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Event_Driven';

 --Fixed_Income_Arbitrage
 SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Fixed_Income_Arbitrage';

 --Global_Macro
 SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Global_Macro';

 --Long_Short_Equity
 SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Long_Short_Equity';

 --Merger_Arbitrage
 SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Merger_Arbitrage';

 --Relative_Value
 SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Relative_Value';

 --Short_Selling
 SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Short_Selling';

 --Funds_of_Funds
 SELECT PerformanceDate, StrategyName, MonthlyReturn
 FROM fsfp
 WHERE StrategyName = 'Funds_of_Funds';


--To Calculate the Average of MonthlyReturn according to each strategy.

SELECT 
    StrategyName,
    AVG(MonthlyReturn) AS AvgMonthlyReturn
FROM 
    fsfp
GROUP BY 
    StrategyName
ORDER BY 
    StrategyName;

--To Identify the best month for returns

SELECT 
StrategyName, PerformanceDate, MonthlyReturn
FROM fsfp
ORDER BY MonthlyReturn DESC
limit 1
;

SELECT 
StrategyName, PerformanceDate, MonthlyReturn
FROM fsfp
ORDER BY MonthlyReturn 
limit 1
;

--To check the performance for a single month (August)
SELECT 
    StrategyName, 
    PerformanceDate, MonthlyReturn
FROM 
    fsfp
WHERE 
    EXTRACT(MONTH FROM PerformanceDate) = 8  
    AND EXTRACT(YEAR FROM PerformanceDate) IS NOT NULL  
GROUP BY 
    StrategyName, PerformanceDate, MonthlyReturn
ORDER BY 
    StrategyName DESC;


--To find the average of each month in every year for each strategy 
SELECT 
    StrategyName, 
    EXTRACT(YEAR FROM fsfp.PerformanceDate) AS Year,
    EXTRACT(MONTH FROM fsfp.PerformanceDate) AS Month,
    AVG(MonthlyReturn) AS AvgMonthlyReturn
FROM 
    fsfp
GROUP BY 
    StrategyName,  
    EXTRACT(YEAR FROM fsfp.PerformanceDate),
    EXTRACT(MONTH FROM fsfp.PerformanceDate)
ORDER BY 
    Year, Month;

--Calculate Yearly Average Returns for Each Strategy
SELECT 
    StrategyName,
    EXTRACT(YEAR FROM PerformanceDate) AS Year,
    AVG(MonthlyReturn) AS AvgYearlyReturn
FROM 
    fsfp
GROUP BY 
    StrategyName, EXTRACT(YEAR FROM PerformanceDate)
ORDER BY 
    StrategyName, Year;
	

--To find the cumulative returns for each strategy
SELECT 
    PerformanceID,
    StrategyName,
    PerformanceDate,
    MonthlyReturn,
    SUM(MonthlyReturn) OVER (PARTITION BY StrategyName ORDER BY PerformanceDate) AS CumulativeReturn
FROM 
    fsfp
ORDER BY 
    StrategyName, PerformanceDate;

--Filter by date range
SELECT 
	PerformanceID,
    StrategyName,
    PerformanceDate,
    MonthlyReturn
FROM fsfp
WHERE PerformanceDate BETWEEN '2008-01-01' AND '2008-12-31';


--2. Identify Strategies with Consistently Positive Returns
SELECT 
    StrategyName, MonthlyReturn
FROM 
    fsfp
GROUP BY 
    StrategyName, MonthlyReturn
HAVING 
    MIN(MonthlyReturn) > 0
ORDER BY 
    StrategyName;

--3. Calculate Rolling 3-Month Average Returns
SELECT 
    PerformanceDate,
    StrategyName,
    MonthlyReturn,
    AVG(MonthlyReturn) OVER (
        PARTITION BY StrategyName 
        ORDER BY PerformanceDate 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Rolling3MonthAvg
FROM 
    fsfp
ORDER BY 
    StrategyName, PerformanceDate;
	
--4. Find the Most Volatile Strategy (Highest Standard Deviation)
SELECT 
    StrategyName,
    STDDEV(MonthlyReturn) AS ReturnVolatility
FROM 
    fsfp
GROUP BY 
    StrategyName
ORDER BY 
    ReturnVolatility DESC
LIMIT 1;

--5. Detect Anomalies: Months with Returns Above/Below Thresholds
SELECT 
    PerformanceDate,
    StrategyName,
    MonthlyReturn
FROM 
    fsfp
WHERE 
    MonthlyReturn > 0.1 OR MonthlyReturn < -0.1
ORDER BY 
    MonthlyReturn DESC;

--6. Rank Strategies by Total Returns Over Time
SELECT 
    StrategyName,
    SUM(MonthlyReturn) AS TotalReturn,
    RANK() OVER (ORDER BY SUM(MonthlyReturn) DESC) AS StrategyRank
FROM 
    fsfp
GROUP BY 
    StrategyName
ORDER BY 
    StrategyRank;

--7. Analyze Seasonal Performance Trends
SELECT 
    EXTRACT(MONTH FROM PerformanceDate) AS Month,
    AVG(MonthlyReturn) AS AvgMonthlyReturn
FROM 
    fsfp
GROUP BY 
    EXTRACT(MONTH FROM PerformanceDate)
ORDER BY 
    Month;

--8. Filter Data for Specific Timeframes or Strategies
--Example A: Filter for Returns in the Year 2020
SELECT 
    PerformanceDate,
    StrategyName,
    MonthlyReturn
FROM 
    fsfp
WHERE 
    EXTRACT(YEAR FROM PerformanceDate) = 2020
ORDER BY 
    PerformanceDate;

--Example B: Filter for a Specific Strategy (e.g., "Convertible Arbitrage")
SELECT 
    PerformanceDate,
    MonthlyReturn
FROM 
    fsfp
WHERE 
    StrategyName = 'Convertible Arbitrage'
ORDER BY 
    PerformanceDate;

--9. Compare Returns Across Strategies by Year
SELECT 
    EXTRACT(YEAR FROM PerformanceDate) AS Year,
    StrategyName,
    SUM(MonthlyReturn) AS TotalYearlyReturn
FROM 
    fsfp
GROUP BY 
    Year, StrategyName
ORDER BY 
    Year, StrategyName;

--10. Add a Performance Category
SELECT 
    PerformanceDate,
    StrategyName,
    MonthlyReturn,
    CASE 
        WHEN MonthlyReturn > 0.05 THEN 'High Performance'
        WHEN MonthlyReturn BETWEEN 0 AND 0.05 THEN 'Moderate Performance'
        ELSE 'Low Performance'
    END AS PerformanceCategory
FROM 
    fsfp
ORDER BY 
    StrategyName, PerformanceDate;
