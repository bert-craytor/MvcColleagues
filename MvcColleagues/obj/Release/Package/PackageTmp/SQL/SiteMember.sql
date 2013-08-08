USE [Colleagues]
GO

/****** Object:  Table [dbo].[SiteMember]    Script Date: 7/30/2013 6:32:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SiteMember](
	[Id] [uniqueidentifier] NOT NULL,
	[Uid] [int] NOT NULL,
	[FullName] [nvarchar](80) NOT NULL,
	[Company] [nvarchar](80) NULL,
	[JobTitle] [nvarchar](50) NULL,
	[Location] [nvarchar](80) NULL,
	[LevelId] [int] NULL,
	[FunctionId] [int] NULL,
	[IndustryId] [int] NULL,
	[JoinDate] [date] NULL,
	[SharedColleaguesCount] [int] NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
