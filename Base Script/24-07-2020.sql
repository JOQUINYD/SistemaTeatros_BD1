USE [SistemaTeatros_BD1]
GO
/****** Object:  UserDefinedTableType [dbo].[DatosBoletos]    Script Date: 7/24/2020 11:48:38 AM ******/
CREATE TYPE [dbo].[DatosBoletos] AS TABLE(
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[IdPresentacion] [int] NOT NULL,
	[LetraFila] [char](1) NOT NULL,
	[IdBloqueFila] [int] NOT NULL,
	[NumAsiento] [int] NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[__RefactorLog]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__RefactorLog](
	[OperationKey] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OperationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accesos]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accesos](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bloques]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bloques](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[NombreBloque] [varchar](50) NOT NULL,
	[IdTeatro] [int] NOT NULL,
 CONSTRAINT [PK_Bloques] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Boletos]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Boletos](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[IdPresentacion] [int] NOT NULL,
	[LetraFila] [char](1) NOT NULL,
	[IdBloqueFila] [int] NOT NULL,
	[Precio] [decimal](19, 4) NOT NULL,
	[IdFactura] [int] NOT NULL,
	[NumAsiento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturas](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[NombreCliente] [varchar](150) NOT NULL,
	[Email] [nvarchar](320) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Telefono] [int] NOT NULL,
	[Hora] [time](7) NOT NULL,
	[NumeroAprobacion] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Filas]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Filas](
	[Letra] [char](1) NOT NULL,
	[NumAsientos] [int] NOT NULL,
	[IdBloque] [int] NOT NULL,
 CONSTRAINT [PK_Filas] PRIMARY KEY CLUSTERED 
(
	[Letra] ASC,
	[IdBloque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[Nombre] [varchar](50) NOT NULL,
	[FechaNac] [date] NOT NULL,
	[Cedula] [bigint] NOT NULL,
	[Direccion] [nvarchar](150) NOT NULL,
	[TelefonoCelular] [bigint] NULL,
	[TelefonoCasa] [bigint] NULL,
	[TelefonoOtro] [bigint] NULL,
	[Email] [varchar](150) NOT NULL,
	[IdTeatro] [int] NULL,
	[Sexo] [char](1) NOT NULL,
 CONSTRAINT [PK_Personas] PRIMARY KEY CLUSTERED 
(
	[Cedula] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Precios]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Precios](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Precio] [decimal](19, 4) NOT NULL,
	[IdProduccion] [int] NOT NULL,
	[IdBloque] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Presentaciones]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Presentaciones](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Hora] [time](7) NOT NULL,
	[IdProduccion] [int] NOT NULL,
 CONSTRAINT [PK_Presentaciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producciones]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producciones](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[NombreObra] [varchar](50) NOT NULL,
	[FechaInit] [date] NOT NULL,
	[FechaFin] [date] NOT NULL,
	[Tipo] [varchar](50) NOT NULL,
	[IdTeatro] [int] NOT NULL,
	[Descripcion] [varchar](300) NOT NULL,
	[IdProduccionEstado] [int] NOT NULL,
 CONSTRAINT [PK_Producciones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduccionEstados]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduccionEstados](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Estado] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ProduccionEstados] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reportes]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reportes](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Fecha] [date] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[CostoPromedio] [decimal](19, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teatros]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teatros](
	[Id] [int] IDENTITY(0,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Boleteria] [int] NOT NULL,
	[Email] [nvarchar](320) NOT NULL,
	[SitioWeb] [nvarchar](500) NOT NULL,
	[Telefono] [int] NOT NULL,
 CONSTRAINT [PK_Teatros] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 7/24/2020 11:48:38 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[Usuario] [varchar](50) NOT NULL,
	[Password] [varchar](150) NOT NULL,
	[IdAcceso] [int] NOT NULL,
	[CedulaPersona] [bigint] NOT NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'130b5558-16ee-4456-a982-088bb1d188ac')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'65092411-7a96-4c75-a2a1-0a0c7557ef71')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'010c0a5e-6166-4c3c-aeba-1ed59437f980')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'c27b018f-1c62-4964-a65f-32416c85f401')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'f2bb07fd-ad74-4999-a930-40dc02544280')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'80b22f34-9725-435e-802a-4501e0812f3b')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'585dc531-eac0-4f7b-8e5e-6449486e92f6')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'83b3103e-089c-4d29-9ef2-7caa513c617a')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'd80f07a5-7a0e-4881-8101-80561c118b6b')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'2d3e5c43-e4f4-4b61-8784-8787af775c04')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'b0ed9c0b-b4be-4641-b4d8-8cb1016dfac8')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'06ed4a25-fb2e-4994-9f27-9333a4658f36')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'c33a118b-8b5c-4ea3-88a3-a14ba031f080')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'67432543-01a9-45a7-91da-ab71482218a9')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'0065722e-6f3f-4559-8128-ae98e1193ffb')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'6e797986-064f-4381-8463-c6f74c6c20c8')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'6b214b9a-270f-49b9-8450-c7b547726dd9')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'57566084-843c-4cb9-b20c-cddc86ceea1d')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'97259c1d-b991-4bf4-914c-d49f8f407439')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'22e9decc-165a-42da-94b0-d4facbe97c9f')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'4ad37598-ea0c-4d64-8346-e449db2debaf')
INSERT [dbo].[__RefactorLog] ([OperationKey]) VALUES (N'937c0cba-1915-49c5-9cb6-f3ec09fd96f9')
SET IDENTITY_INSERT [dbo].[Accesos] ON 

INSERT [dbo].[Accesos] ([Id], [Tipo]) VALUES (0, N'System Admin')
INSERT [dbo].[Accesos] ([Id], [Tipo]) VALUES (1, N'Admin Teatro')
INSERT [dbo].[Accesos] ([Id], [Tipo]) VALUES (2, N'Agente Teatro')
SET IDENTITY_INSERT [dbo].[Accesos] OFF
SET IDENTITY_INSERT [dbo].[Bloques] ON 

INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (17, N'lunetas', 10)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (18, N'butacas', 10)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (19, N'galeria izquierda', 10)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (20, N'galeria central', 10)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (21, N'galeria derecha', 10)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (22, N'luneta izquierda', 11)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (23, N'luneta central', 11)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (24, N'luneta derecha', 11)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (25, N'Balcon central', 10)
SET IDENTITY_INSERT [dbo].[Bloques] OFF
SET IDENTITY_INSERT [dbo].[Boletos] ON 

INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (1, 2, N'A', 17, CAST(1500.0000 AS Decimal(19, 4)), 0, 2)
SET IDENTITY_INSERT [dbo].[Boletos] OFF
SET IDENTITY_INSERT [dbo].[Facturas] ON 

INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (0, N'Carlos perez', N'apatito@gmail', CAST(N'2020-07-23' AS Date), 88963252, CAST(N'12:00:00' AS Time), 375)
SET IDENTITY_INSERT [dbo].[Facturas] OFF
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 30, 18)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 12, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 21, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 12, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 11, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 12, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 11, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 20, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 30, 18)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 14, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 24, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 14, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 10, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 11, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 12, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 20, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 32, 18)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 13, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 27, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 13, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 11, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 12, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 13, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 15, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 42, 18)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 12, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 30, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 12, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 10, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 11, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 12, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 10, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 26, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 12, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 30, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 12, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 11, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 12, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 11, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 30, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 26, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 10, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 11, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 10, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'G', 26, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'G', 11, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'G', 12, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'G', 11, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'H', 26, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'H', 10, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'H', 11, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'H', 13, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'I', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'I', 11, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'I', 12, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'I', 12, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'J', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'J', 11, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'J', 12, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'K', 22, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'L', 20, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'M', 18, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'N', 14, 17)
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Nicolás Angulo Mesa', CAST(N'0001-01-01' AS Date), 109710805, N'Guayabos', 91178174, NULL, NULL, N'nicolas@outbound.com', 10, N'M')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Mariola Bolaños Acevedo', CAST(N'0001-01-01' AS Date), 204960060, N'Paseo Colón', 42095437, NULL, NULL, N'marboa@otromail.com', 11, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Ariel Conejo', CAST(N'0001-01-01' AS Date), 206710046, N'Curridabat', 98712584, 24315954, 88760431, N'ari@mimail.com', NULL, N'M')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Joaquin Jimenez Sennrich', CAST(N'0001-01-01' AS Date), 901300979, N'Santa Ana', 60032280, 60032280, 60032280, N'joaquinenrique2010@gmail.com', NULL, N'M')
SET IDENTITY_INSERT [dbo].[Precios] ON 

INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (0, CAST(50000.0000 AS Decimal(19, 4)), 11, 17)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (1, CAST(30000.0000 AS Decimal(19, 4)), 11, 18)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (2, CAST(10000.0000 AS Decimal(19, 4)), 11, 19)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (3, CAST(12000.0000 AS Decimal(19, 4)), 11, 20)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (4, CAST(10000.0000 AS Decimal(19, 4)), 11, 21)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (5, CAST(8000.0000 AS Decimal(19, 4)), 12, 17)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (6, CAST(5000.0000 AS Decimal(19, 4)), 12, 18)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (7, CAST(3000.0000 AS Decimal(19, 4)), 12, 19)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (8, CAST(3000.0000 AS Decimal(19, 4)), 12, 20)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (9, CAST(3000.0000 AS Decimal(19, 4)), 12, 21)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (10, CAST(6000.0000 AS Decimal(19, 4)), 13, 22)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (11, CAST(12000.0000 AS Decimal(19, 4)), 13, 23)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (12, CAST(6000.0000 AS Decimal(19, 4)), 13, 24)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (13, CAST(15000.0000 AS Decimal(19, 4)), 11, 25)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (14, CAST(15000.0000 AS Decimal(19, 4)), 14, 18)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (15, CAST(20000.0000 AS Decimal(19, 4)), 14, 17)
SET IDENTITY_INSERT [dbo].[Precios] OFF
SET IDENTITY_INSERT [dbo].[Presentaciones] ON 

INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (2, CAST(N'2019-06-09' AS Date), CAST(N'20:00:00' AS Time), 11)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (3, CAST(N'2019-06-10' AS Date), CAST(N'20:00:00' AS Time), 11)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (4, CAST(N'2019-06-12' AS Date), CAST(N'15:00:00' AS Time), 11)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (5, CAST(N'2019-07-16' AS Date), CAST(N'20:00:00' AS Time), 12)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (6, CAST(N'2019-06-17' AS Date), CAST(N'20:00:00' AS Time), 13)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (7, CAST(N'2019-06-18' AS Date), CAST(N'20:00:00' AS Time), 13)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (8, CAST(N'2019-06-25' AS Date), CAST(N'20:00:00' AS Time), 13)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (9, CAST(N'2019-06-26' AS Date), CAST(N'15:00:00' AS Time), 13)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (10, CAST(N'2019-06-26' AS Date), CAST(N'20:00:00' AS Time), 13)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (11, CAST(N'2020-08-16' AS Date), CAST(N'20:00:00' AS Time), 14)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (12, CAST(N'2020-07-21' AS Date), CAST(N'12:11:00' AS Time), 14)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (13, CAST(N'2020-08-17' AS Date), CAST(N'20:00:00' AS Time), 14)
SET IDENTITY_INSERT [dbo].[Presentaciones] OFF
SET IDENTITY_INSERT [dbo].[Producciones] ON 

INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (11, N'Bodas de sangre', CAST(N'2019-06-09' AS Date), CAST(N'2019-06-12' AS Date), N'teatro', 10, N'Se presenta con todo lujo la gran obra de Federico García Lorca.', 3)
INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (12, N'Jovenes Coreografos 2016', CAST(N'2019-07-16' AS Date), CAST(N'2019-07-16' AS Date), N'danza', 10, N'Cinco coreógrafos jóvenes nos muestran sus trabajos.', 5)
INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (13, N'Bolero Filarmonico', CAST(N'2019-06-17' AS Date), CAST(N'2019-06-26' AS Date), N'musica', 11, N'La Orquesta Filarmónica se luce interpretando boleros clásicos que llegan al corazón de todos los románticos.', 0)
INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (14, N'III Concierto Temporada Oficial', CAST(N'2020-08-15' AS Date), CAST(N'2020-08-20' AS Date), N'Concierto', 10, N'24 y 26 abril, 2020  Sylvain Gasançon, director invitado  Solista invitada: Rachel Barton, violín  Programa:  Rossini, Obertura La italiana en Argel  Saint -Saëns, Concierto para violín No. 3  Brahms, Sinfonía No. 2', 3)
SET IDENTITY_INSERT [dbo].[Producciones] OFF
SET IDENTITY_INSERT [dbo].[ProduccionEstados] ON 

INSERT [dbo].[ProduccionEstados] ([Id], [Estado]) VALUES (0, N'CONFIDENCIAL')
INSERT [dbo].[ProduccionEstados] ([Id], [Estado]) VALUES (1, N'ADELANTADA')
INSERT [dbo].[ProduccionEstados] ([Id], [Estado]) VALUES (2, N'ANUNCIADA')
INSERT [dbo].[ProduccionEstados] ([Id], [Estado]) VALUES (3, N'ABIERTA')
INSERT [dbo].[ProduccionEstados] ([Id], [Estado]) VALUES (4, N'CANCELADA')
INSERT [dbo].[ProduccionEstados] ([Id], [Estado]) VALUES (5, N'CONCLUIDA')
SET IDENTITY_INSERT [dbo].[ProduccionEstados] OFF
SET IDENTITY_INSERT [dbo].[Reportes] ON 

INSERT [dbo].[Reportes] ([Id], [Fecha], [Cantidad], [CostoPromedio]) VALUES (4, CAST(N'2020-07-23' AS Date), 1, CAST(1500.0000 AS Decimal(19, 4)))
INSERT [dbo].[Reportes] ([Id], [Fecha], [Cantidad], [CostoPromedio]) VALUES (5, CAST(N'2020-07-23' AS Date), 0, CAST(0.0000 AS Decimal(19, 4)))
INSERT [dbo].[Reportes] ([Id], [Fecha], [Cantidad], [CostoPromedio]) VALUES (6, CAST(N'2020-07-24' AS Date), 0, CAST(0.0000 AS Decimal(19, 4)))
SET IDENTITY_INSERT [dbo].[Reportes] OFF
SET IDENTITY_INSERT [dbo].[Teatros] ON 

INSERT [dbo].[Teatros] ([Id], [Nombre], [Boleteria], [Email], [SitioWeb], [Telefono]) VALUES (10, N'Teatro Nacional', 23841182, N'tn@yopmail.com', N'tnc.cr', 2555985)
INSERT [dbo].[Teatros] ([Id], [Nombre], [Boleteria], [Email], [SitioWeb], [Telefono]) VALUES (11, N'Melico Salazar', 58825560, N'tms@otromail.com', N'tms.cr', 8888155)
INSERT [dbo].[Teatros] ([Id], [Nombre], [Boleteria], [Email], [SitioWeb], [Telefono]) VALUES (12, N'Rubén Darío', 22405060, N'rdario@gmail.com', N'rdario.nic.com', 27710045)
SET IDENTITY_INSERT [dbo].[Teatros] OFF
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'aperez', N'DoSm2TM+7jKpB8zs3yJXSM4k0wVVYT/tPDoRouDNjaXPyfTyNw==', 0, 206710046)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'JoaJimSen', N'Hc9KI1yCEontlpvQNKkTPna3/FVmKpT8HZTDS5cT5tWXSq2SNKQRF1Yx', 0, 901300979)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'mbolanos', N'Kr3lAgBhmW8dI3LUtWVGRXSlA+yM6uXtOZlJfuQZnQfAzm9mFrv6Hg==', 1, 204960060)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'nangulo', N'Iz8xv3IMRroVhL0nG4hj+BWAdNLuTo5tsb+WwH2gteFy2PQO6g==', 1, 109710805)
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_Boletos]    Script Date: 7/24/2020 11:48:39 AM ******/
ALTER TABLE [dbo].[Boletos] ADD  CONSTRAINT [AK_Boletos] UNIQUE NONCLUSTERED 
(
	[LetraFila] ASC,
	[IdBloqueFila] ASC,
	[IdPresentacion] ASC,
	[NumAsiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 7/24/2020 11:48:39 AM ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Producciones] ADD  DEFAULT ((0)) FOR [IdProduccionEstado]
GO
ALTER TABLE [dbo].[Bloques]  WITH CHECK ADD  CONSTRAINT [FK_Bloques_Teatros] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[Bloques] CHECK CONSTRAINT [FK_Bloques_Teatros]
GO
ALTER TABLE [dbo].[Boletos]  WITH CHECK ADD  CONSTRAINT [FK_Boleto_ToFactura] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[Facturas] ([Id])
GO
ALTER TABLE [dbo].[Boletos] CHECK CONSTRAINT [FK_Boleto_ToFactura]
GO
ALTER TABLE [dbo].[Boletos]  WITH CHECK ADD  CONSTRAINT [FK_Boleto_ToFilas] FOREIGN KEY([LetraFila], [IdBloqueFila])
REFERENCES [dbo].[Filas] ([Letra], [IdBloque])
GO
ALTER TABLE [dbo].[Boletos] CHECK CONSTRAINT [FK_Boleto_ToFilas]
GO
ALTER TABLE [dbo].[Boletos]  WITH CHECK ADD  CONSTRAINT [FK_Boleto_ToPresentaciones] FOREIGN KEY([IdPresentacion])
REFERENCES [dbo].[Presentaciones] ([Id])
GO
ALTER TABLE [dbo].[Boletos] CHECK CONSTRAINT [FK_Boleto_ToPresentaciones]
GO
ALTER TABLE [dbo].[Filas]  WITH CHECK ADD  CONSTRAINT [FK_Filas_Bloques] FOREIGN KEY([IdBloque])
REFERENCES [dbo].[Bloques] ([Id])
GO
ALTER TABLE [dbo].[Filas] CHECK CONSTRAINT [FK_Filas_Bloques]
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD  CONSTRAINT [FK_Personas_Teatros] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[Personas] CHECK CONSTRAINT [FK_Personas_Teatros]
GO
ALTER TABLE [dbo].[Precios]  WITH CHECK ADD  CONSTRAINT [FK_Precios_Bloques] FOREIGN KEY([IdBloque])
REFERENCES [dbo].[Bloques] ([Id])
GO
ALTER TABLE [dbo].[Precios] CHECK CONSTRAINT [FK_Precios_Bloques]
GO
ALTER TABLE [dbo].[Precios]  WITH CHECK ADD  CONSTRAINT [FK_Precios_Producciones] FOREIGN KEY([IdProduccion])
REFERENCES [dbo].[Producciones] ([Id])
GO
ALTER TABLE [dbo].[Precios] CHECK CONSTRAINT [FK_Precios_Producciones]
GO
ALTER TABLE [dbo].[Presentaciones]  WITH CHECK ADD  CONSTRAINT [FK_Presentaciones_Producciones] FOREIGN KEY([IdProduccion])
REFERENCES [dbo].[Producciones] ([Id])
GO
ALTER TABLE [dbo].[Presentaciones] CHECK CONSTRAINT [FK_Presentaciones_Producciones]
GO
ALTER TABLE [dbo].[Producciones]  WITH CHECK ADD  CONSTRAINT [FK_Producciones_ProduccionEstados] FOREIGN KEY([IdProduccionEstado])
REFERENCES [dbo].[ProduccionEstados] ([Id])
GO
ALTER TABLE [dbo].[Producciones] CHECK CONSTRAINT [FK_Producciones_ProduccionEstados]
GO
ALTER TABLE [dbo].[Producciones]  WITH CHECK ADD  CONSTRAINT [FK_Producciones_Teatros] FOREIGN KEY([IdTeatro])
REFERENCES [dbo].[Teatros] ([Id])
GO
ALTER TABLE [dbo].[Producciones] CHECK CONSTRAINT [FK_Producciones_Teatros]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Personas] FOREIGN KEY([CedulaPersona])
REFERENCES [dbo].[Personas] ([Cedula])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Personas]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_ToAccesos] FOREIGN KEY([IdAcceso])
REFERENCES [dbo].[Accesos] ([Id])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_ToAccesos]
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[spAddBloque]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spAddBloque]
	@NombreBloque varchar(50),
	@IdTeatro int
AS
	INSERT INTO Bloques (NombreBloque, IdTeatro)
	VALUES (@NombreBloque, @IdTeatro)
GO
/****** Object:  StoredProcedure [dbo].[spAddFila]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spAddFila]
	@IdBloque int,
	@Letra char(1),
	@NumAsientos int
AS
	INSERT INTO Filas (IdBloque, Letra, NumAsientos)
	VALUES (@IdBloque, @Letra, @NumAsientos)
GO
/****** Object:  StoredProcedure [dbo].[spAddPersonaAndUsuario]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddPersonaAndUsuario]
	@Nombre varchar(50),
	@FechaNac date,
	@Cedula bigint,
	@Direccion nvarchar(150),
	@TelefonoCelular bigint,
	@TelefonoCasa bigint,
	@TelefonoOtro bigint,
	@Email varchar(150),
	@IdTeatro int,
	@Sexo char,
	@Usuario varchar(50),
	@Password varchar(150),
	@IdAcceso int
AS
	INSERT INTO Personas (Nombre, FechaNac, Cedula, Direccion, TelefonoCelular, TelefonoCasa, TelefonoOtro, Email, IdTeatro, Sexo)
	VALUES (@Nombre, @FechaNac, @Cedula, @Direccion, @TelefonoCelular, @TelefonoCasa, @TelefonoOtro, @Email, @IdTeatro, @Sexo)

	INSERT INTO Usuarios (Usuario, Password, IdAcceso, CedulaPersona)
	VALUES (@Usuario, @Password, @IdAcceso, @Cedula)
GO
/****** Object:  StoredProcedure [dbo].[spAddPrecio]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spAddPrecio]
	@IdProduccion int,
	@IdBloque int,
	@Precio decimal(19,4)
AS
	Insert Into Precios (IdProduccion, IdBloque, Precio)
	Values (@IdProduccion, @IdBloque, @Precio)
GO
/****** Object:  StoredProcedure [dbo].[spAddPresentacion]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddPresentacion]
	@Fecha date,
	@Hora time(7),
	@IdProduccion int 

AS
	INSERT INTO Presentaciones (Fecha, Hora, IdProduccion)
	VALUES (@Fecha, @Hora, @IdProduccion)
GO
/****** Object:  StoredProcedure [dbo].[spAddProduccion]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddProduccion]
	@Nombre varchar(50),
	@Descripcion varchar(300),
	@Tipo varchar(50),
	@Fecha_Init date,
	@Feccha_Fin date,
	@ID_Teatro int 


	AS
	INSERT INTO Producciones (NombreObra,Descripcion,FechaInit,FechaFin,IdTeatro,Tipo)
	VALUES (@Nombre,@Descripcion,@Fecha_Init,@Feccha_Fin,@ID_Teatro,@Tipo)


GO
/****** Object:  StoredProcedure [dbo].[spAddTeatro]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAddTeatro]
	@Nombre varchar(50),
	@Boleteria int,
	@Email nvarchar(320),
	@SitioWeb nvarchar(500),
	@Telefono int
AS
	INSERT INTO Teatros (Nombre, Boleteria, Email, SitioWeb, Telefono)
	VALUES (@Nombre, @Boleteria, @Email, @SitioWeb, @Telefono)
GO
/****** Object:  StoredProcedure [dbo].[spCambiarEstadoProduccion]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCambiarEstadoProduccion]
	@Id_Estado int ,
	@Id_Produccion int 

	AS 
	UPDATE Producciones
	SET IdProduccionEstado = @Id_Estado
	WHERE  Id = @Id_Produccion
GO
/****** Object:  StoredProcedure [dbo].[spCompraBoletosYFactura]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spCompraBoletosYFactura]
	@Nombre_Cliente varchar(150),
	@Email nvarchar(320),
	@Fecha date,
	@Telefono int,
	@Hora time(7),
	@Numero_Aprobacion int,
	@Boletos as DatosBoletos READONLY

	AS
	BEGIN
		BEGIN TRY 
			BEGIN TRANSACTION
				
				INSERT INTO Facturas
				VALUES(@Nombre_Cliente,@Email,@Fecha,@Telefono,@Hora,@Numero_Aprobacion)
				DECLARE @Id_Factura INT = SCOPE_IDENTITY()

				INSERT INTO Boletos
				SELECT b.IdPresentacion,b.LetraFila,b.IdBloqueFila,prec.Precio ,@Id_Factura,b.NumAsiento
				FROM			@Boletos b 
						JOIN	Presentaciones pre ON (b.IdPresentacion = pre.Id)
						JOIN	Producciones prod ON (pre.IdProduccion = prod.Id)
						JOIN	Precios prec ON (prod.Id = prec.IdProduccion AND prec.IdBloque = b.IdBloqueFila)



			COMMIT TRANSACTION 
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
		END CATCH 
	END 
GO
/****** Object:  StoredProcedure [dbo].[spDefinirPrecioBloqueParaProduccion]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDefinirPrecioBloqueParaProduccion]
	@Id_Bloque int ,
	@Id_Produccion int,
	@Precio decimal(19,4)

	AS 

	INSERT INTO Precios (Precio,IdProduccion,IdBloque)
	VALUES (@Precio,@Id_Produccion,@Id_Bloque)
GO
/****** Object:  StoredProcedure [dbo].[spGetAsientosVaciosFila]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetAsientosVaciosFila]
	@IdPresentacion int,
	@IdBloque int,
	@Letra char(1)
AS
	DECLARE @NumAsientos int
	SET @NumAsientos = (SELECT f.NumAsientos FROM Filas f WHERE f.IdBloque = @IdBloque AND f.Letra = @Letra)

	SELECT ones.n + 10*tens.n + 100*hundreds.n + 1000*thousands.n AS numAsi
	FROM (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) ones(n),
		 (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) tens(n),
		 (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) hundreds(n),
		 (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) thousands(n)
	WHERE ones.n + 10*tens.n + 100*hundreds.n + 1000*thousands.n BETWEEN 1 AND @NumAsientos AND ones.n + 10*tens.n + 100*hundreds.n + 1000*thousands.n NOT IN (SELECT NumAsiento FROM Boletos WHERE IdPresentacion = @IdPresentacion AND IdBloqueFila = @IdBloque AND LetraFila = @Letra)																							
	ORDER BY 1
GO
/****** Object:  StoredProcedure [dbo].[spGetBloqueByTeatro]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetBloqueByTeatro]
	@IdTeatro int
AS
	SELECT *
	FROM Bloques
	WHERE IdTeatro = @IdTeatro
GO
/****** Object:  StoredProcedure [dbo].[spGetFilasByBloque]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetFilasByBloque]
	@IdBloque int
AS
	SELECT *
	FROM Filas
	WHERE IdBloque = @IdBloque
	ORDER BY Letra ASC
GO
/****** Object:  StoredProcedure [dbo].[spGetIdTeatroFromUsuario]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetIdTeatroFromUsuario]
	@Usuario varchar(50)
AS
	SELECT p.IdTeatro
	From Usuarios u
	JOIN Personas p ON p.Cedula = u.CedulaPersona
	WHERE u.Usuario = @Usuario
GO
/****** Object:  StoredProcedure [dbo].[spGetInfoBloqueById]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetInfoBloqueById]
	@IdBloque int
AS
	SELECT b.Id, b.IdTeatro, b.NombreBloque, t.Nombre AS NombreTeatro
	FROM Bloques b
	JOIN Teatros t ON t.Id = b.IdTeatro
	WHERE b.Id = @IdBloque
GO
/****** Object:  StoredProcedure [dbo].[spGetMatchingUser]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetMatchingUser]
	@Usuario varchar(50)

	AS

	SELECT *
	FROM Usuarios u
	WHERE u.Usuario = @Usuario
GO
/****** Object:  StoredProcedure [dbo].[spGetPreciosByProduccion]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spGetPreciosByProduccion]
	@IdProduccion int
AS
	Select p.Precio, b.NombreBloque
	From Precios p
	Join Bloques b on b.Id = p.IdBloque
	Where p.IdProduccion = @IdProduccion
GO
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesByFechaHora]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spGetPresentacionesByFechaHora]
	@Fecha date,
	@Hora time(7),
	@IdTeatro int
AS
	Select p.Id
	From Presentaciones p
	Join Producciones pr ON pr.Id = p.IdProduccion AND pr.IdTeatro = @IdTeatro
	Where p.Fecha = @Fecha AND p.Hora = @Hora
GO
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesByProduccion]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetPresentacionesByProduccion]
	@IdProduccion int
AS
	SELECT p.Fecha, p.Hora, p.Id
	FROM Presentaciones p
	WHERE p.IdProduccion = @IdProduccion
	ORDER BY p.Fecha ASC, p.Hora ASC
GO
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesRangoFechas]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetPresentacionesRangoFechas]
	@Fecha_Inicio DATE,
	@Fecha_Final DATE

	AS 

	SELECT * 
	FROM Presentaciones p
	WHERE p.Fecha BETWEEN @Fecha_Inicio and @Fecha_Final 
GO
/****** Object:  StoredProcedure [dbo].[spGetProduccionById]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetProduccionById]
	@IdProduccion int
AS
	SELECT po.Id, po.NombreObra, po.FechaInit, po.FechaFin, po.Tipo, pe.Estado, T.Nombre, po.Descripcion, po.IdProduccionEstado, po.IdTeatro
	FROM Producciones po
	JOIN ProduccionEstados pe ON pe.Id = po.IdProduccionEstado
	JOIN Teatros t ON t.Id = po.IdTeatro
	WHERE po.Id = @IdProduccion
GO
/****** Object:  StoredProcedure [dbo].[spGetProduccionesByTeatro]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetProduccionesByTeatro]
	@IdTeatro int
AS
	SELECT po.Id, po.NombreObra, po.FechaInit, po.FechaFin, po.Tipo, pe.Estado, T.Nombre, po.Descripcion
	FROM Producciones po
	JOIN ProduccionEstados pe ON pe.Id = po.IdProduccionEstado
	JOIN Teatros t ON t.Id = po.IdTeatro
	WHERE po.IdTeatro = @IdTeatro
GO
/****** Object:  StoredProcedure [dbo].[spGetProduccionesCartelera]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetProduccionesCartelera]

	AS 
	SELECT DISTINCT po.Id, po.NombreObra, po.FechaInit, po.FechaFin, po.Tipo, pe.Estado, T.Nombre, po.Descripcion, po.IdTeatro, po.IdProduccionEstado
	FROM Producciones po
	JOIN ProduccionEstados pe ON pe.Id = po.IdProduccionEstado
	JOIN Teatros t ON t.Id = po.IdTeatro
	JOIN Presentaciones pr ON pr.IdProduccion = po.Id
	WHERE po.IdProduccionEstado != 0
GO
/****** Object:  StoredProcedure [dbo].[spGetProduccionesInFechas]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetProduccionesInFechas]
	@Fecha_Inicio DATE,
	@Fecha_Final DATE

	AS 
	SELECT DISTINCT po.Id, po.NombreObra, po.FechaInit, po.FechaFin, po.Tipo, pe.Estado, T.Nombre, po.Descripcion, po.IdTeatro, po.IdProduccionEstado
	FROM Producciones po
	JOIN ProduccionEstados pe ON pe.Id = po.IdProduccionEstado
	JOIN Teatros t ON t.Id = po.IdTeatro
	JOIN Presentaciones pr ON pr.IdProduccion = po.Id
	WHERE po.IdProduccionEstado != 0 AND (pr.Fecha BETWEEN @Fecha_Inicio and @Fecha_Final)
GO
/****** Object:  StoredProcedure [dbo].[spGetReporteDiario]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetReporteDiario]
	
AS

	INSERT INTO Reportes
	SELECT  f.Fecha  , COUNT(*) , AVG(b.Precio) 
	FROM	Boletos b 
			JOIN	Facturas f ON (b.IdFactura = f.Id)
	WHERE f.Fecha = CONVERT(DATE,GETDATE())
	GROUP BY f.Fecha

	UNION 

	SELECT  GETDATE() , 0, 0
	WHERE NOT EXISTS (	SELECT  f.Fecha  , COUNT(*) , AVG(b.Precio) 
						FROM	Boletos b 
							JOIN	Facturas f ON (b.IdFactura = f.Id)
						WHERE f.Fecha = CONVERT(DATE,GETDATE())
						GROUP BY f.Fecha																			)
GO
/****** Object:  StoredProcedure [dbo].[spGetTeatroById]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetTeatroById]
	@IdTeatro int
AS
	SELECT * 
	FROM Teatros
	WHERE Id = @IdTeatro
GO
/****** Object:  StoredProcedure [dbo].[spGetTeatros]    Script Date: 7/24/2020 11:48:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetTeatros]
AS
	SELECT * 
	FROM Teatros
GO
