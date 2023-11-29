USE [CloudExperts]
GO
/****** Object:  Table [dbo].[Deportista]    Script Date: 29/11/2023 4:43:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Deportista](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](500) NULL,
	[CodPais] [varchar](5) NULL,
 CONSTRAINT [PK_Deportista] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeportistaModalidad]    Script Date: 29/11/2023 4:43:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeportistaModalidad](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdDeportista] [int] NOT NULL,
	[IdModalidad] [int] NOT NULL,
	[Valor] [int] NULL,
 CONSTRAINT [PK_DeportistaModalidad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Modalidad]    Script Date: 29/11/2023 4:43:41 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Modalidad](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
 CONSTRAINT [PK_Modalidad] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Deportista] ON 

INSERT [dbo].[Deportista] ([Id], [Nombre], [CodPais]) VALUES (1, N'Diana', N'COL')
INSERT [dbo].[Deportista] ([Id], [Nombre], [CodPais]) VALUES (2, N'Pedro', N'COL')
INSERT [dbo].[Deportista] ([Id], [Nombre], [CodPais]) VALUES (3, N'Alejandra', N'MEX')
SET IDENTITY_INSERT [dbo].[Deportista] OFF
GO
SET IDENTITY_INSERT [dbo].[DeportistaModalidad] ON 

INSERT [dbo].[DeportistaModalidad] ([Id], [IdDeportista], [IdModalidad], [Valor]) VALUES (1, 1, 1, 134)
INSERT [dbo].[DeportistaModalidad] ([Id], [IdDeportista], [IdModalidad], [Valor]) VALUES (2, 1, 2, 177)
INSERT [dbo].[DeportistaModalidad] ([Id], [IdDeportista], [IdModalidad], [Valor]) VALUES (3, 2, 1, 130)
INSERT [dbo].[DeportistaModalidad] ([Id], [IdDeportista], [IdModalidad], [Valor]) VALUES (4, 2, 2, 180)
INSERT [dbo].[DeportistaModalidad] ([Id], [IdDeportista], [IdModalidad], [Valor]) VALUES (5, 3, 1, 150)
INSERT [dbo].[DeportistaModalidad] ([Id], [IdDeportista], [IdModalidad], [Valor]) VALUES (6, 3, 2, 150)
SET IDENTITY_INSERT [dbo].[DeportistaModalidad] OFF
GO
SET IDENTITY_INSERT [dbo].[Modalidad] ON 

INSERT [dbo].[Modalidad] ([Id], [Nombre]) VALUES (1, N'Arranque')
INSERT [dbo].[Modalidad] ([Id], [Nombre]) VALUES (2, N'Envion')
SET IDENTITY_INSERT [dbo].[Modalidad] OFF
GO
ALTER TABLE [dbo].[DeportistaModalidad]  WITH CHECK ADD  CONSTRAINT [FK_DeportistaModalidad_Deportista] FOREIGN KEY([IdDeportista])
REFERENCES [dbo].[Deportista] ([Id])
GO
ALTER TABLE [dbo].[DeportistaModalidad] CHECK CONSTRAINT [FK_DeportistaModalidad_Deportista]
GO
ALTER TABLE [dbo].[DeportistaModalidad]  WITH CHECK ADD  CONSTRAINT [FK_DeportistaModalidad_Modalidad] FOREIGN KEY([IdModalidad])
REFERENCES [dbo].[Modalidad] ([Id])
GO
ALTER TABLE [dbo].[DeportistaModalidad] CHECK CONSTRAINT [FK_DeportistaModalidad_Modalidad]
GO
/****** Object:  StoredProcedure [dbo].[SP_Deportistas]    Script Date: 29/11/2023 4:43:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Deportistas]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT [Id]
      ,[Nombre]
      ,[CodPais]
  FROM [dbo].[Deportista]

END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeportistasModalidad]    Script Date: 29/11/2023 4:43:42 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DeportistasModalidad]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT D.[Id]
      ,D.[Nombre]
      ,D.[CodPais]
	  ,M.Nombre Modalidad
	  ,DM.Valor	
	  ,
	  (SELECT SUM(Valor) FROM [DeportistaModalidad] WHERE IdDeportista=D.Id ) Total
  FROM [dbo].[Deportista] D
  INNER JOIN [dbo].[DeportistaModalidad] DM ON (D.Id=DM.IdDeportista)
  INNER JOIN [dbo].[Modalidad] M ON (M.Id=DM.IdModalidad)
  order by Total desc
  

END
GO
