CREATE DATABASE railway;

USE railway;

CREATE TABLE dim_zone (
    Zone_Code VARCHAR(20) NOT NULL,
    Zone_Name VARCHAR(100),

    PRIMARY KEY (Zone_Code)
);

CREATE TABLE dim_station (
    Station_Code VARCHAR(20) NOT NULL,
    Station_ID INT NOT NULL,
    Station_Name VARCHAR(150) NOT NULL,
    City VARCHAR(100),
    State VARCHAR(100),
    Zone_Code VARCHAR(20),
    Division VARCHAR(100),
    Station_Category VARCHAR(50),

    PRIMARY KEY (Station_Code),

    UNIQUE KEY uq_station_id (Station_ID),

    CONSTRAINT fk_station_zone
        FOREIGN KEY (Zone_Code)
        REFERENCES dim_zone (Zone_Code)
);

CREATE TABLE dim_train (
    Train_ID INT NOT NULL,
    Train_Number INT NOT NULL,
    Train_Name VARCHAR(150) NOT NULL,
    Train_Type VARCHAR(50),
    Source_Station VARCHAR(50),
    Destination_Station VARCHAR(50),
    Distance_KM DECIMAL(10,2),
    Service_Frequency VARCHAR(50),
    Zone_Code VARCHAR(20),
    Start_Time TIME,
    End_Time TIME,

    PRIMARY KEY (Train_ID),

    UNIQUE KEY uq_train_number (Train_Number),

    CONSTRAINT fk_train_zone
        FOREIGN KEY (Zone_Code)
        REFERENCES dim_zone (Zone_Code)
);

CREATE TABLE dim_passenger_class (
    Passenger_Class VARCHAR(50) NOT NULL,

    PRIMARY KEY (Passenger_Class)
);

CREATE TABLE fact_revenue (
    Revenue_ID INT NOT NULL AUTO_INCREMENT,
    Railway VARCHAR(100) NOT NULL,
    Year INT NOT NULL,
    Quarter VARCHAR(20),
    Revenue_Freight DECIMAL(20,2),
    Revenue_Passenger DECIMAL(20,2),
    Revenue_Total DECIMAL(20,2),
    Expenditure DECIMAL(20,2),
    Net_Revenue DECIMAL(20,2),
    Revenue_Growth DECIMAL(12,4),

    PRIMARY KEY (Revenue_ID),

    UNIQUE KEY uq_revenue_year (Railway, Year, Quarter)
);

CREATE TABLE fact_passenger_class (
    Passenger_Class_Record_ID INT NOT NULL AUTO_INCREMENT,
    Year INT NOT NULL,
    Passenger_Class VARCHAR(50) NOT NULL,
    Passengers BIGINT,
    Passenger_KM DECIMAL(20,2),
    Earnings DECIMAL(20,2),
    Average_Lead DECIMAL(12,4),
    Average_Fare DECIMAL(12,4),
    Rate_Per_Passenger_KM DECIMAL(12,6),

    PRIMARY KEY (Passenger_Class_Record_ID),

    UNIQUE KEY uq_passenger_class_year
        (Year, Passenger_Class),

    CONSTRAINT fk_passenger_class
        FOREIGN KEY (Passenger_Class)
        REFERENCES dim_passenger_class (Passenger_Class)
);

CREATE TABLE fact_passenger_traffic (
    Passenger_Traffic_ID INT NOT NULL AUTO_INCREMENT,
    Year INT NOT NULL,
    Railway_Zone VARCHAR(20) NOT NULL,
    Passenger_Category VARCHAR(100),
    Passengers_Originating BIGINT,
    Passenger_KM DECIMAL(20,2),
    Average_Lead_KM DECIMAL(12,4),
    Passenger_Earnings DECIMAL(20,2),
    Average_Rate_Per_Passenger_KM DECIMAL(12,6),

    PRIMARY KEY (Passenger_Traffic_ID),

    UNIQUE KEY uq_passenger_traffic
        (Year, Railway_Zone, Passenger_Category),

    CONSTRAINT fk_passenger_traffic_zone
        FOREIGN KEY (Railway_Zone)
        REFERENCES dim_zone (Zone_Code)
);

CREATE TABLE fact_zone_performance (
    Zone_Performance_ID INT NOT NULL AUTO_INCREMENT,
    Year INT NOT NULL,
    Zone VARCHAR(20) NOT NULL,
    Passengers BIGINT,
    Passenger_KM DECIMAL(20,2),
    Passenger_Revenue DECIMAL(20,2),
    Freight_Revenue DECIMAL(20,2),
    Total_Revenue DECIMAL(20,2),
    Revenue_Per_Passenger DECIMAL(14,4),

    PRIMARY KEY (Zone_Performance_ID),

    UNIQUE KEY uq_zone_performance
        (Year, Zone),

    CONSTRAINT fk_zone_performance_zone
        FOREIGN KEY (Zone)
        REFERENCES dim_zone (Zone_Code)
);

CREATE TABLE fact_route (
    Route_ID INT NOT NULL,
    Train_ID INT NOT NULL,
    Source_Station VARCHAR(50),
    Destination_Station VARCHAR(50),
    Distance_KM DECIMAL(10,2),
    Zone VARCHAR(20),
    Route_Type VARCHAR(50),
    Number_of_Stations INT,

    PRIMARY KEY (Route_ID),

    CONSTRAINT fk_route_train
        FOREIGN KEY (Train_ID)
        REFERENCES dim_train (Train_ID),

    CONSTRAINT fk_route_zone
        FOREIGN KEY (Zone)
        REFERENCES dim_zone (Zone_Code)
);

CREATE TABLE fact_train_schedule (
    Schedule_ID BIGINT NOT NULL,
    Train_ID INT NOT NULL,
    Train_Number INT,
    Station_Code VARCHAR(20) NOT NULL,
    Station_Name VARCHAR(150),
    Arrival_Time TIME,
    Departure_Time TIME,
    Halt_Minutes INT,
    Day_Number INT,
    Distance_From_Source DECIMAL(10,2),
    Sequence_Number INT,

    PRIMARY KEY (Schedule_ID),

    CONSTRAINT fk_schedule_train
        FOREIGN KEY (Train_ID)
        REFERENCES dim_train (Train_ID),

    CONSTRAINT fk_schedule_station
        FOREIGN KEY (Station_Code)
        REFERENCES dim_station (Station_Code)
);

CREATE INDEX idx_revenue_year
ON fact_revenue (Year);

CREATE INDEX idx_passenger_class_year
ON fact_passenger_class (Year);

CREATE INDEX idx_passenger_traffic_year
ON fact_passenger_traffic (Year);

CREATE INDEX idx_passenger_traffic_zone
ON fact_passenger_traffic (Railway_Zone);

CREATE INDEX idx_zone_performance_year
ON fact_zone_performance (Year);

CREATE INDEX idx_zone_performance_zone
ON fact_zone_performance (Zone);

CREATE INDEX idx_route_train
ON fact_route (Train_ID);

CREATE INDEX idx_route_zone
ON fact_route (Zone);

CREATE INDEX idx_schedule_train
ON fact_train_schedule (Train_ID);

CREATE INDEX idx_schedule_station
ON fact_train_schedule (Station_Code);

SHOW TABLES;

LOAD DATA LOCAL INFILE 'C:/Users/acer/Downloads/Railway/Railway_CSV_For_Provided_SQL/fact_train_schedule.csv'
INTO TABLE fact_train_schedule
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Schedule_ID,
    Train_ID,
    Train_Number,
    Station_Code,
    Station_Name,
    Arrival_Time,
    Departure_Time,
    Halt_Minutes,
    Day_Number,
    Distance_From_Source,
    Sequence_Number
);

LOAD DATA LOCAL INFILE 'C:/Users/acer/Downloads/Railway/Railway_CSV_For_Provided_SQL/fact_route.csv'
INTO TABLE fact_route
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Route_ID,
    Train_ID,
    Source_Station,
    Destination_Station,
    Distance_KM,
    Zone,
    Route_Type,
    Number_of_Stations
);

LOAD DATA LOCAL INFILE 'C:/Users/acer/Downloads/Railway/Railway_CSV_For_Provided_SQL/dim_train.csv'
INTO TABLE dim_train
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Train_ID,
    Train_Number,
    Train_Name,
    Train_Type,
    Source_Station,
    Destination_Station,
    Distance_KM,
    Service_Frequency,
    Zone_Code,
    Start_Time,
    End_Time
);

SELECT COUNT(*) AS Schedule_Count
FROM fact_train_schedule;

SELECT *
FROM fact_train_schedule
LIMIT 10;
DESCRIBE dim_train;

SELECT COUNT(*) AS Train_Count
FROM dim_train;

SELECT COUNT(*) AS Invalid_Train_IDs
FROM fact_train_schedule f
LEFT JOIN dim_train t
    ON f.Train_ID = t.Train_ID
WHERE t.Train_ID IS NULL;

SELECT 
    COUNT(*) AS Invalid_Route_Train_IDs
FROM fact_route r
LEFT JOIN dim_train t
    ON r.Train_ID = t.Train_ID
WHERE t.Train_ID IS NULL;

SELECT COUNT(*) AS Train_Count
FROM dim_train;

SELECT COUNT(*) AS Schedule_Count
FROM fact_train_schedule;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SHOW GLOBAL VARIABLES LIKE 'local_infile';

DESCRIBE dim_zone;
DESCRIBE dim_station;
DESCRIBE dim_train;
DESCRIBE dim_passenger_class;
DESCRIBE fact_revenue;
DESCRIBE fact_passenger_class;
DESCRIBE fact_passenger_traffic;
DESCRIBE fact_zone_performance;
DESCRIBE fact_route;
DESCRIBE fact_train_schedule;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;

SELECT 'dim_zone' AS Table_Name, COUNT(*) AS Row_Count
FROM dim_zone

UNION ALL
SELECT 'dim_station', COUNT(*)
FROM dim_station

UNION ALL
SELECT 'dim_train', COUNT(*)
FROM dim_train

UNION ALL
SELECT 'dim_passenger_class', COUNT(*)
FROM dim_passenger_class

UNION ALL
SELECT 'fact_revenue', COUNT(*)
FROM fact_revenue

UNION ALL
SELECT 'fact_passenger_class', COUNT(*)
FROM fact_passenger_class

UNION ALL
SELECT 'fact_passenger_traffic', COUNT(*)
FROM fact_passenger_traffic

UNION ALL
SELECT 'fact_zone_performance', COUNT(*)
FROM fact_zone_performance

UNION ALL
SELECT 'fact_route', COUNT(*)
FROM fact_route

UNION ALL
SELECT 'fact_train_schedule', COUNT(*)
FROM fact_train_schedule;



SELECT COUNT(*) AS Train_Count
FROM dim_train;

SELECT MIN(Train_ID) AS Min_ID,
       MAX(Train_ID) AS Max_ID,
       COUNT(DISTINCT Train_ID) AS Unique_IDs
FROM dim_train;

DELETE FROM dim_train
WHERE Train_ID > 0;

SELECT COUNT(*) AS Train_Count
FROM dim_train;

SELECT COUNT(*) FROM dim_train;

SET FOREIGN_KEY_CHECKS = 0;

DELETE FROM dim_train;

SET FOREIGN_KEY_CHECKS = 1;

DELETE FROM dim_train
WHERE Train_ID IS NOT NULL;

SELECT COUNT(*) AS Train_Count
FROM dim_train;

SELECT * FROM dim_train LIMIT 10;

SHOW TABLES;
DESCRIBE dim_station;

SELECT COUNT(*) AS Station_Count
FROM dim_station;

SELECT Train_ID, COUNT(*) AS Count
FROM dim_train
GROUP BY Train_ID;

SELECT Train_Number, COUNT(*) AS Count
FROM dim_train
GROUP BY Train_Number
HAVING COUNT(*) > 1;

SELECT 
    COUNT(*) AS Missing_Values
FROM dim_train
WHERE Train_ID IS NULL
   OR Train_Number IS NULL
   OR Train_Name IS NULL;
   
   SELECT COUNT(*) AS Invalid_Train_IDs
FROM fact_route r
LEFT JOIN dim_train t
    ON r.Train_ID = t.Train_ID
WHERE t.Train_ID IS NULL;

SELECT COUNT(*) AS Train_Count
FROM dim_train;

SELECT Train_ID, COUNT(*) AS Count
FROM dim_train
GROUP BY Train_ID
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS Missing_Values
FROM dim_train
WHERE Train_ID IS NULL
   OR Train_Number IS NULL
   OR Train_Name IS NULL;
   
-- Removed: orphan HAVING clause (no preceding GROUP BY query)
SELECT COUNT(*) AS Route_Count
FROM fact_route;
DESCRIBE fact_route;

SELECT
    (SELECT COUNT(*) FROM dim_zone) AS Zone_Count,
    (SELECT COUNT(*) FROM dim_train) AS Train_Count,
    (SELECT COUNT(*) FROM fact_route) AS Route_Count,
    (SELECT COUNT(*) FROM fact_train_schedule) AS Schedule_Count;
    
    SELECT COUNT(*) AS Total_Rows
FROM fact_passenger_class;

    DELETE FROM fact_passenger_class
WHERE 1=1;
SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM dim_passenger_class;

DELETE FROM fact_passenger_class;

DESCRIBE dim_passenger_class;

SELECT 
    Passenger_Class,
    CHAR_LENGTH(Passenger_Class) AS Length
FROM dim_passenger_class;

UPDATE dim_passenger_class
SET Passenger_Class = 'AC 2 Tier'
WHERE Passenger_Class = 'AC 2 Tie';

UPDATE dim_passenger_class
SET Passenger_Class = 'AC 3 Tier'
WHERE Passenger_Class = 'AC 3 Tie';

UPDATE dim_passenger_class
SET Passenger_Class = 'AC First Class'
WHERE Passenger_Class = 'AC Fi';

UPDATE dim_passenger_class
SET Passenger_Class = 'Passenger'
WHERE Passenger_Class = 'Passenge';

UPDATE dim_passenger_class
SET Passenger_Class = 'Sleeper'
WHERE Passenger_Class = 'Sleepe';

SELECT Passenger_Class
FROM dim_passenger_class;

SELECT COUNT(*) AS Passenger_Class_Count
FROM dim_passenger_class;

SELECT COUNT(*) AS Passenger_Class_Count
FROM dim_passenger_class;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM fact_passenger_class;

SET SQL_SAFE_UPDATES = 1;

SELECT COUNT(*) AS Total_Rows
FROM fact_passenger_class;

SELECT DISTINCT f.Passenger_Class
FROM fact_passenger_class f
LEFT JOIN dim_passenger_class d
    ON TRIM(f.Passenger_Class) = TRIM(d.Passenger_Class)
WHERE d.Passenger_Class IS NULL;

SELECT Passenger_Class, COUNT(*) AS Row_Count
FROM fact_passenger_class
GROUP BY Passenger_Class;

SELECT Passenger_Class
FROM dim_passenger_class
ORDER BY Passenger_Class;

DESCRIBE fact_passenger_class;

DELETE FROM fact_passenger_class
WHERE Passenger_Class_Record_ID > 0;

SELECT COUNT(*) AS Row_Count
FROM fact_passenger_class;

SELECT COUNT(*) AS Passenger_Class_Rows
FROM fact_passenger_class;

UPDATE dim_passenger_class
SET Passenger_Class = 'AC First'
WHERE Passenger_Class = 'AC First Class';

SELECT *
FROM dim_passenger_class
WHERE Passenger_Class = 'AC First';

SELECT DISTINCT Passenger_Class
FROM dim_passenger_class
ORDER BY Passenger_Class;

SELECT *
FROM dim_passenger_class
WHERE Passenger_Class = 'Passenger';

SELECT *
FROM dim_passenger_class
WHERE Passenger_Class = 'Passenger';

SHOW COLUMNS FROM dim_passenger_class;
DESCRIBE dim_passenger_class;

SELECT DISTINCT Passenger_Class
FROM dim_passenger_class
ORDER BY Passenger_Class;

SELECT DISTINCT Passenger_Class
FROM railway.fact_passenger_class
ORDER BY Passenger_Class;
SELECT DISTINCT f.Passenger_Class
FROM railway.fact_passenger_class f
LEFT JOIN railway.dim_passenger_class d
    ON f.Passenger_Class = d.Passenger_Class
WHERE d.Passenger_Class IS NULL;
DESCRIBE railway.fact_passenger_class;

ALTER TABLE railway.fact_passenger_class
ADD CONSTRAINT fk_fact_passenger_class
FOREIGN KEY (Passenger_Class)
REFERENCES railway.dim_passenger_class (Passenger_Class);

SHOW CREATE TABLE railway.fact_passenger_class;

SELECT
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_passenger_class'
  AND REFERENCED_TABLE_NAME = 'dim_passenger_class';
  
  ALTER TABLE railway.fact_passenger_class
DROP FOREIGN KEY fk_passenger_class;

SELECT
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_passenger_class';
  
  SHOW TABLES FROM railway;
-- Removed: orphan AND condition after SHOW TABLES
  
  DESCRIBE railway.dim_train;
  
  SHOW COLUMNS FROM railway.dim_train;
  
  SELECT COLUMN_NAME, COLUMN_TYPE, COLUMN_KEY
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'dim_train'
ORDER BY ORDINAL_POSITION;

DESCRIBE railway.dim_train;
DESCRIBE railway.fact_train_schedule;

SELECT DISTINCT f.Train_ID
FROM railway.fact_train_schedule f
LEFT JOIN railway.dim_train d
    ON f.Train_ID = d.Train_ID
WHERE d.Train_ID IS NULL;

ALTER TABLE railway.fact_train_schedule
ADD CONSTRAINT fk_fact_train_schedule_train
FOREIGN KEY (Train_ID)
REFERENCES railway.dim_train (Train_ID);

SELECT
    CONSTRAINT_NAME,
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_train_schedule'
  AND REFERENCED_TABLE_NAME = 'dim_train';
  
  SELECT
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_train_schedule'
  AND REFERENCED_TABLE_NAME = 'dim_train';
  
  SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_train_schedule'
  AND REFERENCED_TABLE_NAME = 'dim_train';
  
  ALTER TABLE railway.fact_train_schedule
DROP FOREIGN KEY fk_schedule_train;

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_train_schedule'
  AND REFERENCED_TABLE_NAME = 'dim_train';
  
  DESCRIBE railway.dim_station;
  
  SELECT DISTINCT f.Station_Code
FROM railway.fact_train_schedule f
LEFT JOIN railway.dim_station d
    ON f.Station_Code = d.Station_Code
WHERE d.Station_Code IS NULL;

ALTER TABLE railway.fact_train_schedule
ADD CONSTRAINT fk_fact_train_schedule_station
FOREIGN KEY (Station_Code)
REFERENCES railway.dim_station (Station_Code);

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_train_schedule'
  AND REFERENCED_TABLE_NAME = 'dim_station';
  
  ALTER TABLE railway.fact_train_schedule
DROP FOREIGN KEY fk_schedule_station;

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_train_schedule'
  AND REFERENCED_TABLE_NAME = 'dim_station';
  
  DESCRIBE railway.dim_zone;
  
  DESCRIBE railway.fact_zone_performance;
  
  SELECT DISTINCT f.Zone
FROM railway.fact_zone_performance f
LEFT JOIN railway.dim_zone d
    ON f.Zone = d.Zone_Code
WHERE d.Zone_Code IS NULL;

ALTER TABLE railway.fact_zone_performance
ADD CONSTRAINT fk_fact_zone_performance_zone
FOREIGN KEY (Zone)
REFERENCES railway.dim_zone (Zone_Code);

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_zone_performance'
  AND REFERENCED_TABLE_NAME = 'dim_zone';
  
  ALTER TABLE railway.fact_zone_performance
DROP FOREIGN KEY fk_zone_performance_zone;

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_zone_performance'
  AND REFERENCED_TABLE_NAME = 'dim_zone';
  
  DESCRIBE railway.fact_route;
  
  SELECT DISTINCT f.Train_ID
FROM railway.fact_route f
LEFT JOIN railway.dim_train d
    ON f.Train_ID = d.Train_ID
WHERE d.Train_ID IS NULL;

ALTER TABLE railway.fact_route
ADD CONSTRAINT fk_fact_route_train
FOREIGN KEY (Train_ID)
REFERENCES railway.dim_train (Train_ID);

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_route';
  
  
  ALTER TABLE railway.fact_route
DROP FOREIGN KEY fk_route_train;

-- Removed: orphan AND condition after DROP FOREIGN KEY
  
  
  SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_route'
  AND REFERENCED_TABLE_NAME = 'dim_train';
  
  SELECT DISTINCT f.Zone
FROM railway.fact_route f
LEFT JOIN railway.dim_zone d
    ON f.Zone = d.Zone_Code
WHERE d.Zone_Code IS NULL;

ALTER TABLE railway.fact_route
ADD CONSTRAINT fk_fact_route_zone
FOREIGN KEY (Zone)
REFERENCES railway.dim_zone (Zone_Code);


SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_route'
  AND REFERENCED_TABLE_NAME = 'dim_zone';
  
  ALTER TABLE railway.fact_route
DROP FOREIGN KEY fk_route_zone;

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_route';
  
DESCRIBE railway.fact_passenger_traffic;
-- Removed: orphan AND condition after DESCRIBE
  
  SELECT DISTINCT f.Railway_Zone
FROM railway.fact_passenger_traffic f
LEFT JOIN railway.dim_zone d
    ON f.Railway_Zone = d.Zone_Code
WHERE d.Zone_Code IS NULL;

ALTER TABLE railway.fact_passenger_traffic
ADD CONSTRAINT fk_fact_passenger_traffic_zone
FOREIGN KEY (Railway_Zone)
REFERENCES railway.dim_zone (Zone_Code);

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_passenger_traffic'
  AND REFERENCED_TABLE_NAME = 'dim_zone';
  
  ALTER TABLE railway.fact_passenger_traffic
DROP FOREIGN KEY fk_passenger_traffic_zone;

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND TABLE_NAME = 'fact_passenger_traffic'
  AND REFERENCED_TABLE_NAME = 'dim_zone';
  
  DESCRIBE railway.fact_revenue;
  
  SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'railway'
  AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME, CONSTRAINT_NAME;

SELECT Train_ID, COUNT(*) AS cnt
FROM dim_train
GROUP BY Train_ID
HAVING COUNT(*) > 1;

SELECT Train_ID, COUNT(*) AS cnt
FROM fact_route
GROUP BY Train_ID
HAVING COUNT(*) > 1;

SELECT Zone_Code, COUNT(*) AS cnt
FROM dim_zone
GROUP BY Zone_Code
HAVING COUNT(*) > 1;

SELECT Zone, COUNT(*) AS cnt
FROM fact_route
GROUP BY Zone
HAVING COUNT(*) > 1; 

SELECT 
    Train_ID,
    COUNT(*) AS cnt
FROM fact_route
GROUP BY Train_ID
HAVING COUNT(*) > 1;

SELECT 
    Train_ID,
    COUNT(*) AS cnt
FROM fact_train_schedule
GROUP BY Train_ID
HAVING COUNT(*) > 1;


SELECT 
    Zone,
    COUNT(*) AS cnt
FROM fact_route
GROUP BY Zone
HAVING COUNT(*) > 1;

SELECT
    Year,
    COUNT(*) AS cnt

