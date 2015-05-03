
CREATE TABLE [dbo].[QD_Dim_Tables](
	[INTCODE] [int] IDENTITY(1,1) NOT NULL,
	[SEMA] [varchar](10) NULL,
	[TABLO] [varchar](50) NULL,
	[ACIKLAMA] [varchar](250) NULL
) ON [PRIMARY]

go


CREATE TABLE [dbo].[QD_Dim_Querys](
	[INTCODE] [int] IDENTITY(1,1) NOT NULL,
	[CREATOR] [varchar](15) NULL,
	[DT] [datetime] NULL,
	[DSC] [varchar](max) NULL,
	[QUERY] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

go
