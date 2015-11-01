
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 11/01/2015 02:36:58
-- Generated from EDMX file: C:\Users\thomas\Documents\projects\TSInput\WS\TimeEntities.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------


-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[TimeEntrySet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TimeEntrySet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'TimeEntrySet'
CREATE TABLE [dbo].[TimeEntrySet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [project] nvarchar(max)  NOT NULL,
    [prestation] nvarchar(max)  NOT NULL,
    [desc] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'TimeEntrySet'
ALTER TABLE [dbo].[TimeEntrySet]
ADD CONSTRAINT [PK_TimeEntrySet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------