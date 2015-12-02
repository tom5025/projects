CREATE TABLE [dbo].[Table]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY, 
    [Title] NVARCHAR(100) NULL, 
    [Director] NVARCHAR(100) NULL, 
    [DateReleased] DATETIME NULL
)
