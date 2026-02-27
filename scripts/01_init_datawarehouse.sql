/*
===============================================================================
Script Name      : 01_init_datawarehouse.sql
Author           : Dhritideepa Gorai
Created Date     : 27-02-2026
Environment      : DEV
Description      : Initializes DataWarehouse database and layer schemas
                   (bronze, silver, gold) for Medallion architecture.

Business Context :
- Bronze  : Raw ingestion layer
- Silver  : Cleaned & transformed data
- Gold    : Business-ready curated layer

Execution Notes :
- Safe to re-run (idempotent).
- Drops and recreates database (DEV use only).

===============================================================================
*/

USE master;
GO

-- Drop database if exists (DEV only safeguard)
IF DB_ID('DataWarehouse') IS NOT NULL
BEGIN
    PRINT 'Dropping existing DataWarehouse database...';
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END
GO

-- Create fresh database
PRINT 'Creating DataWarehouse database...';
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

PRINT 'Creating schemas...';

-- Bronze Layer Schema (Raw data ingestion)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'bronze')
BEGIN
    EXEC('CREATE SCHEMA bronze');
END
GO

-- Silver Layer Schema (Cleansed & transformed data)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC('CREATE SCHEMA silver');
END
GO

-- Gold Layer Schema (Business-ready models)
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'gold')
BEGIN
    EXEC('CREATE SCHEMA gold');
END
GO

PRINT 'Initialization completed successfully.';
