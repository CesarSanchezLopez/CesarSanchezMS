USE [CloudExperts]
GO
/****** Object:  Table [dbo].[Deportista]    Script Date: 30/11/2023 3:30:54 p. m. ******/
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
/****** Object:  Table [dbo].[DeportistaModalidad]    Script Date: 30/11/2023 3:30:55 p. m. ******/
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
/****** Object:  Table [dbo].[Modalidad]    Script Date: 30/11/2023 3:30:55 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_Deportistas]    Script Date: 30/11/2023 3:30:55 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeportistasModalidad]    Script Date: 30/11/2023 3:30:55 p. m. ******/
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


SELECT  Max(DM.Valor) Valor
	  ,D.[Id]
      ,D.[Nombre]
      ,D.[CodPais]
	  ,M.Nombre Modalidad
	  ,
  (SELECT SUM(Valor) FROM [DeportistaModalidad] WHERE IdDeportista=D.Id ) Total
  FROM [dbo].[Deportista] D
  INNER JOIN [dbo].[DeportistaModalidad] DM ON (D.Id=DM.IdDeportista)
  INNER JOIN [dbo].[Modalidad] M ON (M.Id=DM.IdModalidad)
  GROUP BY  D.Id,D.[Nombre]
      ,D.[CodPais]
	  ,M.Nombre
  order by Total
  

END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertarDeportistaModalidad]    Script Date: 30/11/2023 3:30:55 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Cesar Sanchez
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertarDeportistaModalidad]
	@PIdDeportista int,
	@PIdModalidad int,
	@PValor int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;



INSERT INTO [dbo].[DeportistaModalidad]
           ([IdDeportista]
           ,[IdModalidad]
           ,[Valor])
     VALUES
           (@PIdDeportista
           ,@PIdModalidad
           ,@PValor)



  

END

GO
