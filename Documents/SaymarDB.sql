
--Create database

USE [master]
GO
IF NOT EXISTS (SELECT [name] FROM sys.databases WHERE name = N'SamyakDB')
BEGIN
CREATE DATABASE [SamyakDB] COLLATE SQL_Latin1_General_CP1_CI_AS
END
GO
EXEC dbo.sp_dbcmptlevel @dbname=N'SamyakDB', @new_cmptlevel=120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
BEGIN
	EXEC [SamyakDB].[dbo].[sp_fulltext_database] @action = 'enable'
END
GO
ALTER DATABASE [SamyakDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [SamyakDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [SamyakDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [SamyakDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [SamyakDB] SET ARITHABORT OFF
GO
ALTER DATABASE [SamyakDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [SamyakDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [SamyakDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [SamyakDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [SamyakDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [SamyakDB] SET CURSOR_DEFAULT GLOBAL
GO
ALTER DATABASE [SamyakDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [SamyakDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [SamyakDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [SamyakDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [SamyakDB] SET DISABLE_BROKER
GO
ALTER DATABASE [SamyakDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [SamyakDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [SamyakDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [SamyakDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [SamyakDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [SamyakDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [SamyakDB] SET READ_WRITE
GO
ALTER DATABASE [SamyakDB] SET RECOVERY SIMPLE
GO
ALTER DATABASE [SamyakDB] SET MULTI_USER
GO
ALTER DATABASE [SamyakDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [SamyakDB] SET DB_CHAINING OFF
GO

USE [SamyakDB]
GO

--Create Users
USE [SamyakDB]
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE [name] = N'SamyakAdmin')
	CREATE USER [SamyakAdmin] WITHOUT LOGIN WITH DEFAULT_SCHEMA = [dbo];
GO

--Create Roles
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'public' AND type = 'R')
	CREATE ROLE [public] AUTHORIZATION [dbo]
GO

--Database Schemas

USE [SamyakDB]
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'dbo')
EXEC sys.sp_executesql N'CREATE SCHEMA [dbo] AUTHORIZATION [dbo]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'guest')
EXEC sys.sp_executesql N'CREATE SCHEMA [guest] AUTHORIZATION [guest]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'INFORMATION_SCHEMA')
EXEC sys.sp_executesql N'CREATE SCHEMA [INFORMATION_SCHEMA] AUTHORIZATION [INFORMATION_SCHEMA]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'sys')
EXEC sys.sp_executesql N'CREATE SCHEMA [sys] AUTHORIZATION [sys]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_owner')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_owner] AUTHORIZATION [db_owner]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_accessadmin')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_accessadmin] AUTHORIZATION [db_accessadmin]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_securityadmin')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_securityadmin] AUTHORIZATION [db_securityadmin]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_ddladmin')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_ddladmin] AUTHORIZATION [db_ddladmin]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_backupoperator')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_backupoperator] AUTHORIZATION [db_backupoperator]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_datareader')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_datareader] AUTHORIZATION [db_datareader]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_datawriter')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_datawriter] AUTHORIZATION [db_datawriter]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_denydatareader')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_denydatareader] AUTHORIZATION [db_denydatareader]'
GO
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = N'db_denydatawriter')
EXEC sys.sp_executesql N'CREATE SCHEMA [db_denydatawriter] AUTHORIZATION [db_denydatawriter]'
GO

--Table dbo.app_users

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[app_users] (
	[user_id] [int] NOT NULL IDENTITY (1, 1),
	[user_name] [varchar](100) NULL,
	[password] [varchar](250) NULL,
	[user_role] [varchar](250) NULL,
	[created_on] [date] NULL CONSTRAINT [DF__app_users__creat__108B795B] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[app_users] ON
GO
INSERT INTO [dbo].[app_users] ([user_id], [user_name], [password], [user_role], [created_on])
	VALUES (1, N'admin', N'21232f297a57a5a743894a0e4a801fc3', N'system admin', CAST(0x5b3d0b AS date))

GO
SET IDENTITY_INSERT [dbo].[app_users] OFF
GO

--Table dbo.application_error_log

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[application_error_log] (
	[id] [int] NOT NULL IDENTITY (1, 1),
	[module] [nvarchar](50) NULL,
	[process_name] [nvarchar](50) NULL,
	[error_message] [nvarchar](MAX) NULL,
	[stack_trace] [nvarchar](MAX) NULL,
	[created_date] [date] NULL CONSTRAINT [DF__applicati__creat__08B54D69] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[application_error_log] ON
GO
INSERT INTO [dbo].[application_error_log] ([id], [module], [process_name], [error_message], [stack_trace], [created_date])
	VALUES (1, N'PerformLogin', N'Could not find store', N'Could not find stored procedure ''SP_LOGIN_PROCESS1''.', N'NA', CAST(0x643e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[application_error_log] OFF
GO

--Table dbo.BASTI_DETAILS

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[BASTI_DETAILS] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[SR_NO] [int] NULL,
	[DATE] [date] NULL,
	[OIL_GHEE] [nvarchar](5) NULL,
	[OIL_GHEE_NAME] [nvarchar](50) NULL,
	[DOSE] [nvarchar](50) NULL,
	[MASSAGE] [nvarchar](5) NULL,
	[MASSAGE_OIL] [nvarchar](50) NULL,
	[SYMPTOMS] [nvarchar](250) NULL,
	[DATTA] [nvarchar](250) NULL,
	[PRATYAGAMAN] [nvarchar](250) NULL,
	[CREATED_DATE] [date] NULL);
GO

SET IDENTITY_INSERT [dbo].[BASTI_DETAILS] ON
GO
INSERT INTO [dbo].[BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (1, N'CASE201808121029212', 1, CAST(0xdb3e0b AS date), N'तेल', N'तीळ तेल', N'', N'', N'', N'', N'10:30 PM', N'10:30 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (2, N'CASE201808121029212', 2, CAST(0xdd3e0b AS date), N'चूर्ण', N'चूर्ण1', N'', N'', N'', N'', N'10:30 PM', N'10:30 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (3, N'CASE201808121029212', 3, CAST(0xdf3e0b AS date), N'चूर्ण', N'चूर्ण1', N'', N'', N'', N'', N'10:30 PM', N'10:30 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (4, N'CASE201808121029212', 4, CAST(0xe13e0b AS date), N'', N'--', N'', N'', N'', N'', N'10:30 PM', N'10:30 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (5, N'CASE201808121029212', 5, CAST(0xe33e0b AS date), N'', N'--', N'', N'', N'', N'', N'10:30 PM', N'10:30 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (6, N'CASE201808121029212', 6, CAST(0xe53e0b AS date), N'', N'--', N'', N'', N'', N'', N'10:30 PM', N'10:30 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (7, N'CASE201808121029212', 7, CAST(0xe73e0b AS date), N'', N'--', N'', N'', N'', N'', N'09:15 PM', N'09:15 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (8, N'CASE201808121029212', 8, CAST(0xe93e0b AS date), N'', N'--', N'', N'', N'', N'', N'09:15 PM', N'09:15 PM', CAST(0xdd3e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[BASTI_DETAILS] OFF
GO

--Table dbo.Case_Details

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[Case_Details] (
	[Case_ID] [varchar](250) NOT NULL,
	[Patient_ID] [int] NULL,
	[CreatedDate] [date] NULL CONSTRAINT [DF_Case_Details_CreatedDate] DEFAULT (getdate()));
GO

INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231155072', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231155500', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231157079', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231157559', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231159489', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231201230', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231202516', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231203538', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231204569', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231209275', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231220278', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231221341', 13, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231224010', 14, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231224544', 14, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231226543', 14, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231230198', 15, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231233581', 16, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231234500', 16, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231235111', 16, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231237116', 17, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231309318', 18, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231310254', 18, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231312060', 19, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806231910001', 20, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806232358307', 22, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806232359013', 23, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806232359543', 23, CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240000178', 23, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240001476', 24, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240002224', 24, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240004430', 25, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240007225', 25, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240007545', 25, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240009095', 25, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240009456', 25, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240018551', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240021088', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240022595', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240023333', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240023505', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240026141', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240034203', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240036403', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240037286', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240038474', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240039143', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240039573', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240040350', 26, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240043277', 27, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240055456', 28, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240056135', 28, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240056162', 28, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806240056315', 28, CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806272256075', 35, CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201806272301493', 36, CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201807011224390', 37, CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201807011225281', 37, CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201807092234229', 41, CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201807092234435', 41, CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201807141029220', 36, CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201807141045074', 28, CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201807141052291', 28, CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201807141158559', 42, CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091537262', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091545311', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091546341', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091547245', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091548149', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091549145', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091549229', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091550487', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091555247', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091556043', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091556393', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091558162', 4, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808091931265', 5, CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808111304080', 1042, CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808111308088', 1042, CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808112341327', 1042, CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808112354438', 1042, CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808121027402', 1042, CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808121029212', 1042, CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808121057399', 8, CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808121723424', 15, CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808152347216', 1042, CAST(0x983e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808160028534', 8, CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201808160101586', 5, CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201809131226285', 1043, CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201810021018400', 1044, CAST(0xc83e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201810071430329', 3, CAST(0xcd3e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE201810122228542', 12, CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE92', 1, CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[Case_Details] ([Case_ID], [Patient_ID], [CreatedDate])
	VALUES (N'CASE93', 7, CAST(0xd43e0b AS date))

GO

--Table dbo.ComplaintDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[ComplaintDetails] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[Case_ID] [varchar](25) NULL,
	[Complaint] [nvarchar](250) NULL,
	[DUrationYear] [nvarchar](2) NULL,
	[DurationMonth] [nvarchar](2) NULL,
	[DurationDays] [nvarchar](2) NULL,
	[CreatedDate] [date] NULL CONSTRAINT [DF__Complaint__Creat__59063A47] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[ComplaintDetails] ON
GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (1, N'CASE201806231224010', N'asdsa', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (2, N'CASE201806231224544', N'asdsa', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (3, N'CASE201806231226543', N'asdsa', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (4, N'CASE201806231230198', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (5, N'CASE201806231230198', N'asda', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (6, N'CASE201806231230198', N'asda', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (7, N'CASE201806231233581', N'asd', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (8, N'CASE201806231233581', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (9, N'CASE201806231233581', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (10, N'CASE201806231234500', N'asd', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (11, N'CASE201806231234500', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (12, N'CASE201806231234500', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (13, N'CASE201806231235111', N'asd', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (14, N'CASE201806231235111', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (15, N'CASE201806231235111', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (16, N'CASE201806231237116', N'sd', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (17, N'CASE201806231237116', N'asfa', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (18, N'CASE201806231237116', N'a', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (19, N'CASE201806231309318', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (20, N'CASE201806231310254', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (21, N'CASE201806231312060', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (22, N'CASE201806231312060', N'Shashikant Shinde', N'0', N'0', N'0', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (23, N'CASE201808121723424', N'test', N'0', N'0', N'12', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (24, N'CASE201809131226285', N'test', N'0', N'1', N'1', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[ComplaintDetails] ([ID], [Case_ID], [Complaint], [DUrationYear], [DurationMonth], [DurationDays], [CreatedDate])
	VALUES (25, N'CASE201810122228542', N'test', N'4', N'4', N'4', CAST(0xd23e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[ComplaintDetails] OFF
GO

--Table dbo.DailyDietDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[DailyDietDetails] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[Case_ID] [varchar](25) NULL,
	[Aahar] [nvarchar](250) NULL,
	[Bhaji] [nvarchar](250) NULL,
	[Koshimbir] [nvarchar](250) NULL,
	[Ambat] [nvarchar](250) NULL,
	[Dal] [nvarchar](250) NULL,
	[Chatani] [nvarchar](250) NULL,
	[Vidahi] [nvarchar](250) NULL,
	[FastFood] [nvarchar](250) NULL,
	[NonVeg] [nvarchar](250) NULL,
	[ColdDrink] [nvarchar](250) NULL,
	[Puyrishitha] [nvarchar](250) NULL,
	[FastingFood] [nvarchar](250) NULL,
	[OilyFood] [nvarchar](250) NULL,
	[AaharNiyam] [nvarchar](250) NULL,
	[Opposite] [nvarchar](250) NULL,
	[Bakery] [nvarchar](250) NULL,
	[Water] [nvarchar](250) NULL,
	[Fruits] [nvarchar](250) NULL,
	[Other] [nvarchar](250) NULL,
	[VegDharan] [nvarchar](250) NULL,
	[Habbit] [nvarchar](250) NULL,
	[KoshtaExam] [nvarchar](250) NULL,
	[Sleep] [nvarchar](250) NULL,
	[OjaExam] [nvarchar](250) NULL,
	[CreatedDate] [date] NULL CONSTRAINT [DF__DailyDiet__Creat__6D0D32F4] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[DailyDietDetails] ON
GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1, N'CASE201806240009456', N'Mustard, Ketchup', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (2, N'CASE201806240018551', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'Ketchup, Relish', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (3, N'CASE201806240021088', N'Mustard, Relish', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (4, N'CASE201806240022595', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'Mustard, Ketchup', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (5, N'CASE201806240023333', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'Mustard, Ketchup', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (6, N'CASE201806240023505', N'Ketchup, Relish', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (7, N'CASE201806240026141', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'Mustard, Ketchup', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (8, N'CASE201806240034203', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (9, N'CASE201806240036403', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (10, N'CASE201806240037286', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (11, N'CASE201806240038474', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (12, N'CASE201806240039143', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (13, N'CASE201806240039573', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (14, N'CASE201806240040350', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (15, N'CASE201806240043277', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'Ketchup, Relish', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (16, N'CASE201806240055456', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (17, N'CASE201806240056135', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (18, N'CASE201806240056162', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (19, N'CASE201806240056315', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (20, N'CASE201806272256075', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (21, N'CASE201806272301493', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (22, N'CASE201807011224390', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (23, N'CASE201807011225281', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (24, N'CASE201807092234229', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (25, N'CASE201807092234435', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (26, N'CASE201807141029220', N'भाकरी, भात', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'शेंगदाणा, सोआयबीन', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (27, N'CASE201807141045074', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (28, N'CASE201807141052291', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (29, N'CASE201807141158559', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1026, N'CASE201808091558162', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1027, N'CASE201808091931265', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1028, N'CASE201808111304080', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1029, N'CASE201808111308088', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1030, N'CASE201808112341327', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1031, N'CASE201808112354438', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1032, N'CASE201808121027402', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1033, N'CASE201808121029212', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1034, N'CASE201808121057399', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1035, N'CASE201808121723424', N'', N'पालक, करडई', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'अध्यशन', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1036, N'CASE201808152347216', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x983e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1037, N'CASE201808160028534', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1038, N'CASE201808160101586', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1039, N'CASE201809131226285', N'', N'', N'', N'', N'हरभरा', N'तीळ', N'', N'', N'', N'', N'Use of Freeze', N'वरीचा भात', N'', N'', N'', N'', N'', N'', N'', N'सुक्र', N'', N'', N'', N'', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1040, N'CASE201810021018400', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0xc83e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1041, N'CASE201810071430329', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0xcd3e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1042, N'CASE201810122228542', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1043, N'CASE92', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[DailyDietDetails] ([ID], [Case_ID], [Aahar], [Bhaji], [Koshimbir], [Ambat], [Dal], [Chatani], [Vidahi], [FastFood], [NonVeg], [ColdDrink], [Puyrishitha], [FastingFood], [OilyFood], [AaharNiyam], [Opposite], [Bakery], [Water], [Fruits], [Other], [VegDharan], [Habbit], [KoshtaExam], [Sleep], [OjaExam], [CreatedDate])
	VALUES (1044, N'CASE93', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[DailyDietDetails] OFF
GO

--Table dbo.DailyRoutineDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[DailyRoutineDetails] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[Case_ID] [varchar](25) NULL,
	[WakeupTime] [nvarchar](10) NULL,
	[WaterBeforeTea] [nvarchar](15) NULL,
	[WaterQuantity] [nvarchar](25) NULL,
	[MorningDrink] [nvarchar](25) NULL,
	[Divasvaap] [nvarchar](10) NULL,
	[NatureofWork] [nvarchar](25) NULL,
	[WorkingHours] [nvarchar](5) NULL,
	[Breakfast] [nvarchar](250) NULL,
	[CreatedDate] [date] NULL CONSTRAINT [DF__DailyRout__Creat__6754599E] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[DailyRoutineDetails] ON
GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1, N'CASE201806231312060', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (2, N'CASE201806240009456', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (3, N'CASE201806240018551', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (4, N'CASE201806240021088', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (5, N'CASE201806240022595', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (6, N'CASE201806240023333', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (7, N'CASE201806240023505', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (8, N'CASE201806240026141', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (9, N'CASE201806240034203', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (10, N'CASE201806240036403', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (11, N'CASE201806240037286', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (12, N'CASE201806240038474', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (13, N'CASE201806240039143', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (14, N'CASE201806240039573', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (15, N'CASE201806240040350', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (16, N'CASE201806240043277', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (17, N'CASE201806240055456', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (18, N'CASE201806240056135', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (19, N'CASE201806240056162', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (20, N'CASE201806240056315', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (21, N'CASE201806272256075', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (22, N'CASE201806272301493', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (23, N'CASE201807011224390', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (24, N'CASE201807011225281', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (25, N'CASE201807092234229', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (26, N'CASE201807092234435', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (27, N'CASE201807141029220', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (28, N'CASE201807141045074', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (29, N'CASE201807141052291', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (30, N'CASE201807141158559', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1027, N'CASE201808091558162', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1028, N'CASE201808091931265', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1029, N'CASE201808111304080', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1030, N'CASE201808111308088', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1031, N'CASE201808112341327', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1032, N'CASE201808112354438', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1033, N'CASE201808121027402', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1034, N'CASE201808121029212', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1035, N'CASE201808121057399', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1036, N'CASE201808121723424', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1037, N'CASE201808152347216', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x983e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1038, N'CASE201808160028534', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1039, N'CASE201808160101586', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1040, N'CASE201809131226285', N'6', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'9', N'test', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1041, N'CASE201810021018400', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0xc83e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1042, N'CASE201810071430329', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0xcd3e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1043, N'CASE201810122228542', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1044, N'CASE92', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[DailyRoutineDetails] ([ID], [Case_ID], [WakeupTime], [WaterBeforeTea], [WaterQuantity], [MorningDrink], [Divasvaap], [NatureofWork], [WorkingHours], [Breakfast], [CreatedDate])
	VALUES (1045, N'CASE93', N'', N'Yes', N'Cup', N'Tea', N'Yes', N'Sitting', N'', N'', CAST(0xd43e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[DailyRoutineDetails] OFF
GO

--Table dbo.DiagnosisDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[DiagnosisDetails] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[Rugnabal] [nvarchar](250) NULL,
	[VyadhiBal] [nvarchar](250) NULL,
	[Vaat] [nvarchar](250) NULL,
	[Pitta] [nvarchar](250) NULL,
	[Cough] [nvarchar](250) NULL,
	[Dosha] [nvarchar](250) NULL,
	[Strotas] [nvarchar](250) NULL,
	[Avastha] [nvarchar](250) NULL,
	[JathraAgni] [nvarchar](250) NULL,
	[DwhtaAgni] [nvarchar](250) NULL,
	[MahaBhutaAgni] [nvarchar](250) NULL,
	[VyahiNidan] [nvarchar](250) NULL,
	[Created_Date] [date] NULL CONSTRAINT [DF__Diagnosis__Creat__681373AD] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[DiagnosisDetails] ON
GO
INSERT INTO [dbo].[DiagnosisDetails] ([ID], [CASE_ID], [Rugnabal], [VyadhiBal], [Vaat], [Pitta], [Cough], [Dosha], [Strotas], [Avastha], [JathraAgni], [DwhtaAgni], [MahaBhutaAgni], [VyahiNidan], [Created_Date])
	VALUES (1, N'CASE201808121029212', N'मध्य, अल्प', N'प्रवर, मध्य', N'उदान, समान', N'रंजक, साधक', N'अवलंबक, बोधक', N'मज्जा, शुक्र', N'रस, मास', N'साम', N'तीक्ष्ण, मंद', N'विषम, मंद', N'तीक्ष्ण, मंद', N'CASE201808121029212', CAST(0xbe3e0b AS date))

GO
INSERT INTO [dbo].[DiagnosisDetails] ([ID], [CASE_ID], [Rugnabal], [VyadhiBal], [Vaat], [Pitta], [Cough], [Dosha], [Strotas], [Avastha], [JathraAgni], [DwhtaAgni], [MahaBhutaAgni], [VyahiNidan], [Created_Date])
	VALUES (2, N'CASE201810021018400', N'मध्य', N'मध्य', N'उदान', N'रंजक', N'अवलंबक', N'रक्त, अस्थी', N'उदक, रस', N'निराम', N'सम', N'मंद', N'तीक्ष्ण', N'CASE201810021018400', CAST(0xc83e0b AS date))

GO
INSERT INTO [dbo].[DiagnosisDetails] ([ID], [CASE_ID], [Rugnabal], [VyadhiBal], [Vaat], [Pitta], [Cough], [Dosha], [Strotas], [Avastha], [JathraAgni], [DwhtaAgni], [MahaBhutaAgni], [VyahiNidan], [Created_Date])
	VALUES (3, N'CASE93', N'NA', N'NA', N'NA', N'NA', N'NA', N'NA', N'NA', N'साम', N'NA', N'NA', N'NA', N'CASE93', CAST(0xd43e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[DiagnosisDetails] OFF
GO

--Table dbo.Error_Log

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[Error_Log] (
	[Record_ID] [int] NOT NULL IDENTITY (1, 1),
	[DateCreated] [datetime] NOT NULL CONSTRAINT [DF__Error_Log__DateC__6383C8BA] DEFAULT (getdate()),
	[ProcedureID] [int] NULL,
	[ProcedureName] [nvarchar](50) NULL,
	[ErrorCode] [nvarchar](20) NULL,
	[ErrorLine] [nvarchar](20) NULL,
	[ErrorMessage] [nvarchar](MAX) NULL,
	[Description] [nvarchar](MAX) NULL);
GO

SET IDENTITY_INSERT [dbo].[Error_Log] ON
GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1, CAST(0x0000a908013839f3 AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (2, CAST(0x0000a909000bb3df AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (3, CAST(0x0000a909000bcb62 AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (4, CAST(0x0000a917014e5ebc AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (5, CAST(0x0000a917014e664c AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (6, CAST(0x0000a917014e6c2e AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (7, CAST(0x0000a9170169b81e AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (8, CAST(0x0000a9170169cda3 AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (9, CAST(0x0000a917016b5dfb AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (10, CAST(0x0000a91d00aadd59 AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (11, CAST(0x0000a91d00ab7fd3 AS datetime), 4, N'GENERATE_CASE', N'547', N'14', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK__Case_Deta__Patie__31EC6D26". The conflict occurred in database "SamyakDB", table "dbo.Patient_Details", column ''Patient_ID''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1010, CAST(0x0000a97200df16d6 AS datetime), 3, N'SEARCH_PATIENTS', N'102', N'2', N'Incorrect syntax near ''WHERE''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1011, CAST(0x0000a97200e170fe AS datetime), 3, N'SEARCH_PATIENTS', N'102', N'2', N'Incorrect syntax near ''WHERE''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1012, CAST(0x0000a97200e2e03d AS datetime), 3, N'SEARCH_PATIENTS', N'102', N'2', N'Incorrect syntax near ''WHERE''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1013, CAST(0x0000a9760179459a AS datetime), 4, N'GENERATE_CASE', N'245', N'17', N'Conversion failed when converting the varchar value ''CASE'' to data type int.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1014, CAST(0x0000a97f01170ccb AS datetime), 3, N'SEARCH_PATIENTS', N'102', N'1', N'Incorrect syntax near ''MEDICINE_NAME''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1015, CAST(0x0000a97f01173aaf AS datetime), 3, N'SEARCH_PATIENTS', N'102', N'1', N'Incorrect syntax near ''MEDICINE_NAME''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1016, CAST(0x0000a97f011767b6 AS datetime), 3, N'SEARCH_PATIENTS', N'102', N'1', N'Incorrect syntax near ''MEDICINE_NAME''.', N'')

GO
INSERT INTO [dbo].[Error_Log] ([Record_ID], [DateCreated], [ProcedureID], [ProcedureName], [ErrorCode], [ErrorLine], [ErrorMessage], [Description])
	VALUES (1017, CAST(0x0000a97f0117b9df AS datetime), 3, N'SEARCH_PATIENTS', N'102', N'1', N'Incorrect syntax near ''MEDICINE_NAME''.', N'')

GO
SET IDENTITY_INSERT [dbo].[Error_Log] OFF
GO

--Table dbo.FollowUpDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[FollowUpDetails] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[Case_ID] [varchar](250) NULL,
	[FollowUpRequired] [nvarchar](25) NULL,
	[FollowUpFor] [varchar](25) NULL,
	[FollowUpDate] [date] NULL,
	[FollowUpDoneDate] [date] NULL CONSTRAINT [DF__FollowUpD__Follo__29221CFB] DEFAULT (getdate()),
	[FollowUpNumber] [numeric](10, 0) NULL);
GO

SET IDENTITY_INSERT [dbo].[FollowUpDetails] ON
GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (1, N'CASE201807141029220', N'YES', N'PANCHAKARMA', CAST(0xc83e0b AS date), CAST(0x783e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (2, N'CASE201807141045074', N'YES', N'PANCHAKARMA', CAST(0xc83e0b AS date), CAST(0x783e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (6, N'CASE201807141052291', N'YES', N'MASSAGE', CAST(0xc83e0b AS date), CAST(0x783e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (7, N'CASE201807141158559', N'YES', N'MEDICINE', CAST(0x8c3e0b AS date), CAST(0x783e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (1007, N'CASE201808091558162', N'Yes', N'MEDICINE', CAST(0xa73e0b AS date), CAST(0x923e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (1008, N'CASE201808091931265', N'Yes', N'MEDICINE', CAST(0xa03e0b AS date), CAST(0x923e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (1056, N'CASE201808112354438', N'Yes', N'MEDICINE', CAST(0x943e0b AS date), CAST(0x953e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (1091, N'CASE201808121057399', N'Yes', N'MEDICINE', CAST(0xc83e0b AS date), CAST(0x953e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (1095, N'CASE201808160101586', N'Yes', N'MEDICINE', CAST(0xa73e0b AS date), CAST(0x993e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (1098, N'CASE201809131226285', N'Yes', N'MEDICINE', CAST(0xc83e0b AS date), CAST(0xb53e0b AS date), 0)

GO
INSERT INTO [dbo].[FollowUpDetails] ([ID], [Case_ID], [FollowUpRequired], [FollowUpFor], [FollowUpDate], [FollowUpDoneDate], [FollowUpNumber])
	VALUES (1099, N'CASE201810021018400', N'Yes', N'MEDICINE', CAST(0xc83e0b AS date), CAST(0xc83e0b AS date), 0)

GO
SET IDENTITY_INSERT [dbo].[FollowUpDetails] OFF
GO

--Table dbo.GheeDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[GheeDetails] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[GHEE_NAME] [nvarchar](250) NULL,
	[GHEE_TYPE] [nvarchar](25) NULL,
	[GHEE_FOR] [nvarchar](25) NULL,
	[GHEE_FOR_TYPE] [nvarchar](25) NULL,
	[CREATED_DATE] [date] NULL CONSTRAINT [DF__GHEE_DETA__CREAT__4E53A1AA] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[GheeDetails] ON
GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (1, N'पंचगव्य घृत', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (2, N'शतावरी घृत', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (3, N'पंचतिक्त घृत', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (4, N'फलसर्पिस', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (5, N'कटकारी', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (6, N'महातिक्त घृत', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (7, N'पंचगव्य घृत', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (8, N'शतावरी घृत', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (9, N'पंचतिक्त घृत', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (10, N'फलसर्पिस', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (11, N'कटकारी', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (12, N'महातिक्त घृत', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (13, N'पंचगव्य घृत', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (14, N'शतावरी घृत', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (15, N'पंचतिक्त घृत', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (16, N'फलसर्पिस', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (17, N'कटकारी', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (18, N'महातिक्त घृत', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (19, N'पंचगव्य घृत', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (20, N'शतावरी घृत', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (21, N'पंचतिक्त घृत', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (22, N'फलसर्पिस', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (23, N'कटकारी', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[GheeDetails] ([ID], [GHEE_NAME], [GHEE_TYPE], [GHEE_FOR], [GHEE_FOR_TYPE], [CREATED_DATE])
	VALUES (24, N'महातिक्त घृत', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[GheeDetails] OFF
GO

--Table dbo.MedicineDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[MedicineDetails] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[Case_ID] [varchar](250) NULL,
	[MedicineName] [nvarchar](MAX) NULL,
	[MedicineType] [nvarchar](25) NULL,
	[MedicineDuration] [nvarchar](25) NULL,
	[MedicineFrequency] [nvarchar](25) NULL,
	[MedicineWhenToTake] [nvarchar](25) NULL,
	[MedicineWithToTake] [nvarchar](25) NULL,
	[MedicineQuantity] [nvarchar](25) NULL,
	[FollowuRequired] [nvarchar](25) NULL,
	[FollowuDate] [date] NULL);
GO

SET IDENTITY_INSERT [dbo].[MedicineDetails] ON
GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (1, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (2, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (3, N'CASE201808112354438', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (4, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (5, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (6, N'CASE201808112354438', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (7, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (8, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (9, N'CASE201808112354438', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (10, N'CASE201808112354438', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (11, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (12, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (13, N'CASE201808112354438', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (14, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (15, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (16, N'CASE201808112354438', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (17, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (18, N'CASE201808112354438', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (19, N'CASE201808112354438', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (20, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa13e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (21, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa13e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (22, N'CASE201808121057399', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa13e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (23, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (24, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (25, N'CASE201808121057399', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (26, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x973e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (27, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x973e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (28, N'CASE201808121057399', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0x973e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (29, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa83e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (30, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa83e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (31, N'CASE201808121057399', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa83e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (32, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa83e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (33, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa83e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (34, N'CASE201808121057399', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa83e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (35, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa73e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (36, N'CASE201808121057399', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa73e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (37, N'CASE201808121057399', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa73e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (38, N'CASE201808160101586', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa73e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (39, N'CASE201808160101586', N'क्षीरपाक 1', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa73e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (40, N'CASE201808160101586', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xa73e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (41, N'CASE201809131226285', N'चुर्ण 1 ', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (42, N'CASE201809131226285', N'TAB4', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (43, N'CASE201809131226285', N'काढा क्रं 1', N'काढा', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[MedicineDetails] ([ID], [Case_ID], [MedicineName], [MedicineType], [MedicineDuration], [MedicineFrequency], [MedicineWhenToTake], [MedicineWithToTake], [MedicineQuantity], [FollowuRequired], [FollowuDate])
	VALUES (44, N'CASE201810021018400', N'TAB2', N'चुर्ण', N'0', N'1', N'', N'साधे पाणी', N'0', N'Yes', CAST(0xd83e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[MedicineDetails] OFF
GO

--Table dbo.MedicineMaster

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[MedicineMaster] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[MEDICINE_ID] [nvarchar](10) NULL,
	[MEDICINE_NAME] [nvarchar](250) NULL,
	[MEDICINE_TYPE] [nvarchar](25) NULL,
	[MEDICINE_UNIT] [nvarchar](25) NULL,
	[CREATED_DATE] [date] NULL CONSTRAINT [DF__MedicineM__CREAT__3E1D39E1] DEFAULT (getdate()),
	[MEDICINE_FOR] [varchar](15) NULL,
	[MEDICINE_FOR_TYPE] [varchar](15) NULL);
GO

SET IDENTITY_INSERT [dbo].[MedicineMaster] ON
GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (1, N'TAB1', N'गोळी1', N'TAB', N'TAB', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (2, N'TAB2', N'गोळी2', N'TAB', N'TAB', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (3, N'TAB3', N'गोळी3', N'TAB', N'TAB', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (4, N'TAB4', N'गोळी4', N'TAB', N'TAB', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (5, N'TAB5', N'गोळी5', N'TAB', N'TAB', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (6, N'TAB6', N'गोळी6', N'TAB', N'TAB', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (7, N'TAB7', N'गोळी7', N'TAB', N'TAB', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (8, N'TAB8', N'गोळी8', N'TAB', N'TAB', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (9, N'CHU1', N'चूर्ण1', N'CHURNA', N'GM', CAST(0x943e0b AS date), N'PANCHAKARMA', N'BASTI')

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (10, N'CHU2', N'चूर्ण2', N'CHURNA', N'GM', CAST(0x943e0b AS date), N'PANCHAKARMA', N'BASTI')

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (11, N'CHU3', N'चूर्ण3', N'CHURNA', N'GM', CAST(0x943e0b AS date), N'PANCHAKARMA', N'BASTI')

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (12, N'CHU4', N'चूर्ण4', N'CHURNA', N'GM', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (13, N'CHU5', N'चूर्ण5', N'CHURNA', N'GM', CAST(0x943e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (14, N'TAB1', N'गोळी9', N'TAB', N'TAB', CAST(0x993e0b AS date), NULL, NULL)

GO
INSERT INTO [dbo].[MedicineMaster] ([ID], [MEDICINE_ID], [MEDICINE_NAME], [MEDICINE_TYPE], [MEDICINE_UNIT], [CREATED_DATE], [MEDICINE_FOR], [MEDICINE_FOR_TYPE])
	VALUES (15, N'TAB1', N'गोळी10', N'TAB', N'TAB', CAST(0x993e0b AS date), NULL, NULL)

GO
SET IDENTITY_INSERT [dbo].[MedicineMaster] OFF
GO

--Table dbo.NadiDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[NadiDetails] (
	[Id] [int] NOT NULL IDENTITY (1, 1),
	[Case_ID] [varchar](25) NULL,
	[Nadi] [nvarchar](50) NULL,
	[Mala] [nvarchar](50) NULL,
	[Mutra] [nvarchar](50) NULL,
	[Avastha] [nvarchar](50) NULL,
	[Prakruti] [nvarchar](50) NULL,
	[MensturalHistory] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL CONSTRAINT [DF__NadiDetai__Creat__60A75C0F] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[NadiDetails] ON
GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1, N'CASE201806231155072', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (2, N'CASE201806231155500', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (3, N'CASE201806231157079', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (4, N'CASE201806231157559', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (5, N'CASE201806231159489', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (6, N'CASE201806231201230', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (7, N'CASE201806231202516', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (8, N'CASE201806231203538', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (9, N'CASE201806231204569', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (10, N'CASE201806231209275', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (11, N'CASE201806231220278', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (12, N'CASE201806231221341', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (13, N'CASE201806231224010', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (14, N'CASE201806231224544', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (15, N'CASE201806231226543', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (16, N'CASE201806231230198', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (17, N'CASE201806231233581', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (18, N'CASE201806231234500', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (19, N'CASE201806231235111', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (20, N'CASE201806231237116', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (21, N'CASE201806231309318', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (22, N'CASE201806231310254', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (23, N'CASE201806231312060', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (24, N'CASE201806231910001', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (25, N'CASE201806232358307', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (26, N'CASE201806232359013', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (27, N'CASE201806232359543', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (28, N'CASE201806240000178', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (29, N'CASE201806240001476', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (30, N'CASE201806240002224', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (31, N'CASE201806240004430', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (32, N'CASE201806240007225', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (33, N'CASE201806240007545', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (34, N'CASE201806240009095', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (35, N'CASE201806240009456', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (36, N'CASE201806240018551', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (37, N'CASE201806240021088', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (38, N'CASE201806240022595', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (39, N'CASE201806240023333', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (40, N'CASE201806240023505', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (41, N'CASE201806240026141', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (42, N'CASE201806240034203', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (43, N'CASE201806240036403', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (44, N'CASE201806240037286', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (45, N'CASE201806240038474', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (46, N'CASE201806240039143', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (47, N'CASE201806240039573', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (48, N'CASE201806240040350', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (49, N'CASE201806240043277', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (50, N'CASE201806240055456', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (51, N'CASE201806240056135', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (52, N'CASE201806240056162', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (53, N'CASE201806240056315', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (54, N'CASE201806272256075', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (55, N'CASE201806272301493', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (56, N'CASE201807011224390', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (57, N'CASE201807011225281', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (58, N'CASE201807092234229', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (59, N'CASE201807092234435', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (60, N'CASE201807141029220', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (61, N'CASE201807141045074', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (62, N'CASE201807141052291', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (63, N'CASE201807141158559', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1060, N'CASE201808091537262', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1061, N'CASE201808091545311', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1062, N'CASE201808091546341', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1063, N'CASE201808091547245', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1064, N'CASE201808091548149', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1065, N'CASE201808091549145', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1066, N'CASE201808091549229', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1067, N'CASE201808091550487', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1068, N'CASE201808091555247', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1069, N'CASE201808091556043', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1070, N'CASE201808091556393', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1071, N'CASE201808091558162', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1072, N'CASE201808091931265', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x923e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1073, N'CASE201808111304080', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1074, N'CASE201808111308088', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1075, N'CASE201808112341327', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1076, N'CASE201808112354438', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1077, N'CASE201808121027402', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1078, N'CASE201808121029212', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1079, N'CASE201808121057399', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1080, N'CASE201808121723424', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1081, N'CASE201808152347216', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x983e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1082, N'CASE201808160028534', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1083, N'CASE201808160101586', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1084, N'CASE201809131226285', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1085, N'CASE201810021018400', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0xc83e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1086, N'CASE201810071430329', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0xcd3e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1087, N'CASE201810122228542', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1088, N'CASE92', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[NadiDetails] ([Id], [Case_ID], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1089, N'CASE93', N'test', N'test', N'test', N'साम', N'test', N'NA', CAST(0xd43e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[NadiDetails] OFF
GO

--Table dbo.NASYA_DETAILS

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[NASYA_DETAILS] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[SR_NO] [int] NULL,
	[DATE] [date] NULL,
	[OIL_GHEE] [nvarchar](5) NULL,
	[OIL_GHEE_NAME] [nvarchar](50) NULL,
	[DOSE] [nvarchar](50) NULL,
	[MASSAGE] [nvarchar](5) NULL,
	[MASSAGE_OIL] [nvarchar](50) NULL,
	[SYMPTOMS] [nvarchar](250) NULL,
	[CREATED_DATE] [date] NULL);
GO

SET IDENTITY_INSERT [dbo].[NASYA_DETAILS] ON
GO
INSERT INTO [dbo].[NASYA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (1, N'CASE201808121029212', 1, CAST(0xcc3e0b AS date), N'तुप', N'पंचगव्य घृत', N'12', N'होय', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[NASYA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (2, N'CASE201808121029212', 2, CAST(0xce3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[NASYA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (3, N'CASE201808121029212', 3, CAST(0xd03e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[NASYA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (4, N'CASE201808121029212', 4, CAST(0xd23e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[NASYA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (5, N'CASE201808121029212', 5, CAST(0xd43e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[NASYA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (6, N'CASE201808121029212', 6, CAST(0xd63e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[NASYA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (7, N'CASE201808121029212', 7, CAST(0xd83e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[NASYA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (8, N'CASE201808121029212', 8, CAST(0xda3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[NASYA_DETAILS] OFF
GO

--Table dbo.OilDetails

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[OilDetails] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[OIL_NAME] [nvarchar](250) NULL,
	[OIL_TYPE] [nvarchar](25) NULL,
	[OIL_FOR] [nvarchar](25) NULL,
	[OIL_FOR_TYPE] [nvarchar](25) NULL,
	[CREATED_DATE] [date] NULL CONSTRAINT [DF__OIL_DETAI__CREAT__5224328E] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[OilDetails] ON
GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (1, N'तीळ तेल', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (2, N'नीम तेल', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (3, N'नारायण तेल', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (4, N'एरंडेल तेल', N'', N'PANCHAKARMA', N'VIRECHANA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (5, N'तीळ तेल', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (6, N'नीम तेल', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (7, N'नारायण तेल', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (8, N'एरंडेल तेल', N'', N'PANCHAKARMA', N'VAMAN', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (9, N'तीळ तेल', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (10, N'नीम तेल', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (11, N'नारायण तेल', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (12, N'एरंडेल तेल', N'', N'PANCHAKARMA', N'NASYA', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (13, N'तीळ तेल', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (14, N'नीम तेल', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (15, N'नारायण तेल', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[OilDetails] ([ID], [OIL_NAME], [OIL_TYPE], [OIL_FOR], [OIL_FOR_TYPE], [CREATED_DATE])
	VALUES (16, N'एरंडेल तेल', N'', N'PANCHAKARMA', N'BASTI', CAST(0xdd3e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[OilDetails] OFF
GO

--Table dbo.PastHistory

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[PastHistory] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[Case_ID] [varchar](25) NULL,
	[MedicalHistory] [nvarchar](250) NULL,
	[DrugsHistory] [nvarchar](2) NULL,
	[FamilyHistory] [nvarchar](2) NULL,
	[CreatedDate] [date] NULL CONSTRAINT [DF__PastHisto__Creat__5BE2A6F2] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[PastHistory] ON
GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1, N'CASE201806231237116', N'asd', N'as', N'as', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (2, N'CASE201806231309318', N'asd', N'as', N'as', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (3, N'CASE201806231310254', N'asd', N'as', N'as', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (4, N'CASE201806231312060', N'asda', N'as', N'as', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (5, N'CASE201806240009456', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (6, N'CASE201806240018551', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (7, N'CASE201806240021088', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (8, N'CASE201806240022595', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (9, N'CASE201806240023333', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (10, N'CASE201806240023505', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (11, N'CASE201806240026141', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (12, N'CASE201806240034203', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (13, N'CASE201806240036403', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (14, N'CASE201806240037286', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (15, N'CASE201806240038474', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (16, N'CASE201806240039143', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (17, N'CASE201806240039573', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (18, N'CASE201806240040350', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (19, N'CASE201806240043277', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (20, N'CASE201806240055456', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (21, N'CASE201806240056135', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (22, N'CASE201806240056162', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (23, N'CASE201806240056315', N'', N'', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (24, N'CASE201806272256075', N'', N'', N'', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (25, N'CASE201806272301493', N'', N'', N'', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (26, N'CASE201807011224390', N'', N'', N'', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (27, N'CASE201807011225281', N'', N'', N'', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (28, N'CASE201807092234229', N'', N'', N'', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (29, N'CASE201807092234435', N'', N'', N'', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (30, N'CASE201807141029220', N'', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (31, N'CASE201807141045074', N'', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (32, N'CASE201807141052291', N'', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (33, N'CASE201807141158559', N'', N'', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1030, N'CASE201808111304080', N'', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1031, N'CASE201808111308088', N'', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1032, N'CASE201808112341327', N'', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1033, N'CASE201808112354438', N'', N'', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1034, N'CASE201808121027402', N'', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1035, N'CASE201808121029212', N'', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1036, N'CASE201808121057399', N'', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1037, N'CASE201808121723424', N'', N'', N'', CAST(0x953e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1038, N'CASE201808152347216', N'', N'', N'', CAST(0x983e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1039, N'CASE201808160028534', N'', N'', N'', CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1040, N'CASE201808160101586', N'', N'', N'', CAST(0x993e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1041, N'CASE201809131226285', N'test', N'te', N'te', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1042, N'CASE201810021018400', N'', N'', N'', CAST(0xc83e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1043, N'CASE201810071430329', N'', N'', N'', CAST(0xcd3e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1044, N'CASE201810122228542', N'4test', N'te', N'te', CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1045, N'CASE92', N'', N'', N'', CAST(0xd23e0b AS date))

GO
INSERT INTO [dbo].[PastHistory] ([ID], [Case_ID], [MedicalHistory], [DrugsHistory], [FamilyHistory], [CreatedDate])
	VALUES (1046, N'CASE93', N'', N'', N'', CAST(0xd43e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[PastHistory] OFF
GO

--Table dbo.Patient_Details

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[Patient_Details] (
	[Patient_ID] [int] NOT NULL IDENTITY (1, 1),
	[PatientName] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[Pin] [nvarchar](6) NULL,
	[BirthDate] [date] NULL,
	[Age] [int] NULL,
	[ConceptionPeriod] [nvarchar](15) NULL,
	[Gender] [nvarchar](6) NULL,
	[MobileNo] [nvarchar](12) NULL,
	[PhoneNo] [nvarchar](12) NULL,
	[Nadi] [nvarchar](25) NULL,
	[Mala] [nvarchar](25) NULL,
	[Mutra] [nvarchar](25) NULL,
	[Avastha] [nvarchar](15) NULL,
	[Prakruti] [nvarchar](15) NULL,
	[MensturalHistory] [nvarchar](250) NULL,
	[CreatedDate] [date] NULL CONSTRAINT [DF__Patient_D__Creat__182C9B23] DEFAULT (getdate()));
GO

SET IDENTITY_INSERT [dbo].[Patient_Details] ON
GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1, N'shashikant', N'Kirolokarwadi', N'Palus', N'416108', CAST(0x5c3e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x5c3e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (2, N'Pankaj', N'Kese', N'Karad', N'417205', CAST(0x5c3e0b AS date), 27, N'Septmber', N'Male', N'9145662140', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x5c3e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (3, N'Sagar', N'Daflapur', N'Jat', N'416385', CAST(0x5c3e0b AS date), 27, N'Septmber', N'Male', N'9850232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x5c3e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (4, N'Ravinfra Gawade', N'Baramati', N'Baramati', N'418256', CAST(0x5c3e0b AS date), 27, N'Septmber', N'Male', N'7895469852', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x5c3e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (5, N'test', N'test', N'test', N'416108', CAST(0x5c3e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x5c3e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (6, N'test', N'test', N'test', N'416108', CAST(0x5c3e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x5c3e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (7, N'test', N'test', N'test', N'416108', CAST(0x603e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x603e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (8, N'test', N'test', N'test', N'416108', CAST(0x603e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x603e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (9, N'test', N'test', N'test', N'416108', CAST(0x603e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x603e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (10, N'test', N'test', N'test', N'416108', CAST(0x603e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x603e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (11, N'test', N'test', N'test', N'416108', CAST(0x623e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (12, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (13, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (14, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (15, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (16, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (17, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (18, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (19, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (20, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (21, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (22, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (23, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x633e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (24, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (25, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (26, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (27, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (28, N'test', N'test', N'test', N'416108', CAST(0x633e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (29, N'test', N'test', N'test', N'416108', CAST(0x643e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'test', N'साम', N'test', N'', CAST(0x643e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (30, N'test', N'test', N'test', N'416108', CAST(0x653e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x653e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (31, N'test', N'test', N'test', N'416108', CAST(0x663e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x663e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (32, N'test', N'test', N'test', N'416108', CAST(0x663e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x663e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (33, N'test', N'test', N'test', N'416108', CAST(0x663e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x663e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (34, N'test', N'test', N'test', N'416108', CAST(0x663e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x663e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (35, N'test', N'test', N'test', N'416108', CAST(0x673e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (36, N'test', N'test', N'test', N'416108', CAST(0x673e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x673e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (37, N'test', N'test', N'test', N'416108', CAST(0x6b3e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x6b3e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (38, N'test', N'test', N'test', N'416108', CAST(0x703e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x703e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (39, N'test', N'test', N'test', N'416108', CAST(0x703e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x703e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (40, N'test', N'test', N'test', N'416108', CAST(0x733e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (41, N'test', N'test', N'test', N'416108', CAST(0x733e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x733e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (42, N'test', N'test', N'test', N'416108', CAST(0x783e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x783e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1042, N'test', N'test', N'test', N'416108', CAST(0x943e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0x943e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1043, N'test', N'test', N'test', N'416108', CAST(0xb53e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0xb53e0b AS date))

GO
INSERT INTO [dbo].[Patient_Details] ([Patient_ID], [PatientName], [Address], [City], [Pin], [BirthDate], [Age], [ConceptionPeriod], [Gender], [MobileNo], [PhoneNo], [Nadi], [Mala], [Mutra], [Avastha], [Prakruti], [MensturalHistory], [CreatedDate])
	VALUES (1044, N'test', N'test', N'test', N'416108', CAST(0xc83e0b AS date), 27, N'Septmber', N'Male', N'9890232469', N'9890232469', N'test', N'test', N'NA', N'साम', N'test', N'', CAST(0xc83e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[Patient_Details] OFF
GO

--Table dbo.RAKTAMOKSHANA_DETAILS

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[RAKTAMOKSHANA_DETAILS] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[SR_NO] [int] NULL,
	[DATE] [date] NULL,
	[PROCESS] [nvarchar](250) NULL,
	[SYMPTOMS] [nvarchar](250) NULL,
	[OTHER] [nvarchar](250) NULL,
	[CREATED_DATE] [date] NULL);
GO

SET IDENTITY_INSERT [dbo].[RAKTAMOKSHANA_DETAILS] ON
GO
INSERT INTO [dbo].[RAKTAMOKSHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [PROCESS], [SYMPTOMS], [OTHER], [CREATED_DATE])
	VALUES (1, N'CASE201808121029212', 1, CAST(0xe53e0b AS date), N'', N'', N'', CAST(0xe43e0b AS date))

GO
INSERT INTO [dbo].[RAKTAMOKSHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [PROCESS], [SYMPTOMS], [OTHER], [CREATED_DATE])
	VALUES (2, N'CASE201808121029212', 2, CAST(0xe73e0b AS date), N'', N'', N'', CAST(0xe43e0b AS date))

GO
INSERT INTO [dbo].[RAKTAMOKSHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [PROCESS], [SYMPTOMS], [OTHER], [CREATED_DATE])
	VALUES (3, N'CASE201808121029212', 3, CAST(0xe93e0b AS date), N'', N'', N'', CAST(0xe43e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[RAKTAMOKSHANA_DETAILS] OFF
GO

--Table dbo.UTTAR_BASTI_DETAILS

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[UTTAR_BASTI_DETAILS] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[SR_NO] [int] NULL,
	[DATE] [date] NULL,
	[MEDICINE] [nvarchar](5) NULL,
	[MEDICINE_NAME] [nvarchar](50) NULL,
	[DOSE] [nvarchar](50) NULL,
	[MASSAGE] [nvarchar](5) NULL,
	[MASSAGE_OIL] [nvarchar](50) NULL,
	[SYMPTOMS] [nvarchar](250) NULL,
	[DATTA] [nvarchar](250) NULL,
	[PRATYAGAMAN] [nvarchar](250) NULL,
	[CREATED_DATE] [date] NULL);
GO

SET IDENTITY_INSERT [dbo].[UTTAR_BASTI_DETAILS] ON
GO
INSERT INTO [dbo].[UTTAR_BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [MEDICINE], [MEDICINE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (1, N'CASE201808121029212', 1, CAST(0xdc3e0b AS date), N'तेल', N'तीळ तेल', N'12', N'होय', N'', N'12', N'11:00 PM', N'11:00 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[UTTAR_BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [MEDICINE], [MEDICINE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (2, N'CASE201808121029212', 2, CAST(0xdd3e0b AS date), N'चूर्ण', N'चूर्ण1', N'12', N'होय', N'', N'12', N'11:00 PM', N'11:00 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[UTTAR_BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [MEDICINE], [MEDICINE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (3, N'CASE201808121029212', 3, CAST(0xde3e0b AS date), N'', N'--', N'', N'', N'', N'', N'11:00 PM', N'11:00 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[UTTAR_BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [MEDICINE], [MEDICINE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (4, N'CASE201808121029212', 4, CAST(0xdf3e0b AS date), N'', N'--', N'', N'', N'', N'', N'11:00 PM', N'11:00 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[UTTAR_BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [MEDICINE], [MEDICINE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (5, N'CASE201808121029212', 5, CAST(0xe03e0b AS date), N'', N'--', N'', N'', N'', N'', N'11:00 PM', N'11:00 PM', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[UTTAR_BASTI_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [MEDICINE], [MEDICINE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [DATTA], [PRATYAGAMAN], [CREATED_DATE])
	VALUES (6, N'CASE201808121029212', 6, CAST(0xe13e0b AS date), N'', N'--', N'', N'', N'', N'', N'11:00 PM', N'11:00 PM', CAST(0xdd3e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[UTTAR_BASTI_DETAILS] OFF
GO

--Table dbo.VAMAN_DETAILS

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[VAMAN_DETAILS] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[SR_NO] [int] NULL,
	[DATE] [date] NULL,
	[OIL_GHEE] [nvarchar](5) NULL,
	[OIL_GHEE_NAME] [nvarchar](50) NULL,
	[DOSE] [nvarchar](50) NULL,
	[MASSAGE] [nvarchar](5) NULL,
	[MASSAGE_OIL] [nvarchar](50) NULL,
	[SYMPTOMS] [nvarchar](250) NULL,
	[CREATED_DATE] [date] NULL);
GO

SET IDENTITY_INSERT [dbo].[VAMAN_DETAILS] ON
GO
INSERT INTO [dbo].[VAMAN_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (1, N'CASE201808121029212', 1, CAST(0xd23e0b AS date), N'तुप', N'पंचगव्य  घृत', N'20', N'होय', N'नारायण तेल', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[VAMAN_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (2, N'CASE201808121029212', 2, CAST(0xd43e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[VAMAN_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (3, N'CASE201808121029212', 3, CAST(0xd63e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[VAMAN_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (4, N'CASE201808121029212', 4, CAST(0xd83e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[VAMAN_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (5, N'CASE201808121029212', 5, CAST(0xda3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[VAMAN_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (6, N'CASE201808121029212', 6, CAST(0xdc3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[VAMAN_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (7, N'CASE201808121029212', 7, CAST(0xde3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
INSERT INTO [dbo].[VAMAN_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (8, N'CASE201808121029212', 8, CAST(0xe03e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xdd3e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[VAMAN_DETAILS] OFF
GO

--Table dbo.VAMAN_PRADHAN_KARMA_DETAILS

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[VAMAN_PRADHAN_KARMA_DETAILS] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[PradhanKarmaDate] [date] NULL,
	[UatkleshaAhar] [nvarchar](50) NULL,
	[VamanDravya] [nvarchar](50) NULL,
	[SnehanSvedan] [nvarchar](50) NULL,
	[DudhapanTime] [nvarchar](50) NULL,
	[DudhpanQty] [nvarchar](50) NULL,
	[ChatanTime] [nvarchar](50) NULL,
	[ChatanQty] [nvarchar](50) NULL,
	[AkanthapanStart] [nvarchar](50) NULL,
	[SaivadhJal] [nvarchar](50) NULL,
	[Dhumpan] [nvarchar](50) NULL,
	[OilName] [nvarchar](50) NULL,
	[OilQty] [nvarchar](50) NULL,
	[MedicineName] [nvarchar](50) NULL,
	[MedicineQty] [nvarchar](50) NULL,
	[SnehanSvedanTime] [nvarchar](20) NULL,
	[CHATAN] [nvarchar](250) NULL,
	[AkanthanPan] [nvarchar](50) NULL,
	[SaivadhJalTime] [nvarchar](20) NULL);
GO

SET IDENTITY_INSERT [dbo].[VAMAN_PRADHAN_KARMA_DETAILS] ON
GO
INSERT INTO [dbo].[VAMAN_PRADHAN_KARMA_DETAILS] ([ID], [CASE_ID], [PradhanKarmaDate], [UatkleshaAhar], [VamanDravya], [SnehanSvedan], [DudhapanTime], [DudhpanQty], [ChatanTime], [ChatanQty], [AkanthapanStart], [SaivadhJal], [Dhumpan], [OilName], [OilQty], [MedicineName], [MedicineQty], [SnehanSvedanTime], [CHATAN], [AkanthanPan], [SaivadhJalTime])
	VALUES (1, N'CASE201808121029212', CAST(0xd13e0b AS date), N'test', N'test', N'NA', N'10:45 PM', N'test', N'10:45 PM', N'test', N'10:45 PM', N'test', N'test', NULL, NULL, NULL, NULL, N'10:30 PM', N'test', N'यष्टीफांट', N'10:45 PM')

GO
SET IDENTITY_INSERT [dbo].[VAMAN_PRADHAN_KARMA_DETAILS] OFF
GO

--Table dbo.VIRECHANA_DETAILS

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[VIRECHANA_DETAILS] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[SR_NO] [int] NULL,
	[DATE] [date] NULL,
	[OIL_GHEE] [nvarchar](5) NULL,
	[OIL_GHEE_NAME] [nvarchar](50) NULL,
	[DOSE] [nvarchar](50) NULL,
	[MASSAGE] [nvarchar](5) NULL,
	[MASSAGE_OIL] [nvarchar](50) NULL,
	[SYMPTOMS] [nvarchar](250) NULL,
	[CREATED_DATE] [date] NULL);
GO

SET IDENTITY_INSERT [dbo].[VIRECHANA_DETAILS] ON
GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (1, N'CASE201808121029212', 1, CAST(0xc93e0b AS date), N'तेल', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (2, N'CASE201808121029212', 2, CAST(0xcb3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (3, N'CASE201808121029212', 3, CAST(0xcd3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (4, N'CASE201808121029212', 4, CAST(0xcf3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (5, N'CASE201808121029212', 5, CAST(0xd13e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (6, N'CASE201808121029212', 6, CAST(0xd33e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (7, N'CASE201808121029212', 7, CAST(0xd53e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (8, N'CASE201808121029212', 8, CAST(0xd73e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (9, N'CASE93', 1, CAST(0xd53e0b AS date), N'तेल', N'--', N'', N'नाही', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (10, N'CASE93', 2, CAST(0xd73e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (11, N'CASE93', 3, CAST(0xd93e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (12, N'CASE93', 4, CAST(0xdb3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (13, N'CASE93', 5, CAST(0xdd3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (14, N'CASE93', 6, CAST(0xdf3e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (15, N'CASE93', 7, CAST(0xe13e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
INSERT INTO [dbo].[VIRECHANA_DETAILS] ([ID], [CASE_ID], [SR_NO], [DATE], [OIL_GHEE], [OIL_GHEE_NAME], [DOSE], [MASSAGE], [MASSAGE_OIL], [SYMPTOMS], [CREATED_DATE])
	VALUES (16, N'CASE93', 8, CAST(0xe33e0b AS date), N'', N'--', N'', N'', N'', N'', CAST(0xd43e0b AS date))

GO
SET IDENTITY_INSERT [dbo].[VIRECHANA_DETAILS] OFF
GO

--Table dbo.VIRECHANA_PRADHAN_KARMA_DETAILS

USE [SamyakDB]
GO

--Create table and its columns
CREATE TABLE [dbo].[VIRECHANA_PRADHAN_KARMA_DETAILS] (
	[ID] [int] NOT NULL IDENTITY (1, 1),
	[CASE_ID] [varchar](50) NULL,
	[PradhanKarmaDate] [date] NULL,
	[MedicineName] [nvarchar](50) NULL,
	[MedicineQty] [nvarchar](50) NULL,
	[Symptoms] [nvarchar](250) NULL,
	[VirechnaVeg] [nvarchar](50) NULL);
GO

SET IDENTITY_INSERT [dbo].[VIRECHANA_PRADHAN_KARMA_DETAILS] ON
GO
INSERT INTO [dbo].[VIRECHANA_PRADHAN_KARMA_DETAILS] ([ID], [CASE_ID], [PradhanKarmaDate], [MedicineName], [MedicineQty], [Symptoms], [VirechnaVeg])
	VALUES (1, N'CASE201808121029212', CAST(0xc83e0b AS date), N'', N'', N'', NULL)

GO
INSERT INTO [dbo].[VIRECHANA_PRADHAN_KARMA_DETAILS] ([ID], [CASE_ID], [PradhanKarmaDate], [MedicineName], [MedicineQty], [Symptoms], [VirechnaVeg])
	VALUES (2, N'CASE93', CAST(0xc83e0b AS date), N'', N'', N'', N'')

GO
SET IDENTITY_INSERT [dbo].[VIRECHANA_PRADHAN_KARMA_DETAILS] OFF
GO

--Executing Entities
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GET_FOLLOWUP_DETAILS]
 @ERROR_MESSAGE VARCHAR(205) OUTPUT
AS

BEGIN

SELECT top 10 f.ID FOLLOWUP_ID, p.Patient_ID PATIENT_ID,p.PatientName PATIENT_NAME,p.MobileNo MOBILE_NO, f.Case_ID CASE_ID,f.FollowUpFor FOLLOWUP_FOR
FROM FollowUpDetails f 
inner join Case_Details c 
on c.Case_ID=f.Case_ID 
inner join Patient_Details p
ON c.Patient_ID=p.Patient_ID
--WHERE FollowUpDate =CONVERT(DATE,GETDATE())
ORDER BY p.Patient_ID ASC;

END

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_NASYA_DETAILS]
@CASE_ID VARCHAR(50),
@SrNo INT, 
@Date DATE,
@OIL_GHEE NVARCHAR(5),
@OIL_GHEE_NAME NVARCHAR(50),
@DOSE NVARCHAR(20),
@MASSAGE NVARCHAR(50),
@MASSAGE_OIL NVARCHAR(20),
@SYMPTOMS NVARCHAR(250),
@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from [NASYA_DETAILS] WHERE [SR_NO]=@SrNo AND CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].[NASYA_DETAILS]
				   ([CASE_ID]
				   ,[SR_NO]
				   ,[Date]
				   ,[OIL_GHEE]
				   ,[OIL_GHEE_NAME]
				   ,[DOSE]
				   ,[MASSAGE]
				   ,[MASSAGE_OIL]
				   ,[SYMPTOMS]
				   ,[CREATED_DATE])
			 VALUES
				   (@CASE_ID, 
				   @SrNo, 
				   convert(date, @Date, 105) ,				  
				   @OIL_GHEE, 
				   @OIL_GHEE_NAME,  
				   @DOSE,  
				   @MASSAGE,  
				   @MASSAGE_OIL,  
				   @SYMPTOMS,  
				   GETDATE());
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].[NASYA_DETAILS]	 SET 		  
				   [Date]= convert(date, @Date, 105)
				   ,[OIL_GHEE]=@OIL_GHEE
				   ,[OIL_GHEE_NAME]=@OIL_GHEE_NAME
				   ,[DOSE]=@DOSE
				   ,[MASSAGE]=@MASSAGE
				   ,[MASSAGE_OIL]=@MASSAGE_OIL
				   ,[SYMPTOMS]=@SYMPTOMS
				   ,[CREATED_DATE]=GETDATE()
			WHERE SR_NO=@SrNo AND CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 
	PRINT(ERROR_MESSAGE ( )   );
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 30/10/2017
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_NASYA_DATA]
	@CASE_ID VARCHAR(50),	
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT ID
      ,CASE_ID
      ,SR_NO
	  , Convert(varchar,Date,105) [DATE]
      ,OIL_GHEE
      ,OIL_GHEE_NAME
      ,DOSE
      ,MASSAGE
      ,MASSAGE_OIL
      ,SYMPTOMS
      ,CREATED_DATE FROM NASYA_DETAILS CD
		WHERE CD.CASE_ID=@CASE_ID;	


		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END










GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_LogApplicationError]
  @module NVARCHAR(50),
  @process_name NVARCHAR(20),
  @error_message NVARCHAR(MAX),
  @stack_trace  NVARCHAR(MAX)
AS
BEGIN  

 INSERT INTO application_error_log
 (  
  module,
  process_name,
  error_message,
  stack_trace
  )
 VALUES( 
  @module,
  @process_name,
  @error_message,
  @stack_trace);
END

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_RAKTAMOKSHANA_DETAILS]
@CASE_ID VARCHAR(50),
@SrNo INT, 
@Date DATE,
@PROCESS NVARCHAR(250),
@SYMPTOMS NVARCHAR(250),
@OTHER NVARCHAR(250),
@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from [RAKTAMOKSHANA_DETAILS] WHERE [SR_NO]=@SrNo AND CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].[RAKTAMOKSHANA_DETAILS]
				   ([CASE_ID]
				   ,[SR_NO]
				   ,[Date]
				   ,[PROCESS]	
				   ,[SYMPTOMS]
				   ,[OTHER]
				   ,[CREATED_DATE])
			 VALUES
				   (@CASE_ID, 
				   @SrNo, 
				   convert(date, @Date, 105) ,			  
				   @PROCESS,
				   @SYMPTOMS,
				   @OTHER , 
				   GETDATE());
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].[RAKTAMOKSHANA_DETAILS]	 SET 		  
				   [Date]= convert(date, @Date, 105)
				   ,[PROCESS]=@PROCESS				  
				   ,[SYMPTOMS]=@SYMPTOMS
				   ,[OTHER]=@OTHER
				   ,[CREATED_DATE]=GETDATE()
			WHERE SR_NO=@SrNo AND CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 
	PRINT(ERROR_MESSAGE ( )   );
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 30/10/2017
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_RAKTAMOKSHANA_DATA]
	@CASE_ID VARCHAR(50),	
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT ID
      ,CASE_ID
      ,SR_NO
	  , Convert(varchar,Date,105) [DATE]
	  ,PROCESS
      ,SYMPTOMS
	  ,OTHER
      ,CREATED_DATE FROM RAKTAMOKSHANA_DETAILS CD
		WHERE CD.CASE_ID=@CASE_ID;	


		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END










GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_CallProcedureLog]
  @ProcedureID INT,
  @ProcedureName NVARCHAR(50),
  @ErrorCode NVARCHAR(20),
  @ErrorLine NVARCHAR(20),
  @ErrorMessage NVARCHAR(MAX),
  @Description  NVARCHAR(MAX)
AS
BEGIN  

 INSERT INTO Error_Log
 (  
  ProcedureID,
  ProcedureName,
  ErrorCode,
  ErrorLine,
  ErrorMessage,
  Description
 )
 VALUES( 
  @ProcedureID,
  @ProcedureName,
  @ErrorCode,
  @ErrorLine,
  @ErrorMessage,
  @Description);
END

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 2 Oct 2017
-- Description:	Process for the login in to application
-- =============================================
CREATE PROCEDURE [dbo].[SP_LOGIN_PROCESS]
	@USERNAME VARCHAR(100),@PASSWORD VARCHAR(250),
	@LOGINPASS BIT OUTPUT
AS

BEGIN
	DECLARE @vCnt int;
	
	SET NOCOUNT ON;
	BEGIN TRY

	SET @vCnt=(SELECT COUNT(USER_NAME) FROM app_users 
	WHERE USER_NAME=@USERNAME AND UPPER(PASSWORD)=@PASSWORD);

	IF(@vCnt>0)
	BEGIN
		SET @LOGINPASS=1;
	END
	ELSE
	BEGIN
		SET @LOGINPASS=0;	
	END;
	END TRY
	BEGIN CATCH 
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  1,'SP_LOGIN_PROCESS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;
	END CATCH;

END;





GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 16/06/2018
-- Description:	Used to insert thr record and generare case for the patient
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_PERSONAL_DETAILS]
	@OPERAION VARCHAR(10),
	@PATIENT_NAME NVARCHAR(100),
	@ADDRESS NVARCHAR(100),
	@CITY NVARCHAR(100),
	@PIN NUMERIC(6,0),
	@BIRTHDATE DATE,
	@CONCEPTION_PERIOD NVARCHAR(15),
	@AGE NUMERIC(4,1),
	@GENDER NVARCHAR(6),
	@MOBILE_NO NVARCHAR(12),
	@PHONE_NO NVARCHAR(12),
	@NADI NVARCHAR(15),
	@MALA NVARCHAR(15),
	@MUTRA NVARCHAR(15),
	@AVASHTA NVARCHAR(15),
	@PRAKURTI NVARCHAR(15),
	@MENSTRUAL_HISTORY NVARCHAR(250),
	@CASEID  INT OUTPUT,
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		IF(@OPERAION='I')
		BEGIN
			INSERT INTO Patient_Details(
				  PatientName,Address,City,Pin ,BirthDate ,ConceptionPeriod,Age 
             ,Gender,MobileNo,PhoneNo,Nadi,Mala,Mutra,Avastha,Prakruti,MensturalHistory)
			VALUES(
				@PATIENT_NAME,@ADDRESS,@CITY,@PIN,@BIRTHDATE,@CONCEPTION_PERIOD,@AGE,@GENDER,
				@MOBILE_NO,@PHONE_NO,@NADI,@MALA,@MUTRA,@AVASHTA,@PRAKURTI,@MENSTRUAL_HISTORY);	
			
			SET @CASEID=(SELECT MAX(Patient_ID) FROM Patient_Details)	
			SET @ERROR_MESSAGE='TRUE';	
		END
		ELSE 
		BEGIN
			SET @CASEID=0;
			SET @ERROR_MESSAGE='FALSE';
		END
			
	END TRY
	BEGIN CATCH 
			SET @CASEID=0;
			SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  2,'INSERT_PERSONAL_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;
	
END






GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[SEARCH_PATIENTS]
@NAMESEARCH VARCHAR(50),
@CONTACTSEARCH VARCHAR(50),
@CITYSEARCH VARCHAR(50),
@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN	
		
	DECLARE @QRY  VARCHAR(MAX);

	--SET @NAMESEARCH ='sha';
	--SET @CONTACTSEARCH='';
	--SET @CITYSEARCH= 'p';
	BEGIN TRY	
		SET @QRY ='SELECT TOP 10 PATIENT_ID, PATIENTNAME,ADDRESS,CITY,CONVERT(VARCHAR(11),BIRTHDATE,103) BIRTHDATE,PIN,
				   MOBILENO,AGE FROM PATIENT_DETAILS WHERE ';

		IF @NAMESEARCH !='' BEGIN
			SET @QRY=@QRY+' PATIENTNAME  LIKE ''%'+@NAMESEARCH+'%''';
		END;
		IF @CONTACTSEARCH !='' BEGIN
			IF @NAMESEARCH!=''
				SET @QRY=@QRY+' AND MOBILENO  LIKE ''%'+@NAMESEARCH+'%''';
			ELSE 
				SET @QRY=@QRY+' MOBILENO  LIKE ''%'+@NAMESEARCH+'%''';
		END;
		IF @CITYSEARCH !='' BEGIN
			IF @NAMESEARCH!='' OR @CONTACTSEARCH!=''
				SET @QRY=@QRY+' AND CITY  LIKE ''%'+@CITYSEARCH+'%''';
			ELSE 
				SET @QRY=@QRY+'CITY  LIKE ''%'+@CITYSEARCH+'%''';
		END;
		print @QRY;
		EXECUTE(@QRY);
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  3,'SEARCH_PATIENTS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;
END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GENERATE_CASE_ID]	
	@CASE_ID NVARCHAR(100) OUTPUT,
	@ERROR_MESSAGE VARCHAR(250) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		
			DECLARE @MAXCASE_ID INT;

			SET @MAXCASE_ID =(SELECT COUNT(CASE_ID)+1 FROM Case_Details);
			
			SET @CASE_ID='CASE'+CONVERT(VARCHAR(20),@MAXCASE_ID);				
							
			SET @ERROR_MESSAGE='TRUE';	
	
			
	END TRY
	BEGIN CATCH 
			SET @ERROR_MESSAGE='FALSE';

		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  4,'GENERATE_CASE',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;
	
END






GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 16/06/2018
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_PATIENT_DETAILS]
	@Patient_ID INT,	
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT TOP 1 PatientName,Address,City,Pin ,CONVERT(VARCHAR(11),BirthDate,103) BirthDate ,ConceptionPeriod,Age 
             ,Gender,MobileNo,PhoneNo,Nadi,Mala,Mutra,Avastha,Prakruti,MensturalHistory FROM Patient_Details PD	
		WHERE PD.Patient_ID=@Patient_ID;	
				
		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  3,'FETCH_PATIENT_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;

END







GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[INSERT_MEDICINE_DETAILS]	
	@OPERAION VARCHAR(10),
	@CASE_ID NVARCHAR(25),
	@MEDICINE NVARCHAR(MAX),
	@TYPE NVARCHAR(15),
    @DURATION NVARCHAR(10),
    @FREQUENCY NVARCHAR(15),
    @WHENTOTAKE NVARCHAR(25),
    @WITHTOTAKE NVARCHAR(25),
    @QUANTITY NVARCHAR(25),
    @FOLLOWUREQUIRED NVARCHAR(5),
    @FOLLOWUDATE DATE,
	@ERROR_MESSAGE NVARCHAR(250) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		
		IF(@OPERAION='I')
		BEGIN
			
			INSERT INTO [dbo].[FollowUpDetails]
           ([Case_ID]
           ,[FollowUpRequired]
           ,[FollowUpFor]
           ,[FollowUpDate]
           ,[FollowUpDoneDate]
           ,[FollowUpNumber])
     VALUES
           (@CASE_ID
           ,@FOLLOWUREQUIRED
           ,'MEDICINE'
           ,@FOLLOWUDATE
           ,GETDATE()
           ,0);
	
	INSERT INTO [dbo].[MedicineDetails]
           ([Case_ID],
			[MedicineName] ,
			[MedicineType] ,
			[MedicineDuration] ,
			[MedicineFrequency] ,
			[MedicineWhenToTake],
			[MedicineWithToTake] ,
			[MedicineQuantity],
			[FollowuRequired] ,
			[FollowuDate] )
     VALUES
           (@CASE_ID,@MEDICINE,@TYPE,@DURATION,@FREQUENCY,@WHENTOTAKE,@WITHTOTAKE,@QUANTITY,@FOLLOWUREQUIRED,@FOLLOWUDATE);

			SET @ERROR_MESSAGE='TRUE';	
		END
		ELSE 
		BEGIN
			SET @ERROR_MESSAGE='FALSE';
		END	
	
			
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  6,'INSERT_MEDICINE_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;
	END CATCH;
	
END






GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_BASTI_DETAILS]
@CASE_ID VARCHAR(50),
@SrNo INT, 
@Date DATE,
@OIL_GHEE NVARCHAR(5),
@OIL_GHEE_NAME NVARCHAR(50),
@DOSE NVARCHAR(20),
@MASSAGE NVARCHAR(50),
@MASSAGE_OIL NVARCHAR(20),
@SYMPTOMS NVARCHAR(250),
@DATTA NVARCHAR(20),
@PRATYAGAMAN NVARCHAR(250),
@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from [BASTI_DETAILS] WHERE [SR_NO]=@SrNo AND CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].[BASTI_DETAILS]
				   ([CASE_ID]
				   ,[SR_NO]
				   ,[Date]
				   ,[OIL_GHEE]
				   ,[OIL_GHEE_NAME]
				   ,[DOSE]
				   ,[MASSAGE]
				   ,[MASSAGE_OIL]
				   ,[SYMPTOMS]
				   ,[DATTA]
				   ,[PRATYAGAMAN]
				   ,[CREATED_DATE])
			 VALUES
				   (@CASE_ID, 
				   @SrNo, 
				   convert(date, @Date, 105) ,				  
				   @OIL_GHEE, 
				   @OIL_GHEE_NAME,  
				   @DOSE,  
				   @MASSAGE,  
				   @MASSAGE_OIL,  
				   @SYMPTOMS,
				   @DATTA,
				   @PRATYAGAMAN ,
				   GETDATE());
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].[BASTI_DETAILS]	 SET 		  
				   [Date]= convert(date, @Date, 105)
				   ,[OIL_GHEE]=@OIL_GHEE
				   ,[OIL_GHEE_NAME]=@OIL_GHEE_NAME
				   ,[DOSE]=@DOSE
				   ,[MASSAGE]=@MASSAGE
				   ,[MASSAGE_OIL]=@MASSAGE_OIL
				   ,[SYMPTOMS]=@SYMPTOMS
				   ,[DATTA]=@DATTA
				   ,[PRATYAGAMAN]=@PRATYAGAMAN
				   ,[CREATED_DATE]=GETDATE()
			WHERE SR_NO=@SrNo AND CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 
	PRINT(ERROR_MESSAGE ( )   );
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[GENERATE_CASE]	
	@CASE_ID NVARCHAR(100),
	@PATIENT_ID NVARCHAR(100),
	@ERROR_MESSAGE VARCHAR(250) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		
			INSERT INTO Case_Details(
				  Case_ID,Patient_ID)
			VALUES(
				@CASE_ID,@PATIENT_ID);	
							
			SET @ERROR_MESSAGE='TRUE';	
	
			
	END TRY
	BEGIN CATCH 
			SET @ERROR_MESSAGE='FALSE';

		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  4,'GENERATE_CASE',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;
	
END






GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[INSERT_NADI_DETAILS]	
	@OPERAION VARCHAR(10),
	@CASE_ID VARCHAR(25),
	@NADI NVARCHAR(15),
	@MALA NVARCHAR(15),
	@MUTRA NVARCHAR(15),
	@AVASTHA NVARCHAR(15),
	@PRAKRUTI NVARCHAR(15),
	@MENSTURALHISTORY NVARCHAR(250),
	@ERROR_MESSAGE NVARCHAR(250) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		
		IF(@OPERAION='I')
		BEGIN
			INSERT INTO NadiDetails(
				  Case_ID,Nadi,Mala,Mutra,Avastha,Prakruti,MensturalHistory,CreatedDate)
			VALUES(
				@CASE_ID,@NADI,@MALA,@MUTRA,@AVASTHA,@PRAKRUTI,@MENSTURALHISTORY,GETDATE());	
			
			SET @ERROR_MESSAGE='TRUE';	
		END
		ELSE 
		BEGIN
			SET @ERROR_MESSAGE='FALSE';
		END	
	
			
	END TRY
	BEGIN CATCH 
			SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  5,'INSERT_NADI_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;
	
END






GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 16/06/2018
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[GET_MEDICINES]
	@SEARCH NVARCHAR(25),	
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
	IF @SEARCH!='NULL' BEGIN
		SELECT * FROM MedicineMaster WHERE MEDICINE_NAME LIKE '%' + @SEARCH + '%';
				
		SET @ERROR_MESSAGE='TRUE';
		END;
	ELSE BEGIN
		SELECT TOP 10 * FROM MedicineMaster;
	END;
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  3,'FETCH_PATIENT_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;

END







GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GET_MEDICINES_BY_TYPE]
@TYPE NVARCHAR(50),
@MEDICINE_FOR NVARCHAR(50),
@MEDICINE_FOR_TYPE NVARCHAR(50),
@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN	
		
	DECLARE @QRY  VARCHAR(MAX);

	--SET @NAMESEARCH ='sha';
	--SET @CONTACTSEARCH='';
	--SET @CITYSEARCH= 'p';
	BEGIN TRY	
		SET @QRY ='SELECT  MEDICINE_NAME FROM MedicineMaster WHERE ';

		IF @TYPE !='' BEGIN
			SET @QRY=@QRY+' MEDICINE_TYPE  LIKE ''%'+@TYPE+'%''';
		END;
		IF @MEDICINE_FOR !='' BEGIN
			IF @TYPE!=''
				SET @QRY=@QRY+' AND MEDICINE_FOR  LIKE ''%'+@MEDICINE_FOR+'%''';
			ELSE 
				SET @QRY=@QRY+' MEDICINE_FOR  LIKE ''%'+@MEDICINE_FOR+'%''';
		END;
		IF @MEDICINE_FOR_TYPE !='' BEGIN
			IF @TYPE!='' OR @MEDICINE_FOR!=''
				SET @QRY=@QRY+' AND MEDICINE_FOR_TYPE  LIKE ''%'+@MEDICINE_FOR_TYPE+'%''';
			ELSE 
				SET @QRY=@QRY+'MEDICINE_FOR_TYPE  LIKE ''%'+@MEDICINE_FOR_TYPE+'%''';
		END;
		print @QRY;
		EXECUTE(@QRY);
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  3,'SEARCH_PATIENTS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;
END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_UTTAR_BASTI_DETAILS]
@CASE_ID VARCHAR(50),
@SrNo INT, 
@Date DATE,
@MEDICINE NVARCHAR(5),
@MEDICINE_NAME NVARCHAR(50),
@DOSE NVARCHAR(20),
@MASSAGE NVARCHAR(50),
@MASSAGE_OIL NVARCHAR(20),
@SYMPTOMS NVARCHAR(250),
@DATTA NVARCHAR(20),
@PRATYAGAMAN NVARCHAR(250),
@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from [UTTAR_BASTI_DETAILS] WHERE [SR_NO]=@SrNo AND CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].[UTTAR_BASTI_DETAILS]
				   ([CASE_ID]
				   ,[SR_NO]
				   ,[Date]
				   ,[MEDICINE]
				   ,[MEDICINE_NAME]
				   ,[DOSE]
				   ,[MASSAGE]
				   ,[MASSAGE_OIL]
				   ,[SYMPTOMS]
				   ,[DATTA]
				   ,[PRATYAGAMAN]
				   ,[CREATED_DATE])
			 VALUES
				   (@CASE_ID, 
				   @SrNo, 
				   convert(date, @Date, 105) ,				  
				   @MEDICINE, 
				   @MEDICINE_NAME,  
				   @DOSE,  
				   @MASSAGE,  
				   @MASSAGE_OIL,  
				   @SYMPTOMS,
				   @DATTA,
				   @PRATYAGAMAN ,
				   GETDATE());
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].[UTTAR_BASTI_DETAILS]	 SET 		  
				   [Date]= convert(date, @Date, 105)
				   ,[MEDICINE]=@MEDICINE
				   ,[MEDICINE_NAME]=@MEDICINE_NAME
				   ,[DOSE]=@DOSE
				   ,[MASSAGE]=@MASSAGE
				   ,[MASSAGE_OIL]=@MASSAGE_OIL
				   ,[SYMPTOMS]=@SYMPTOMS
				   ,[DATTA]=@DATTA
				   ,[PRATYAGAMAN]=@PRATYAGAMAN
				   ,[CREATED_DATE]=GETDATE()
			WHERE SR_NO=@SrNo AND CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 
	PRINT(ERROR_MESSAGE ( )   );
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 30/10/2017
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_BASTI_DATA]
	@CASE_ID VARCHAR(50),	
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT ID
      ,CASE_ID
      ,SR_NO
	  , Convert(varchar,Date,105) [DATE]
      ,OIL_GHEE
      ,OIL_GHEE_NAME
      ,DOSE
      ,MASSAGE
      ,MASSAGE_OIL
      ,SYMPTOMS
	  ,DATTA,
	  PRATYAGAMAN
      ,CREATED_DATE FROM BASTI_DETAILS CD
		WHERE CD.CASE_ID=@CASE_ID;	


		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END










GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 30/10/2017
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_UTTAR_BASTI_DATA]
	@CASE_ID VARCHAR(50),	
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT ID
      ,CASE_ID
      ,SR_NO
	  , Convert(varchar,Date,105) [DATE]
      ,MEDICINE
      ,MEDICINE_NAME
      ,DOSE
      ,MASSAGE
      ,MASSAGE_OIL
      ,SYMPTOMS
	  ,DATTA,
	  PRATYAGAMAN
      ,CREATED_DATE FROM UTTAR_BASTI_DETAILS CD
		WHERE CD.CASE_ID=@CASE_ID;	


		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END










GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 14/12/2017
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_GHEE_DETAILS]
	@GHEE_FOR VARCHAR(25),	
	@GHEE_FOR_TYPE VARCHAR(25),
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT GHEE_NAME FROM GheeDetails GD
		WHERE GD.GHEE_FOR=@GHEE_FOR AND GD.GHEE_FOR_TYPE=@GHEE_FOR_TYPE ;		

		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 14/12/2017
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_OIL_DETAILS]
	@OIL_FOR VARCHAR(25),	
	@OIL_FOR_TYPE VARCHAR(25),
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT OIL_NAME FROM OilDetails OD
		WHERE OD.OIL_FOR=@OIL_FOR AND OD.OIL_FOR_TYPE=@OIL_FOR_TYPE ;		

		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END


GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[INSERT_COMPLAINT_DETAILS]	
	@OPERAION VARCHAR(10),
	@CASE_ID VARCHAR(25),
	@COMPLAINT NVARCHAR(250),
	@DURATIONYEAR NVARCHAR(2),
	@DURATIONMONTH NVARCHAR(2),
	@DURATIONDAYS NVARCHAR(2),
	@ERROR_MESSAGE NVARCHAR(250) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		
		IF(@OPERAION='I')
		BEGIN
			INSERT INTO ComplaintDetails(
				  Case_ID,Complaint,DUrationYear,DurationMonth,DurationDays,CreatedDate)
			VALUES(
				@CASE_ID,@COMPLAINT,@DURATIONYEAR,@DURATIONMONTH,@DURATIONDAYS,GETDATE());	
			
			SET @ERROR_MESSAGE='TRUE';	
		END
		ELSE 
		BEGIN
			SET @ERROR_MESSAGE='FALSE';
		END	
	
			
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  6,'INSET_COMPAINT_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;
	END CATCH;
	
END



GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[INSERT_PAST_HISTORY_DETAILS]	
	@OPERAION VARCHAR(10),
	@CASE_ID VARCHAR(25),
	@MEDICALHISTORY NVARCHAR(250),
	@DRUGSHISTORY NVARCHAR(2),
	@FAMILYHISTORY NVARCHAR(2),
	@ERROR_MESSAGE NVARCHAR(250) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		
		IF(@OPERAION='I')
		BEGIN
			INSERT INTO PastHistory(
				  Case_ID,MedicalHistory,DrugsHistory,FamilyHistory,CreatedDate)
			VALUES(
				@CASE_ID,@MEDICALHISTORY,@DRUGSHISTORY,@FAMILYHISTORY,GETDATE());	
			
			SET @ERROR_MESSAGE='TRUE';	
		END
		ELSE 
		BEGIN
			SET @ERROR_MESSAGE='FALSE';
		END	
	
			
	END TRY
	BEGIN CATCH 
			SET @ERROR_MESSAGE='FALSE';

		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  7,'INSERT_PAST_HISTORY_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;
	
END






GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_VAMAN_DETAILS]
@CASE_ID VARCHAR(50),
@SrNo INT, 
@Date DATE,
@OIL_GHEE NVARCHAR(5),
@OIL_GHEE_NAME NVARCHAR(50),
@DOSE NVARCHAR(20),
@MASSAGE NVARCHAR(50),
@MASSAGE_OIL NVARCHAR(20),
@SYMPTOMS NVARCHAR(250),
@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from [VAMAN_DETAILS] WHERE [SR_NO]=@SrNo AND CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].[VAMAN_DETAILS]
				   ([CASE_ID]
				   ,[SR_NO]
				   ,[Date]
				   ,[OIL_GHEE]
				   ,[OIL_GHEE_NAME]
				   ,[DOSE]
				   ,[MASSAGE]
				   ,[MASSAGE_OIL]
				   ,[SYMPTOMS]
				   ,[CREATED_DATE])
			 VALUES
				   (@CASE_ID, 
				   @SrNo, 
				   convert(date, @Date, 105) ,				  
				   @OIL_GHEE, 
				   @OIL_GHEE_NAME,  
				   @DOSE,  
				   @MASSAGE,  
				   @MASSAGE_OIL,  
				   @SYMPTOMS,  
				   GETDATE());
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].[VAMAN_DETAILS]	 SET 		  
				   [Date]= convert(date, @Date, 105)
				   ,[OIL_GHEE]=@OIL_GHEE
				   ,[OIL_GHEE_NAME]=@OIL_GHEE_NAME
				   ,[DOSE]=@DOSE
				   ,[MASSAGE]=@MASSAGE
				   ,[MASSAGE_OIL]=@MASSAGE_OIL
				   ,[SYMPTOMS]=@SYMPTOMS
				   ,[CREATED_DATE]=GETDATE()
			WHERE SR_NO=@SrNo AND CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 
	PRINT(ERROR_MESSAGE ( )   );
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 30/10/2017
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_VAMAN_DATA]
	@CASE_ID VARCHAR(50),	
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT ID
      ,CASE_ID
      ,SR_NO
	  , Convert(varchar,Date,105) [DATE]
      ,OIL_GHEE
      ,OIL_GHEE_NAME
      ,DOSE
      ,MASSAGE
      ,MASSAGE_OIL
      ,SYMPTOMS
      ,CREATED_DATE FROM VAMAN_DETAILS CD
		WHERE CD.CASE_ID=@CASE_ID;	


		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END










GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_VAMAN_PRADHANKARMA_DETAILS]
@CASE_ID VARCHAR(50),
@PRADHANKARMADATE DATE ,
@UATKLESHAAHAR NVARCHAR(50),
@VAMANDRAVYA NVARCHAR(50),
@SNEHANSVEDANTIME NVARCHAR(50),
@SNEHANSVEDAN NVARCHAR(50),
@DUDHAPANTIME NVARCHAR(50),
@DUDHPANQTY NVARCHAR(50),
@CHATAN NVARCHAR(50),
@CHATANTIME NVARCHAR(50),
@CHATANQTY NVARCHAR(50),
@AKANTHAPAN NVARCHAR(50),
@AKANTHAPANSTART NVARCHAR(50),
@SAIVADHJAL NVARCHAR(50),
@SAIVADHJALTIME NVARCHAR(50),
@DHUMPAN NVARCHAR(50),
@ERROR_MESSAGE VARCHAR(250) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from [VAMAN_PRADHAN_KARMA_DETAILS] WHERE  CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].[VAMAN_PRADHAN_KARMA_DETAILS]
           ([CASE_ID]
           ,[PradhanKarmaDate]
           ,[UatkleshaAhar]
           ,[VamanDravya]
           ,[SnehanSvedan]
           ,[DudhapanTime]
           ,[DudhpanQty]
           ,[ChatanTime]
           ,[ChatanQty]
           ,[AkanthapanStart]
           ,[SaivadhJal]
           ,[Dhumpan]          
		   ,[SnehanSvedanTime]
		   ,[CHATAN]
		   ,[AkanthanPan]
		   ,[SaivadhJalTime])
			 VALUES
				   (@CASE_ID, 
					@PRADHANKARMADATE ,
					@UATKLESHAAHAR ,
					@VAMANDRAVYA ,
					@SNEHANSVEDAN ,
					@DUDHAPANTIME ,
					@DUDHPANQTY ,
					@CHATANTIME ,
					@CHATANQTY ,
					@AKANTHAPANSTART ,
					@SAIVADHJAL ,
					@DHUMPAN ,
					@SNEHANSVEDANTIME,
					@CHATAN,
					@AKANTHAPAN,
					@SAIVADHJALTIME);
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].[VAMAN_PRADHAN_KARMA_DETAILS]	 SET 		  
				   [PradhanKarmaDate]  = @PRADHANKARMADATE 
           ,[UatkleshaAhar]    		   = @UATKLESHAAHAR 
           ,[VamanDravya]			   = @VAMANDRAVYA 
           ,[SnehanSvedan]			   = @SNEHANSVEDAN 
           ,[DudhapanTime]			   = @DUDHAPANTIME 
           ,[DudhpanQty]			   = @DUDHPANQTY 
           ,[ChatanTime]			   = @CHATANTIME 
           ,[ChatanQty]				   = @CHATANQTY 
           ,[AkanthapanStart]		   = @AKANTHAPANSTART 
           ,[SaivadhJal]			   = @SAIVADHJAL 
           ,[Dhumpan]				   = @DHUMPAN 
		   ,[SnehanSvedanTime]		   = @SNEHANSVEDANTIME	
		   ,[CHATAN]				   = @CHATAN
		   ,[AkanthanPan]			   = @AKANTHAPAN
		   ,[SaivadhJalTime]		   = @SAIVADHJALTIME	
			WHERE  CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 	
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  6,'INSERT_VAMAN_PRADHANKARMA_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_DIAGNOSIS_DETAILS]
@OPERAION VARCHAR(2),
@CASE_ID VARCHAR(50),
@RUGNABAL       NVARCHAR(250),
@VYADHIBAL	   NVARCHAR(250),
@VAAT 		   NVARCHAR(250),
@PITTA 		   NVARCHAR(250),
@COUGH 		   NVARCHAR(250),
@DOSHA 		   NVARCHAR(250),
@STROTAS 	   NVARCHAR(250),
@AVASTHA 	   NVARCHAR(250),
@JATHRAAGNI 	   NVARCHAR(250),
@DWHTAAGNI	   NVARCHAR(250),
@MAHABHUTAAGNI  NVARCHAR(250),
@VYAHINIDAN 	   NVARCHAR(250),
@ERROR_MESSAGE VARCHAR(250) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from DiagnosisDetails WHERE  CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].DiagnosisDetails
           ([CASE_ID]
           ,[Rugnabal]
           ,[VyadhiBal]
           ,[Vaat]
           ,[Pitta]
           ,[Cough]
           ,[Dosha]
           ,[Strotas]
           ,[Avastha]
           ,[JathraAgni]
           ,[DwhtaAgni]
           ,[MahaBhutaAgni]
           ,[VyahiNidan]
           ,[Created_Date])
			 VALUES
				   (@CASE_ID, 
					@RUGNABAL    , 
					@VYADHIBAL	 , 
					@VAAT ,		  
					@PITTA 	,	  
					@COUGH 	,	  
					@DOSHA 	,	  
					@STROTAS ,	  
					@AVASTHA 	,  
					@JATHRAAGNI ,	
					@DWHTAAGNI	,  
					@MAHABHUTAAGNI,
					@VYAHINIDAN,
					GETDATE()
					);
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].DiagnosisDetails	 SET 		  
					 [RUGNABAL]			= @RUGNABAL    
					,[VYADHIBAL]		= @VYADHIBAL	  
					,[VAAT]				= @VAAT 		  
					,[PITTA]			= @PITTA 		  
					,[COUGH]			= @COUGH 		  
					,[DOSHA]			= @DOSHA 		  
					,[STROTAS]			= @STROTAS 	  
					,[AVASTHA]			= @AVASTHA 	  
					,[JATHRAAGNI]		= @JATHRAAGNI 	
					,[DWHTAAGNI]		= @DWHTAAGNI	  
					,[MAHABHUTAAGNI]	= @MAHABHUTAAGNI
					,[VYAHINIDAN]		= @VYAHINIDAN
			
			WHERE  CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 	
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  6,'INSERT_DIAGNOSIS_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[INSERT_DAILY_ROUTINE_DETAILS]	
	@OPERAION VARCHAR(10),
	@CASE_ID VARCHAR(25),
	@WAKEUPTIME NVARCHAR(10),
	@WATERBEFORETEA NVARCHAR(15),
	@WATERQUANTITY NVARCHAR(25),
	@MORNINGDRINK NVARCHAR(25),
	@DIVASVAAP NVARCHAR(10),
	@NATUREOFWORK NVARCHAR(25),
	@WORKINGHOURS NVARCHAR(5),
	@BREAKFAST NVARCHAR(250),
	@ERROR_MESSAGE NVARCHAR(250) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		
		IF(@OPERAION='I')
		BEGIN
			INSERT INTO [DailyRoutineDetails](
				  Case_ID,WakeupTime ,	WaterBeforeTea,	WaterQuantity,	MorningDrink,	Divasvaap ,	NatureofWork ,	WorkingHours ,	Breakfast,CreatedDate )			
				  VALUES(
				@CASE_ID,@WAKEUPTIME,@WATERBEFORETEA,@WATERQUANTITY,@MORNINGDRINK,@DIVASVAAP,@NATUREOFWORK,@WORKINGHOURS,@BREAKFAST,GETDATE());	
			
			SET @ERROR_MESSAGE='TRUE';	
		END
		ELSE 
		BEGIN
			SET @ERROR_MESSAGE='FALSE';
		END	
	
			
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  8,'INSERT_DAILY_ROUTINE_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;
	END CATCH;
	
END






GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 16/06/2018
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[GET_ALL_MEDICINES]
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT * FROM MedicineMaster 
				
		SET @ERROR_MESSAGE='TRUE';
	
	
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  3,'FETCH_PATIENT_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;

	END CATCH;

END







GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[INSERT_DAILY_DIET_DETAILS]	
	@OPERAION VARCHAR(10),
	@CASE_ID VARCHAR(25),
	@AAHAR   NVARCHAR(250),
    @BHAJI  NVARCHAR(250),
    @KOSHIMBIR NVARCHAR(250),
    @AMBAT  NVARCHAR(250),
    @DAL NVARCHAR(250),
    @CHATANI NVARCHAR(250),
    @VIDAHI NVARCHAR(250),
    @FASTFOOD  NVARCHAR(250),
    @NONVEG  NVARCHAR(250),
    @COLDDRINK  NVARCHAR(250),
    @PUYRISHITHA  NVARCHAR(250),
    @FASTINGFOOD NVARCHAR(250),
    @OILYFOOD NVARCHAR(250),
    @AAHARNIYAM  NVARCHAR(250),
    @OPPOSITE NVARCHAR(250),
    @BAKERY  NVARCHAR(250),
    @WATER  NVARCHAR(250),
    @FRUITS NVARCHAR(250),
    @OTHER NVARCHAR(250),
    @VEGDHARAN NVARCHAR(250),
    @HABBIT NVARCHAR(250),
    @KOSHTAEXAM  NVARCHAR(250),
    @SLEEP  NVARCHAR(250),
    @OJAEXAM NVARCHAR(250),
	@ERROR_MESSAGE NVARCHAR(250) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		
		IF(@OPERAION='I')
		BEGIN
			INSERT INTO  DailyDietDetails(Case_ID,
				  Aahar,Bhaji,Koshimbir,Ambat,Dal,Chatani,Vidahi,FastFood,NonVeg,ColdDrink,Puyrishitha,
				  FastingFood,OilyFood,AaharNiyam,Opposite,Bakery,Water,Fruits,Other,VegDharan,Habbit,
				  KoshtaExam,Sleep,OjaExam,CreatedDate)			  
				  VALUES(
				@CASE_ID,@AAHAR, @BHAJI, @KOSHIMBIR,    @AMBAT,    @DAL,    @CHATANI,    @VIDAHI,    @FASTFOOD,    @NONVEG,    @COLDDRINK,    @PUYRISHITHA,
    @FASTINGFOOD, @OILYFOOD ,  @AAHARNIYAM,    @OPPOSITE ,    @BAKERY ,    @WATER ,    @FRUITS ,    @OTHER ,    @VEGDHARAN, @HABBIT,
	    @KOSHTAEXAM ,    @SLEEP ,    @OJAEXAM ,GETDATE());	
			
			SET @ERROR_MESSAGE='TRUE';	
		END
		ELSE 
		BEGIN
			SET @ERROR_MESSAGE='FALSE';
		END	
	
			
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  9,'INSERT_DAILY_DIET_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;
	END CATCH;
	
END






GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GET_DASHBOARD_DATA]
 @ERROR_MESSAGE VARCHAR(205) OUTPUT
AS

BEGIN
DECLARE @TOTAL_PATIENTS INT;
DECLARE @TOTAL_CASES INT;
DECLARE @TODAYS_PATIENTS INT;
DECLARE @TODAYS_CASES INT;


SET @TOTAL_PATIENTS=(SELECT COUNT(*) FROM Patient_Details);
SET @TOTAL_CASES=(SELECT COUNT(*) FROM Case_Details);

SET @TODAYS_PATIENTS=(SELECT COUNT(*) FROM Patient_Details WHERE CreatedDate =CONVERT(DATE,GETDATE()));
SET @TODAYS_CASES=(SELECT COUNT(*) FROM Case_Details WHERE CreatedDate =CONVERT(DATE,GETDATE()));


SELECT @TOTAL_PATIENTS AS TOTAL_PATIENTS,@TOTAL_CASES AS TOTAL_CASES,
	@TODAYS_PATIENTS AS TODAYS_PATIENTS , @TODAYS_CASES  AS TODAYS_CASES;


END

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_VIRECHANA_DETAILS]
@CASE_ID VARCHAR(50),
@SrNo INT, 
@Date DATE,
@OIL_GHEE NVARCHAR(5),
@OIL_GHEE_NAME NVARCHAR(50),
@DOSE NVARCHAR(20),
@MASSAGE NVARCHAR(50),
@MASSAGE_OIL NVARCHAR(20),
@SYMPTOMS NVARCHAR(250),
@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from VIRECHANA_DETAILS WHERE [SR_NO]=@SrNo AND CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].VIRECHANA_DETAILS
				   ([CASE_ID]
				   ,[SR_NO]
				   ,[Date]
				   ,[OIL_GHEE]
				   ,[OIL_GHEE_NAME]
				   ,[DOSE]
				   ,[MASSAGE]
				   ,[MASSAGE_OIL]
				   ,Symptoms
				   ,[CREATED_DATE])
			 VALUES
				   (@CASE_ID, 
				   @SrNo, 
				   convert(date, @Date, 105) ,				  
				   @OIL_GHEE, 
				   @OIL_GHEE_NAME,  
				   @DOSE,  
				   @MASSAGE,  
				   @MASSAGE_OIL,  
				   @SYMPTOMS,  
				   GETDATE());
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].VIRECHANA_DETAILS	 SET 		  
				   [Date]= convert(date, @Date, 105)
				   ,[OIL_GHEE]=@OIL_GHEE
				   ,[OIL_GHEE_NAME]=@OIL_GHEE_NAME
				   ,[DOSE]=@DOSE
				   ,[MASSAGE]=@MASSAGE
				   ,[MASSAGE_OIL]=@MASSAGE_OIL
				   ,Symptoms=@SYMPTOMS
				   ,[CREATED_DATE]=GETDATE()
			WHERE SR_NO=@SrNo AND CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 
	PRINT(ERROR_MESSAGE ( )   );
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END
GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 10/12/2017
-- Description:	Used to insert paitent's daily EXAMINATION DETAILS
-- =============================================
CREATE PROCEDURE [dbo].[INSERT_VIRECHANA_PRADHANKARMA_DETAILS]
@CASE_ID VARCHAR(50),
@PRADHANKARMADATE DATE ,
@MEDICINENAME NVARCHAR(50),
@MEDICINEQTY NVARCHAR(50),
@SYMPTOMS NVARCHAR(50),
@VIRECHNAVEG  NVARCHAR(50),
@ERROR_MESSAGE VARCHAR(250) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		DECLARE @CNT INT =0;
		SET @CNT=(SELECT COUNT(*) from [VIRECHANA_PRADHAN_KARMA_DETAILS] WHERE  CASE_ID=@CASE_ID)
		IF (@CNT=0) BEGIN

			INSERT INTO [dbo].[VIRECHANA_PRADHAN_KARMA_DETAILS]
           ([CASE_ID]    
		   ,[PradhanKarmaDate]       
           ,[MedicineName]
           ,[MedicineQty]
		   ,Symptoms
		   ,[VirechnaVeg])
			 VALUES
				   (@CASE_ID, 	
					@PRADHANKARMADATE,				
					@MEDICINENAME ,
					@MEDICINEQTY,
					@SYMPTOMS,
					@VIRECHNAVEG);
				SET @ERROR_MESSAGE='TRUE';
		END
		ELSE  BEGIN
			UPDATE  [dbo].[VIRECHANA_PRADHAN_KARMA_DETAILS]	 SET 		  
				   [PradhanKarmaDate]  = @PRADHANKARMADATE          
           ,[MedicineName]			   = @MEDICINENAME 
           ,[MedicineQty]			   = @MEDICINEQTY
		   ,Symptoms				   = @SYMPTOMS
		   ,VirechnaVeg				   = @VIRECHNAVEG
			WHERE  CASE_ID=@CASE_ID;
			SET @ERROR_MESSAGE='TRUE';
		END
	END TRY
	BEGIN CATCH 	
		DECLARE @ERRORNO NVARCHAR(20)=(SELECT ERROR_NUMBER());
		DECLARE @ERRORLINE NVARCHAR(20)=(SELECT ERROR_LINE());
		DECLARE @ERRORMSG NVARCHAR(MAX)=(SELECT ERROR_MESSAGE());
		EXEC  sp_CallProcedureLog  6,'INSERT_VIRECHANA_PRADHANKARMA_DETAILS',@ERRORNO,@ERRORLINE,@ERRORMSG,'' ;
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END

GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		Shashikant Shinde
-- Create date: 30/10/2017
-- Description:	Used to insert paitent's past history and family history
-- =============================================
CREATE PROCEDURE [dbo].[FETCH_VIRECHANA_DATA]
	@CASE_ID VARCHAR(50),	
	@ERROR_MESSAGE VARCHAR(25) OUTPUT
AS
BEGIN
	
	BEGIN TRY	
		SELECT ID
      ,CASE_ID
      ,SR_NO
	  , Convert(varchar,Date,105) [DATE]
      ,OIL_GHEE
      ,OIL_GHEE_NAME
      ,DOSE
      ,MASSAGE
      ,MASSAGE_OIL
      ,SYMPTOMS
      ,CREATED_DATE FROM VIRECHANA_DETAILS CD
		WHERE CD.CASE_ID=@CASE_ID;	


		SET @ERROR_MESSAGE='TRUE';
	END TRY
	BEGIN CATCH 
		SET @ERROR_MESSAGE='FALSE';
	END CATCH;

END










GO

GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[CONVERT_DATE](@DATE DATE)  
RETURNS DATE   
AS   
-- RETURNS THE STOCK LEVEL FOR THE PRODUCT.  
BEGIN  
  RETURN CONVERT(DATE, @DATE); 
END; 
GO

GO

--Indexes of table dbo.app_users
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[app_users] ADD CONSTRAINT [PK__app_user__B9BE370FA9AF03FB] PRIMARY KEY CLUSTERED ([user_id]) 
GO

--Indexes of table dbo.application_error_log
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[application_error_log] ADD CONSTRAINT [PK__applicat__3213E83F1A045F9C] PRIMARY KEY CLUSTERED ([id]) 
GO

--Indexes of table dbo.Case_Details
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[Case_Details] ADD CONSTRAINT [PK__Case_Det__D062FC05F2EE4DFF] PRIMARY KEY CLUSTERED ([Case_ID]) 
GO

--Indexes of table dbo.ComplaintDetails
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[ComplaintDetails] ADD CONSTRAINT [PK__Complain__3214EC27AAF76BF8] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.DailyDietDetails
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[DailyDietDetails] ADD CONSTRAINT [PK__DailyDie__3214EC2716D0E2D8] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.DailyRoutineDetails
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[DailyRoutineDetails] ADD CONSTRAINT [PK__DailyRou__3214EC27AAA0E3A9] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.DiagnosisDetails
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[DiagnosisDetails] ADD CONSTRAINT [PK__Diagnosi__3214EC27EC49FA0B] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.Error_Log
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[Error_Log] ADD CONSTRAINT [PK__Error_Lo__603A0C60944352ED] PRIMARY KEY CLUSTERED ([Record_ID]) 
GO

--Indexes of table dbo.FollowUpDetails
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[FollowUpDetails] ADD CONSTRAINT [PK__FollowUp__3214EC27BD2A6380] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.MedicineDetails
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[MedicineDetails] ADD CONSTRAINT [PK__Medicine__3214EC27B86BFA03] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.MedicineMaster
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[MedicineMaster] ADD CONSTRAINT [PK__Medicine__3214EC2732AC9314] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.NadiDetails
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[NadiDetails] ADD CONSTRAINT [PK__NadiDeta__3214EC07028113B5] PRIMARY KEY CLUSTERED ([Id]) 
GO

--Indexes of table dbo.PastHistory
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[PastHistory] ADD CONSTRAINT [PK__PastHist__3214EC2724DF4D64] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.Patient_Details
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[Patient_Details] ADD CONSTRAINT [PK__Patient___C1A88B593C6038DC] PRIMARY KEY CLUSTERED ([Patient_ID]) 
GO

--Indexes of table dbo.VAMAN_PRADHAN_KARMA_DETAILS
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[VAMAN_PRADHAN_KARMA_DETAILS] ADD CONSTRAINT [PK__VAMAN_PR__3214EC27100A2F72] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Indexes of table dbo.VIRECHANA_PRADHAN_KARMA_DETAILS
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TABLE [dbo].[VIRECHANA_PRADHAN_KARMA_DETAILS] ADD CONSTRAINT [PK__VIRECHAN__3214EC2709CCCAB2] PRIMARY KEY CLUSTERED ([ID]) 
GO

--Foreign Keys

USE [SamyakDB]
GO
ALTER TABLE [dbo].[Case_Details] WITH CHECK ADD CONSTRAINT [FK__Case_Deta__Patie__31EC6D26] 
	FOREIGN KEY ([Patient_ID]) REFERENCES [dbo].[Patient_Details] ([Patient_ID])
	ON UPDATE NO ACTION
	ON DELETE NO ACTION
GO
ALTER TABLE [dbo].[Case_Details] CHECK CONSTRAINT [FK__Case_Deta__Patie__31EC6D26]
GO
