USE [Colleagues]
GO

/****** Object:  Table [dbo].[Colleague]    Script Date: 7/30/2013 6:31:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Colleague](
	[Id] [uniqueidentifier] NOT NULL,
	[Uid1] [int] NOT NULL,
	[Uid2] [int] NOT NULL,
 CONSTRAINT [PK_Colleagues] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

