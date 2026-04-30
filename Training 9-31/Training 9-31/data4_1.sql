USE [data4]
GO
/****** Object:  Schema [hr]    Script Date: 10/12/2021 19:42:18 ******/
CREATE SCHEMA [hr]
GO
/****** Object:  Table [dbo].[employee]    Script Date: 10/12/2021 19:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee](
	[name] [nvarchar](30) NULL,
	[hire_year] [int] NULL,
	[org_level]  AS (case when ((2021)-[hire_year])>=(3) then 'senior' else 'junior' end)
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[students]    Script Date: 10/12/2021 19:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[students](
	[id] [int] NULL,
	[name] [nvarchar](20) NULL,
	[class] [int] NULL,
	[tuition_per_class] [int] NULL,
	[total_tuition]  AS ([class]*[tuition_per_class])
) ON [PRIMARY]
GO
/****** Object:  Table [hr].[employee]    Script Date: 10/12/2021 19:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hr].[employee](
	[name] [nvarchar](30) NULL,
	[hire_year] [int] NULL,
	[org_level]  AS (case when ((2021)-[hire_year])>=(3) then 'senior' else 'junior' end)
) ON [PRIMARY]
GO
INSERT [dbo].[employee] ([name], [hire_year]) VALUES (N'Ahmed', 2016)
GO
INSERT [dbo].[employee] ([name], [hire_year]) VALUES (N'Mohamed', 2019)
GO
INSERT [dbo].[students] ([id], [name], [class], [tuition_per_class]) VALUES (100, N'John', 3, 549)
GO
INSERT [dbo].[students] ([id], [name], [class], [tuition_per_class]) VALUES (101, N'Alex', 4, 550)
GO
