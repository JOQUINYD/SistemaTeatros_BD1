USE [master]
GO
/****** Object:  Database [SistemaTeatros_BD1]    Script Date: 27/7/2020 5:59:24 p. m. ******/
CREATE DATABASE [SistemaTeatros_BD1]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SistemaTeatros_BD1', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SistemaTeatros_BD1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SistemaTeatros_BD1_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\SistemaTeatros_BD1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SistemaTeatros_BD1] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SistemaTeatros_BD1].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SistemaTeatros_BD1] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET ARITHABORT OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET RECOVERY FULL 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET  MULTI_USER 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SistemaTeatros_BD1] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SistemaTeatros_BD1] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SistemaTeatros_BD1', N'ON'
GO
ALTER DATABASE [SistemaTeatros_BD1] SET QUERY_STORE = OFF
GO
USE [SistemaTeatros_BD1]
GO
/****** Object:  UserDefinedTableType [dbo].[DatosBoletos]    Script Date: 27/7/2020 5:59:24 p. m. ******/
CREATE TYPE [dbo].[DatosBoletos] AS TABLE(
	[IdPresentacion] [int] NULL,
	[LetraFila] [char](1) NULL,
	[IdBloqueFila] [int] NULL,
	[NumAsiento] [int] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Usuarios]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  View [dbo].[VwUsuarios]    Script Date: 27/7/2020 5:59:24 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[VwUsuarios] As
	Select u.Usuario, u.IdAcceso, u.CedulaPersona 
	From Usuarios u
GO
/****** Object:  Table [dbo].[__RefactorLog]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Accesos]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Bloques]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Boletos]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Facturas]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Filas]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Personas]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Precios]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Presentaciones]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Producciones]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[ProduccionEstados]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Reportes]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
/****** Object:  Table [dbo].[Teatros]    Script Date: 27/7/2020 5:59:24 p. m. ******/
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
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (26, N'Butacas', 13)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (27, N'Preferencial', 14)
INSERT [dbo].[Bloques] ([Id], [NombreBloque], [IdTeatro]) VALUES (28, N'Galeria', 14)
SET IDENTITY_INSERT [dbo].[Bloques] OFF
SET IDENTITY_INSERT [dbo].[Boletos] ON 

INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (1, 2, N'A', 17, CAST(1500.0000 AS Decimal(19, 4)), 0, 2)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (3, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 2, 1)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (4, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 2, 3)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (5, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 2, 4)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (9, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 6, 5)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (10, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 6, 6)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (11, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 6, 7)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (12, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 6, 8)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (13, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 7, 9)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (14, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 7, 10)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (21, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 9, 18)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (22, 2, N'A', 18, CAST(30000.0000 AS Decimal(19, 4)), 10, 1)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (23, 2, N'A', 18, CAST(30000.0000 AS Decimal(19, 4)), 10, 2)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (24, 2, N'D', 25, CAST(15000.0000 AS Decimal(19, 4)), 11, 5)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (25, 2, N'D', 25, CAST(15000.0000 AS Decimal(19, 4)), 11, 6)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (26, 2, N'A', 18, CAST(30000.0000 AS Decimal(19, 4)), 12, 14)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (27, 2, N'A', 18, CAST(30000.0000 AS Decimal(19, 4)), 12, 15)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (28, 2, N'A', 18, CAST(30000.0000 AS Decimal(19, 4)), 12, 16)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (29, 12, N'A', 17, CAST(20000.0000 AS Decimal(19, 4)), 13, 1)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (30, 12, N'A', 17, CAST(20000.0000 AS Decimal(19, 4)), 13, 2)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (34, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 17, 11)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (35, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 18, 12)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (36, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 18, 13)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (37, 2, N'F', 25, CAST(15000.0000 AS Decimal(19, 4)), 19, 15)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (38, 2, N'G', 17, CAST(50000.0000 AS Decimal(19, 4)), 20, 10)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (39, 2, N'G', 17, CAST(50000.0000 AS Decimal(19, 4)), 20, 11)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (40, 2, N'G', 17, CAST(50000.0000 AS Decimal(19, 4)), 20, 12)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (41, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 21, 14)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (42, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 21, 15)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (43, 2, N'A', 17, CAST(50000.0000 AS Decimal(19, 4)), 21, 16)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (44, 12, N'E', 17, CAST(20000.0000 AS Decimal(19, 4)), 22, 1)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (45, 12, N'E', 17, CAST(20000.0000 AS Decimal(19, 4)), 22, 2)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (46, 12, N'E', 17, CAST(20000.0000 AS Decimal(19, 4)), 22, 3)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (47, 12, N'E', 17, CAST(20000.0000 AS Decimal(19, 4)), 22, 4)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (48, 12, N'E', 17, CAST(20000.0000 AS Decimal(19, 4)), 22, 5)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (49, 12, N'E', 17, CAST(20000.0000 AS Decimal(19, 4)), 22, 6)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (50, 12, N'E', 17, CAST(20000.0000 AS Decimal(19, 4)), 22, 7)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (51, 12, N'E', 17, CAST(20000.0000 AS Decimal(19, 4)), 22, 8)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (52, 13, N'D', 18, CAST(15000.0000 AS Decimal(19, 4)), 23, 38)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (53, 13, N'D', 18, CAST(15000.0000 AS Decimal(19, 4)), 23, 39)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (54, 13, N'D', 18, CAST(15000.0000 AS Decimal(19, 4)), 23, 40)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (55, 13, N'D', 18, CAST(15000.0000 AS Decimal(19, 4)), 23, 41)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (56, 13, N'D', 18, CAST(15000.0000 AS Decimal(19, 4)), 23, 42)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (57, 13, N'D', 18, CAST(15000.0000 AS Decimal(19, 4)), 23, 1)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (58, 13, N'D', 18, CAST(15000.0000 AS Decimal(19, 4)), 23, 2)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (59, 17, N'A', 28, CAST(3000.0000 AS Decimal(19, 4)), 24, 1)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (60, 17, N'A', 28, CAST(3000.0000 AS Decimal(19, 4)), 24, 2)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (61, 17, N'A', 28, CAST(3000.0000 AS Decimal(19, 4)), 24, 3)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (62, 17, N'A', 28, CAST(3000.0000 AS Decimal(19, 4)), 24, 4)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (63, 17, N'A', 28, CAST(3000.0000 AS Decimal(19, 4)), 24, 5)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (64, 17, N'A', 27, CAST(5000.0000 AS Decimal(19, 4)), 25, 3)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (65, 17, N'A', 27, CAST(5000.0000 AS Decimal(19, 4)), 25, 4)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (66, 17, N'A', 27, CAST(5000.0000 AS Decimal(19, 4)), 25, 5)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (67, 17, N'B', 28, CAST(3000.0000 AS Decimal(19, 4)), 26, 3)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (68, 17, N'B', 28, CAST(3000.0000 AS Decimal(19, 4)), 26, 4)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (69, 17, N'B', 28, CAST(3000.0000 AS Decimal(19, 4)), 27, 5)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (70, 17, N'B', 28, CAST(3000.0000 AS Decimal(19, 4)), 27, 6)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (71, 17, N'B', 28, CAST(3000.0000 AS Decimal(19, 4)), 27, 7)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (72, 17, N'B', 28, CAST(3000.0000 AS Decimal(19, 4)), 27, 8)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (73, 17, N'A', 27, CAST(5000.0000 AS Decimal(19, 4)), 28, 1)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (74, 17, N'A', 27, CAST(5000.0000 AS Decimal(19, 4)), 28, 2)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (75, 16, N'A', 27, CAST(5000.0000 AS Decimal(19, 4)), 29, 1)
INSERT [dbo].[Boletos] ([Id], [IdPresentacion], [LetraFila], [IdBloqueFila], [Precio], [IdFactura], [NumAsiento]) VALUES (76, 16, N'A', 27, CAST(5000.0000 AS Decimal(19, 4)), 29, 2)
SET IDENTITY_INSERT [dbo].[Boletos] OFF
SET IDENTITY_INSERT [dbo].[Facturas] ON 

INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (0, N'Carlos perez', N'apatito@gmail', CAST(N'2020-07-23' AS Date), 88963252, CAST(N'12:00:00' AS Time), 375)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (2, N'Pancho Sancho', N'joaquinenrique2010@gmail.com', CAST(N'2020-07-25' AS Date), 60032280, CAST(N'14:26:51.0066814' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (6, N'Pancho Sancho', N'dasd@gmail.com', CAST(N'2020-07-26' AS Date), 60032280, CAST(N'11:33:24.8567575' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (7, N'Joaquin Jimenez', N'joaquinenrique2010@gmail.com', CAST(N'2020-07-26' AS Date), 60032280, CAST(N'12:04:19.4746290' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (9, N'Raul Ramirez', N'haja@jaja.com', CAST(N'2020-07-26' AS Date), 55441122, CAST(N'13:40:43.6018111' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (10, N'Cabro Naro', N'jaed@das.com', CAST(N'2020-07-26' AS Date), 85746378, CAST(N'14:59:02.8587844' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (11, N'Pancho Sancho', N'23123@gmail.com', CAST(N'2020-07-26' AS Date), 85746378, CAST(N'15:08:41.1948388' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (12, N'Carlos Alvarado', N'carlitosAlva@fmail.com', CAST(N'2020-07-26' AS Date), 12345678, CAST(N'15:34:30.6384079' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (13, N'Joaquin Jimenez', N'joaquinenrique2010@gmail.com', CAST(N'2020-07-26' AS Date), 60032280, CAST(N'15:38:58.6877868' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (17, N'Joquinlo Jimnez', N'joaquinenrique2010@gmail.com', CAST(N'2020-07-26' AS Date), 85746378, CAST(N'16:16:04.6996016' AS Time), 75)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (18, N'Jose Gamboa', N'kasm2@gtm.com', CAST(N'2020-07-26' AS Date), 74859612, CAST(N'16:49:07.9160571' AS Time), 114690)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (19, N'Joquinlo Jimnez', N'pruebatecjj@gmail.com', CAST(N'2020-07-26' AS Date), 85746378, CAST(N'17:56:13.4061338' AS Time), 783806)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (20, N'Joaquin Jimenez', N'pruebatecjj@gmail.com', CAST(N'2020-07-26' AS Date), 60032280, CAST(N'18:15:06.2062457' AS Time), 629580)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (21, N'Pablo Gomez', N'pruebatecjj@gmail.com', CAST(N'2020-07-26' AS Date), 20102326, CAST(N'18:29:08.6799982' AS Time), 171322)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (22, N'Jose Pablo Garcia', N'pruebatecjj@gmail.com', CAST(N'2020-07-26' AS Date), 44556633, CAST(N'18:58:53.7438895' AS Time), 689899)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (23, N'Joaquin Jimenez', N'pruebatecjj@gmail.com', CAST(N'2020-07-26' AS Date), 60032280, CAST(N'19:03:41.0897875' AS Time), 491432)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (24, N'Lorena Portillo Vargas', N'pruebatecjj@gmail.com', CAST(N'2020-07-27' AS Date), 76955860, CAST(N'14:34:26.1382387' AS Time), 234267)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (25, N'Adrian Alarcon Garcia', N'pruebatecjj@gmail.com', CAST(N'2020-07-27' AS Date), 76955860, CAST(N'14:38:43.1320660' AS Time), 656696)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (26, N'Adrian Alarcon Garcia', N'pruebatecjj@gmail.com', CAST(N'2020-07-27' AS Date), 76955860, CAST(N'14:39:56.0969930' AS Time), 953989)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (27, N'Emilio Granados Herrera', N'pruebatecjj@gmail.com', CAST(N'2020-07-27' AS Date), 84417390, CAST(N'14:51:37.1980727' AS Time), 604818)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (28, N'Leonardo Quirós Quirós', N'pruebatecjj@gmail.com', CAST(N'2020-07-27' AS Date), 89571024, CAST(N'14:57:15.7198539' AS Time), 429527)
INSERT [dbo].[Facturas] ([Id], [NombreCliente], [Email], [Fecha], [Telefono], [Hora], [NumeroAprobacion]) VALUES (29, N'Leonardo Quirós Quirós', N'pruebatecjj@gmail.com', CAST(N'2020-07-27' AS Date), 89571024, CAST(N'15:00:37.5373497' AS Time), 627466)
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
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 18, 26)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 6, 27)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'A', 8, 28)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 30, 18)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 14, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 24, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 14, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 10, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 11, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 12, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 20, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 20, 26)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'B', 8, 28)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 32, 18)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 13, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 27, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 13, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 11, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 12, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 13, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 15, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'C', 22, 26)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 24, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 42, 18)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 12, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 30, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 12, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 10, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 11, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 12, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 10, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'D', 14, 26)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 26, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 12, 19)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 30, 20)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 12, 21)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 11, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 12, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 11, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 30, 25)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'E', 14, 26)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 26, 17)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 10, 22)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 11, 23)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 10, 24)
INSERT [dbo].[Filas] ([Letra], [NumAsientos], [IdBloque]) VALUES (N'F', 15, 25)
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
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Generosa Vega Carreras', CAST(N'1947-12-25' AS Date), 107890444, N'Tejar', 64409720, 64409720, NULL, N'generosa@inbound.com', 13, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Hugo Rios Delgado', CAST(N'1978-05-02' AS Date), 108240665, N'Ciudad Colon', 63596099, 63596099, NULL, N'hrd@mimail.cim', 14, N'M')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Melisa Aleman Carrera', CAST(N'1980-02-08' AS Date), 109450564, N'Pavas', 86320431, 86320431, 65119247, N'meli@teatroscr.com', NULL, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Nicolás Angulo Mesa', CAST(N'0001-01-01' AS Date), 109710805, N'Guayabos', 91178174, NULL, NULL, N'nicolas@outbound.com', 10, N'M')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Lelis Padilla Trejos', CAST(N'1995-12-06' AS Date), 110400894, N'Tibas', 74490857, 74490857, NULL, N'lpt@uteatro.com', 14, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Karla Trejos Rojas', CAST(N'1989-06-10' AS Date), 111490429, N'Ceibo', 64196092, 64196092, NULL, N'ktrejos@inbound.com', 13, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Mariola Bolaños Acevedo', CAST(N'0001-01-01' AS Date), 204960060, N'Paseo Colón', 42095437, NULL, NULL, N'marboa@otromail.com', 11, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Ariel Conejo', CAST(N'0001-01-01' AS Date), 206710046, N'Curridabat', 98712584, 24315954, 88760431, N'ari@mimail.com', NULL, N'M')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Melusina Duran Naranjo', CAST(N'1988-10-31' AS Date), 306260506, N'Cartago', 89410518, 89410518, NULL, N'mdn@uteatro.com', 14, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Yocasta Nazario Alcantar', CAST(N'1995-03-29' AS Date), 306290526, N'Colonia', 84062795, 84062795, 98341131, N'ynazario@mimail.com', 13, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Lisandra Bravo Hidalgo', CAST(N'1984-02-12' AS Date), 402950337, N'Lagunilla', 83945052, 83945052, NULL, N'lisbh@otromail.com', 13, N'F')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Joaquin Jimenez Sennrich', CAST(N'0001-01-01' AS Date), 901300979, N'Santa Ana', 60032280, 60032280, 60032280, N'joaquinenrique2010@gmail.com', NULL, N'M')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Pablo Escoba', CAST(N'1995-02-12' AS Date), 901314578, N'Pavas', 99663322, 99663322, NULL, N'pabloesco@tea.com', 10, N'M')
INSERT [dbo].[Personas] ([Nombre], [FechaNac], [Cedula], [Direccion], [TelefonoCelular], [TelefonoCasa], [TelefonoOtro], [Email], [IdTeatro], [Sexo]) VALUES (N'Carlos Moreno', CAST(N'1990-12-12' AS Date), 902354876, N'Ciudad Colon', 88445522, 88445522, NULL, N'carlito@Tcr.cr', 11, N'M')
SET IDENTITY_INSERT [dbo].[Precios] ON 

INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (0, CAST(50000.0000 AS Decimal(19, 4)), 11, 17)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (1, CAST(30000.0000 AS Decimal(19, 4)), 11, 18)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (2, CAST(10000.0000 AS Decimal(19, 4)), 11, 19)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (3, CAST(12000.0000 AS Decimal(19, 4)), 11, 20)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (4, CAST(10000.0000 AS Decimal(19, 4)), 11, 21)
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
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (16, CAST(25000.0000 AS Decimal(19, 4)), 12, 17)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (25, CAST(8000.0000 AS Decimal(19, 4)), 15, 26)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (26, CAST(5000.0000 AS Decimal(19, 4)), 16, 27)
INSERT [dbo].[Precios] ([Id], [Precio], [IdProduccion], [IdBloque]) VALUES (27, CAST(3000.0000 AS Decimal(19, 4)), 16, 28)
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
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (14, CAST(N'2019-06-23' AS Date), CAST(N'21:00:00' AS Time), 15)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (15, CAST(N'2019-07-30' AS Date), CAST(N'21:00:00' AS Time), 15)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (16, CAST(N'2020-08-10' AS Date), CAST(N'15:00:00' AS Time), 16)
INSERT [dbo].[Presentaciones] ([Id], [Fecha], [Hora], [IdProduccion]) VALUES (17, CAST(N'2020-08-16' AS Date), CAST(N'15:00:00' AS Time), 16)
SET IDENTITY_INSERT [dbo].[Presentaciones] OFF
SET IDENTITY_INSERT [dbo].[Producciones] ON 

INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (11, N'Bodas de sangre', CAST(N'2019-06-09' AS Date), CAST(N'2019-06-12' AS Date), N'teatro', 10, N'Se presenta con todo lujo la gran obra de Federico García Lorca.', 3)
INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (12, N'Jovenes Coreografos 2016', CAST(N'2019-07-16' AS Date), CAST(N'2019-07-16' AS Date), N'danza', 10, N'Cinco coreógrafos jóvenes nos muestran sus trabajos.', 5)
INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (13, N'Bolero Filarmonico', CAST(N'2019-06-17' AS Date), CAST(N'2019-06-26' AS Date), N'musica', 11, N'La Orquesta Filarmónica se luce interpretando boleros clásicos que llegan al corazón de todos los románticos.', 3)
INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (14, N'III Concierto Temporada Oficial', CAST(N'2020-08-15' AS Date), CAST(N'2020-08-20' AS Date), N'Concierto', 10, N'24 y 26 abril, 2020  Sylvain Gasançon, director invitado  Solista invitada: Rachel Barton, violín  Programa:  Rossini, Obertura La italiana en Argel  Saint -Saëns, Concierto para violín No. 3  Brahms, Sinfonía No. 2', 3)
INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (15, N'Escape del taxi', CAST(N'2019-06-23' AS Date), CAST(N'2019-07-30' AS Date), N'otro', 13, N'Tres conocidos comediantes ofrecen su mejor repertorio de comedia stand-up recordando sus aventuras en taxi.', 3)
INSERT [dbo].[Producciones] ([Id], [NombreObra], [FechaInit], [FechaFin], [Tipo], [IdTeatro], [Descripcion], [IdProduccionEstado]) VALUES (16, N'Aventura Submarina', CAST(N'2020-07-23' AS Date), CAST(N'2020-08-31' AS Date), N'teatro', 14, N'Historias fantásticas para todo público', 3)
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
INSERT [dbo].[Reportes] ([Id], [Fecha], [Cantidad], [CostoPromedio]) VALUES (7, CAST(N'2020-07-26' AS Date), 41, CAST(31707.3171 AS Decimal(19, 4)))
INSERT [dbo].[Reportes] ([Id], [Fecha], [Cantidad], [CostoPromedio]) VALUES (8, CAST(N'2020-07-26' AS Date), 41, CAST(31707.3171 AS Decimal(19, 4)))
SET IDENTITY_INSERT [dbo].[Reportes] OFF
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Diagram_27/07/2020', 1, 1, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000000200000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF20000000FEFFFFFF04000000050000000600000007000000080000001F0000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E000000FEFFFFFF33000000FEFFFFFF22000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F000000300000003100000032000000FEFFFFFF34000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000200E30325B64D60103000000C0110000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000000000000F60B0000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000009000000972B000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000300000005F000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F000000FEFFFFFF31000000FEFFFFFFFEFFFFFF3400000035000000360000003700000038000000390000003A0000003B0000003C0000003D0000003E0000003F000000400000004100000042000000430000004400000045000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000434000A1E500C05000080270000000F00FFFF4600000027000000007D0000229B0000F35A00001BDB00006B7F000023DFFFFFA00F0000DE805B10F195D011B0A000AA00BDCB5C0000080030000000000200000300000038002B00000009000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002C004320000000000000000000000491D3F4510237498DFAD5149225458B34C9D2777977D811907000065B840D9C00002C00432000000000000000000000AF6D39AA8ACF8E4E9209FD39BFEEEC0F34C9D2777977D811907000065B840D9C27000000FC0A000000A7013100003000A50900000700008001000000A002000000800000070000805363684772696400960000007869000041636365736F730000003000A50900000700008002000000A002000000800000070000805363684772696400DE3F0000DC500000426C6F717565730000003000A50900000700008003000000A002000000800000070000805363684772696400825F0000E8350000426F6C65746F730000003000A50900000700008004000000A202000000800000080000805363684772696400825F00008C550000466163747572617300006C00A50900000700008005000000520000000180000043000080436F6E74726F6C000D6900003149000052656C6174696F6E736869702027464B5F426F6C65746F5F546F4661637475726127206265747765656E202746616374757261732720616E642027426F6C65746F73270000002800B50100000700008006000000310000005900000002800000436F6E74726F6C005B5E00002050000000003000A509000007000080070000009C02000000800000050000805363684772696400DE3F00008A66000046696C617369640000006800A5090000070000800800000062000000018000003E000080436F6E74726F6C003A5500008F3F000052656C6174696F6E736869702027464B5F426F6C65746F5F546F46696C617327206265747765656E202746696C61732720616E642027426F6C65746F7327000000002800B50100000700008009000000310000005500000002800000436F6E74726F6C006D4F00004854000000006800A5090000070000800A00000052000000018000003D000080436F6E74726F6C00694900003D5A000052656C6174696F6E736869702027464B5F46696C61735F426C6F7175657327206265747765656E2027426C6F717565732720616E64202746696C61732727000000002800B5010000070000800B000000310000005300000002800000436F6E74726F6C0014410000C761000000003000A5090000070000800C000000A202000000800000080000805363684772696400A41F00000A410000506572736F6E617300003000A5090000070000800D000000A002000000800000070000805363684772696400DE3F0000D638000050726563696F730000006C00A5090000070000800E000000520000000180000041000080436F6E74726F6C0069490000AE44000052656C6174696F6E736869702027464B5F50726563696F735F426C6F7175657327206265747765656E2027426C6F717565732720616E64202750726563696F732773270000002800B5010000070000800F000000310000005700000002800000436F6E74726F6C00AF4B00000B4B000000003800A50900000700008010000000AE020000008000000E0000805363684772696400186000002823000050726573656E746163696F6E6573000000007800A50900000700008011000000520000000180000050000080436F6E74726F6C000D690000042F000052656C6174696F6E736869702027464B5F426F6C65746F5F546F50726573656E746163696F6E657327206265747765656E202750726573656E746163696F6E65732720616E642027426F6C65746F732700002800B50100000700008012000000310000006700000002800000436F6E74726F6C004C5A00008B33000000003400A50900000700008013000000AA020000008000000C000080536368477269640000000000D638000050726F64756363696F6E657300007400A5090000070000801400000062000000018000004B000080436F6E74726F6C005C150000633E000052656C6174696F6E736869702027464B5F50726563696F735F50726F64756363696F6E657327206265747765656E202750726F64756363696F6E65732720616E64202750726563696F73276500002800B50100000700008015000000310000006100000002800000436F6E74726F6C0090180000D73D000000008400A50900000700008016000000620000000180000059000080436F6E74726F6C005C1500000524000052656C6174696F6E736869702027464B5F50726573656E746163696F6E65735F50726F64756363696F6E657327206265747765656E202750726F64756363696F6E65732720616E64202750726573656E746163696F6E65732700000000002800B50100000700008017000000310000006F00000002800000436F6E74726F6C00591800007923000000003C00A50900000700008018000000B402000000800000110000805363684772696400000000003C5A000050726F64756363696F6E45737461646F7300000000008800A5090000070000801900000052000000018000005F000080436F6E74726F6C008B0900009A4E000052656C6174696F6E736869702027464B5F50726F64756363696F6E65735F50726F64756363696F6E45737461646F7327206265747765656E202750726F64756363696F6E45737461646F732720616E64202750726F64756363696F6E6573270000002800B5010000070000801A000000310000007500000002800000436F6E74726F6C00D10B00001D55000000003000A5090000070000801B000000A2020000008000000800008053636847726964006AFFFFFFBE2300005265706F7274657300003000A5090000070000801C000000A0020000008000000700008053636847726964000E1F0000AC26000054656174726F730000006C00A5090000070000801D000000620000000180000041000080436F6E74726F6C006A3400000B2F000052656C6174696F6E736869702027464B5F426C6F717565735F54656174726F7327206265747765656E202754656174726F732720616E642027426C6F717565732700000000002800B5010000070000801E000000310000005700000002800000436F6E74726F6C00552C00000348000000006C00A5090000070000801F000000520000000180000043000080436F6E74726F6C002F2900007E37000052656C6174696F6E736869702027464B5F506572736F6E61735F54656174726F7327206265747765656E202754656174726F732720616E642027506572736F6E6173270000002800B50100000700008020000000310000005900000002800000436F6E74726F6C00431E0000F33C000000007400A5090000070000802100000062000000018000004B000080436F6E74726F6C005C150000B32C000052656C6174696F6E736869702027464B5F50726F64756363696F6E65735F54656174726F7327206265747765656E202754656174726F732720616E64202750726F64756363696F6E6573273000002800B50100000700008022000000310000006100000002800000436F6E74726F6C00490E0000D539000000003000A50900000700008023000000A202000000800000080000805363684772696400A41F00004C6800005573756172696F7300007000A50900000700008024000000520000000180000045000080436F6E74726F6C002F290000E35C000052656C6174696F6E736869702027464B5F5573756172696F735F506572736F6E617327206265747765656E2027506572736F6E61732720616E6420275573756172696F732700000B00002800B50100000700008025000000310000005B00000002800000436F6E74726F6C73D01D00004763000000007000A50900000700008026000000520000000180000045000080436F6E74726F6C00F2150000916C000052656C6174696F6E736869702027464B5F5573756172696F735F546F41636365736F7327206265747765656E202741636365736F732720616E6420275573756172696F732700350000002800B50100000700008027000000310000005D00000002800000436F6E74726F6C00BE140000D76E0000000000000000000000002143341208000000881600009D090000785634120700000014010000410063006300650073006F0073000000B200000000000000000000002400000002000000030000000400000008000000000000000000000024000000030000000300000004000000040000000000000000000000240000000000000000000000010000000400000000000000240000002B000000020000000000000001000000040000000000000024000000550000000100000000000000060000000400000000000000240000005600000003000000000000000700000004000000000000003B000000570000000400000000000000030000000400000000000000240000008A00000000000000030000000500000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000008000000410063006300650073006F0073000000214334120800000088160000180C000078563412070000001401000042006C006F0071007500650073000000E0C54132ECBD4132B8BD4132884241324042413210B14132B0B041329CB1413260B141321CB24132E8B14132F8BE4132B8BE4132B0254132F8244132FCC34132B8C3413204C74132C0C64132FCB94132C0B94132C8C8413284C8413230CB4132ECCA413200CC4132CCCB4132000000009400000054264132FC25413224C04132E8BF4132B4C0413270C041326CC9413228C9413288BF413244BF413254CD413200CD413274B9413234B9413294C1413250C1413254B841320CB84132A0C441325CC441328C3F41324C3F4132E8B84132ACB841326CBE413238BE413258C3000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000AA0A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000800000042006C006F00710075006500730000002143341208000000881600000416000078563412070000001401000042006F006C00650074006F0073000000000000008CB0A502F70D000685597D229F2381220D00000080809330D4DE8001CC5B4132000000006F02FFFF60809330E601000000000000C018040000000000000000008CB0A502F80D000696597D22AD23812204000000808093304CFC16FBD45B4132000000007002FFFF60809330E6010000000000003419040000000000000000008CB0A502F90D0006D7597D22B92381220500000080809330F0577E7EDC5B4132000000007102FFFF60809330E6010000000000006019040000000000000000008CB0A502FA0D0006B9597D22B22381220600000080809330678E000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000416000000000000070000000700000002000000020000001C01000060090000000000000100000039130000D910000000000000060000000600000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000800000042006F006C00650074006F007300000021433412080000008816000004160000785634120700000014010000460061006300740075007200610073000000812206000000808093307AB90E7BBC5B4132000000006D02FFFF60809330E6090000000000006F18040000000000000000008CB0A502F60D0006A6577D227320812206000000808093301E3C6BE1C45B4132000000006E02FFFF0000000000000000E4B1EBBB000B0080000000000001000060809330E609000000000000B417040000000000000000008CB0A502EB0D000682567D22592081220600000080809330C192EE936C5B4132000000006302FFFF60809330E609000000000000C217040000000000000000008CB0A502EC0D0006A1567D22852081220600000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000416000000000000070000000700000002000000020000001C010000AA0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000900000046006100630074007500720061007300000002000B00A46A00008C550000A46A0000EC4B00000000000002000000F0F0F000000000000000000000000000000000000100000006000000000000005B5E0000205000009A0B000058010000310000000100000200009A0B000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61130046004B005F0042006F006C00650074006F005F0054006F004600610063007400750072006100214334120800000088160000180C0000785634120700000014010000460069006C006100730000008CB0A502190E0006C26A7D22C8EA80220600000080809330EE7BCB42405D4132000000009600FFFF608093308300000000000000501F040000000000000000008CB0A5021A0E0006E69B7D224FD480220400000080809330FFFFFFFF485D4132000000002903FFFF0000000000000000D1B0FEBA000400800000000000010000608093308300000000000000A01F040000000000000000008CB0A5021B0E0006449C7D22072981220700000080809330FFFFFFFF545D4132000000002A03FFFF608093308100000000000000A020040000000000000000008CB0A5021C0E00065F9C000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000AA0A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005400000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000006000000460069006C0061007300000004000B0066560000666C0000E9590000666C0000E95900000A410000825F00000A4100000000000002000000F0F0F000000000000000000000000000000000000100000009000000000000006D4F000048540000CD0900005801000031000000010000020000CD09000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61110046004B005F0042006F006C00650074006F005F0054006F00460069006C006100730002000B00004B0000F45C0000004B00008A6600000000000002000000F0F0F00000000000000000000000000000000000010000000B0000000000000014410000C76100003D090000580100003B0000000100000200003D09000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61100046004B005F00460069006C00610073005F0042006C006F007100750065007300214334120800000097160000901E000078563412070000001401000050006500720073006F006E00610073000000040000000000000000008CB0A5021E0E00068B9C7D22F5D380220300000080809330FFFFFFFF785D4132000000002D03FFFF0000000000000000B2B0DDBA00050080000000000001000060809330E6090000000000000D18040000000000000000008CB0A502EF0D0006F8567D22352081220600000080809330F308080B8C5B4132000000006702FFFF60809330E6090000000000001B18040000000000000000008CB0A502F00D00065C5B7D22472081220600000080809330D49527DA945B4132000000006802FFFF60809330E609000000000000291804000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000C3200000000000002D0100000C0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000097160000901E0000000000000A0000000A00000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000900000050006500720073006F006E00610073000000214334120800000088160000930E0000785634120700000014010000500072006500630069006F007300000000000000050000001B000000900100000000000060000000600000002000FDFF1F002000000000270000000000020B06040305040402043440000000080000000100000000000000000000000008000008000000FEFFFFFF000000000600000003000000F9FFFFFF0B00000014000000FBFFFFFF0B000000FEFFFFFF00000000090000000800000007000000000000000200000008000000070000000000000005000000010000000400000001000000FFFFFFFFD8000000E6000000F4000000020100005400610068006F006D00610000005400610068006F006D006100000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000AA0A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000008000000500072006500630069006F007300000002000B00004B0000DC500000004B0000694700000000000002000000F0F0F00000000000000000000000000000000000010000000F00000000000000AF4B00000B4B0000B40A00005801000037000000010000020000B40A000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61120046004B005F00500072006500630069006F0073005F0042006C006F007100750065007300214334120800000088160000930E0000785634120700000014010000500072006500730065006E0074006100630069006F006E006500730000000008024B024B0000029902990001079F079F000209B51E7D58BB0A2A008000040B940B9400220B960B9600230E410E4200240001000102960001000102A00002000702A002BD000002C102CA001E077D41BB002B0080204F243B0E0000000F00000000000000500072006500730065006E0074006100630069006F006E006500730000000A9A0C7D4ABB0A2C0080204F243B0C0000000F0000000000000049006400500072006F00640075006300630069006F006E000000000002990001F57D33BB002D008009B500030A8D0AAA0004000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000AA0A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000F000000500072006500730065006E0074006100630069006F006E0065007300000002000B00A46A0000BB310000A46A0000E83500000000000002000000F0F0F000000000000000000000000000000000000100000012000000000000004C5A00008B330000A90F00005801000040000000010000020000A90F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611A0046004B005F0042006F006C00650074006F005F0054006F00500072006500730065006E0074006100630069006F006E00650073002143341208000000881600007F180000785634120700000014010000500072006F00640075006300630069006F006E00650073000000001E807CDEBA00180080204F243B0E0000000F00000000000000500072006500730065006E0074006100630069006F006E006500730000000A9A897CC7BA0A1900800AAA0E410E4200030002004E005A0001008E0003001A0054008800010000004A00020008024B024B00000299029900018E7CC8BA001A0080204F243B0E0000000F00000000000000500072006500730065006E0074006100630069006F006E006500730000006D31777DB1BA021B008002CD02E7002809B709B700430AAB0AAB00440B5B0B6200450E3D0E40004D00010001000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000371C0000000000002D0100000A0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600007F18000000000000080000000800000002000000020000001C010000C80A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D000000500072006F00640075006300630069006F006E0065007300000004000B0088160000E6460000A41D0000E6460000A41D0000DE3F0000DE3F0000DE3F00000000000002000000F0F0F0000000000000000000000000000000000001000000150000000000000090180000D73D0000A10D00005801000030000000010000020000A10D000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61170046004B005F00500072006500630069006F0073005F00500072006F00640075006300630069006F006E006500730004000B0088160000624300009C1A0000624300009C1A00008025000018600000802500000000000002000000F0F0F0000000000000000000000000000000000001000000170000000000000059180000792300000512000058010000310000000100000200000512000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F00500072006500730065006E0074006100630069006F006E00650073005F00500072006F00640075006300630069006F006E00650073002143341208000000881600009D090000785634120700000014010000500072006F00640075006300630069006F006E00450073007400610064006F00730000006A7DA4BA021E0080204F243B0E0000000F00000000000000500072006500730065006E0074006100630069006F006E00650073000000000F537DADBA0A1F00800A930A940A980A9A0A9D0AA30AA60AA70AAA0E410E4200030004001C001C0050005C0001009000020056008A00010000587D96BA00200080024B0000029902990001079F079F000209B509B500030A8D0AAA00040B940B9400220B960B9600230E410E4200240001417D9FBA00210080204F243B0C0000000F0000000000000049004400500052004F00000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000012000000500072006F00640075006300630069006F006E00450073007400610064006F007300000002000B00220B00003C5A0000220B0000555100000000000002000000F0F0F00000000000000000000000000000000000010000001A00000000000000D10B00001D550000F01300005801000032000000010000020000F013000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61210046004B005F00500072006F00640075006300630069006F006E00650073005F00500072006F00640075006300630069006F006E00450073007400610064006F007300214334120800000088160000930E00007856341207000000140100005200650070006F00720074006500730000000A93B67CF0BA0A120080204F243B0C0000000F0000000000000049006400500072006F00640075006300630069006F006E0000000001000102A0BF7CF9BA02130080000002C102CA001E02CD02E7002809B709B700430AAB0AAB00440B5B0B6200450E3D0E40004D0001000102D20001000FA47CE2BA0A1400800A930A940A980A9A0A9D0AA30AA60AA70AAA0E410E4200030003001A0020002E0001006200020028005C00010000004AAD7CEBBA0215008000020298029B0001000102A00002000702A002BD000002C102CA001E02CD02E7002809B709B700430AAB000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000090000005200650070006F007200740065007300000021433412080000008816000089130000785634120700000014010000540065006100740072006F0073000000E02E0000E02E0000391300004D0C000000000000000000000B960B96347D72BB0E2400800001000102960001000102A00002000702A002BD000002C102CA001E02CD02E7002809B709B700430AAB0AAB00440B5B3D7D7BBB0E250080004D0001000102E30001000F09B50A8F0A900A910A930A940A980A9A0A9D0AA30AA60AA70AAA0E410E4200030004001E227D7CBB0026008000920003001E0058008C00010000004A00020008024B024B0000029902990001079F079F000209B509B500030A8D0AAA2B7D65BB0B2700800B960B9600230E410E420024000100010296000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000AB170000000000002D010000080000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600008913000000000000060000000600000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000008000000540065006100740072006F007300000004000B0096350000A23000000E380000A23000000E380000B8560000DE3F0000B85600000000000002000000F0F0F00000000000000000000000000000000000010000001E00000000000000552C0000034800000A0B000058010000340000000100000200000A0B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61120046004B005F0042006C006F0071007500650073005F00540065006100740072006F00730002000B00C62A0000353A0000C62A00000A4100000000000002000000F0F0F00000000000000000000000000000000000010000002000000000000000431E0000F33C0000D40B00005801000032000000010000020000D40B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61130046004B005F0050006500720073006F006E00610073005F00540065006100740072006F00730004000B000E1F00004A2E0000F01C00004A2E0000F01C00002445000088160000244500000000000002000000F0F0F00000000000000000000000000000000000010000002200000000000000490E0000D5390000F80D00005801000032000000010000020000F80D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61170046004B005F00500072006F00640075006300630069006F006E00650073005F00540065006100740072006F007300214334120800000088160000930E00007856341207000000140100005500730075006100720069006F007300000002CA977DD1BB023B008009B709B700430AAB0AAB00440B5B0B6200450E3D0E40004D0001000102E30001000F09B50A8F0A900A910A930A940A989C7DDABB0A3C00800AA70AAA0E410E4200030004001C005000560064000100980002005E009200010000004A00020008024B024B00000299857DC3BB073D0080204F243B0E0000000F00000000000000500072006500730065006E0074006100630069006F006E0065007300000000018A7DC4BB003E0080204F243B080000000F0000000000000050006500720073006F006E0061007300000000450E3D0E40004D000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000C80A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F000000090000005500730075006100720069006F007300000002000B00C62A00009A5F0000C62A00004C6800000000000002000000F0F0F00000000000000000000000000000000000010000002500000000000000D01D000047630000470C00005801000032000000010000020000470C000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61140046004B005F005500730075006100720069006F0073005F0050006500720073006F006E006100730002000B001E170000286E0000A41F0000286E00000000000002000000F0F0F00000000000000000000000000000000000010000002700000000000000BE140000D76E0000110D00005801000034000000010000020000110D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61150046004B005F005500730075006100720069006F0073005F0054006F00410063006300650073006F0073000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F57390000020090AE2E325B64D601020200001048450000000000000000000000000000000000E40100004400610074006100200053006F0075007200630065003D004400450053004B0054004F0050002D004500440037004E003400410032003B0049006E0069007400690061006C00200043006100740061006C006F0067003D00530069007300740065006D006100540065006100740072006F0073005F004200440031003B0049006E00740065006700720061007400650064002000530065006300750072006900740079003D0054007200750065003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B0043006F006E006E006500630074002000540069006D0065006F000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000021000000E72200000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000320000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000033000000B60400000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000004600000012000000000000000C00000023DFFFFFA00F00000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000030000000300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400300030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000040000000400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000500000005000000000000003800000001FFFFFF01000000640062006F00000046004B005F0042006F006C00650074006F005F0054006F00460061006300740075007200610000000000000000000000C402000000000600000006000000050000000800000001E1843198E184310000000000000000AD0F0000010000070000000700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000800000008000000000000003400000001FFFFFF01000000640062006F00000046004B005F0042006F006C00650074006F005F0054006F00460069006C006100730000000000000000000000C402000000000900000009000000080000000800000001E2843118E284310000000000000000AD0F00000100000A0000000A000000000000003200000001FFFFFF01000000640062006F00000046004B005F00460069006C00610073005F0042006C006F00710075006500730000000000000000000000C402000000000B0000000B0000000A0000000800000001E28431D8E284310000000000000000AD0F00000100000C0000000C00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000D0000000D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000E0000000E000000000000003600000001FFFFFF01000000640062006F00000046004B005F00500072006500630069006F0073005F0042006C006F00710075006500730000000000000000000000C402000000000F0000000F0000000E0000000800000001E0843118E084310000000000000000AD0F0000010000100000001000000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000110000001100000000000000460000000100000001000000640062006F00000046004B005F0042006F006C00650074006F005F0054006F00500072006500730065006E0074006100630069006F006E006500730000000000000000000000C402000000001200000012000000110000000800000001DE8431D8DE84310000000000000000AD0F0000010000130000001300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000140000001400000000000000400000000100700001000000640062006F00000046004B005F00500072006500630069006F0073005F00500072006F00640075006300630069006F006E006500730000000000000000000000C402000000001500000015000000140000000800000001434C2430434C240000000000000000AD0F00000100001600000016000000000000004E0000000100350001000000640062006F00000046004B005F00500072006500730065006E0074006100630069006F006E00650073005F00500072006F00640075006300630069006F006E006500730000000000000000000000C402000000001700000017000000160000000800000001404C2430404C240000000000000000AD0F0000010000180000001800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C003100360038003000000019000000190000000000000054000000014F357501000000640062006F00000046004B005F00500072006F00640075006300630069006F006E00650073005F00500072006F00640075006300630069006F006E00450073007400610064006F00730000000000000000000000C402000000001A0000001A0000001900000008000000017CE030887CE0300000000000000000AD0F00000100001B0000001B00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001C0000001C00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001D0000001D000000000000003600000001FFFFFF01000000640062006F00000046004B005F0042006C006F0071007500650073005F00540065006100740072006F00730000000000000000000000C402000000001E0000001E0000001D000000080000000199F930E099F9300000000000000000AD0F00000100001F0000001F000000000000003800000001FFFFFF01000000640062006F00000046004B005F0050006500720073006F006E00610073005F00540065006100740072006F00730000000000000000000000C4020000000020000000200000001F0000000800000001EE6F3170EE6F310000000000000000AD0F0000010000210000002100000000000000400000000100700001000000640062006F00000046004B005F00500072006F00640075006300630069006F006E00650073005F00540065006100740072006F00730000000000000000000000C402000000002200000022000000210000000800000001EE6F31F0EE6F310000000000000000AD0F0000010000230000002300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002400000024000000000000003A0000000100700001000000640062006F00000046004B005F005500730075006100720069006F0073005F0050006500720073006F006E006100730000000000000000000000C402000000002500000025000000240000000800000001F26F31B0F26F310000000000000000AD0F00000100002600000026000000000000003C0000000100700001000000640062006F00000046004B005F005500730075006100720069006F0073005F0054006F00410063006300650073006F00730000000000000000000000C402000000002700000027000000260000000800000001F06F3130F06F310000000000000000AD0F000001000041000000260000000100000023000000590000005C0000000E000000020000000D00000024000000250000000A0000000200000007000000250000002400000005000000040000000300000024000000250000000800000007000000030000005D0000006E000000240000000C00000023000000250000002400000011000000100000000300000023000000240000001600000013000000100000006D0000005000000014000000130000000D00000079000000600000001900000018000000130000002400000025000000210000001C0000001300000062000000730000001F0000001C0000000C00000027000000240000001D0000001C000000020000006B0000005C0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000750074003D00330030003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D00460061006C00730065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500260000004400690061006700720061006D005F00320037002F00300037002F00320030003200300000000002260010000000410063006300650073006F007300000008000000640062006F000000000226001000000042006C006F007100750065007300000008000000640062006F000000000226001000000042006F006C00650074006F007300000008000000640062006F000000000226001200000046006100630074007500720061007300000008000000640062006F000000000226000C000000460069006C0061007300000008000000640062006F000000000226001200000050006500720073006F006E0061007300000008000000640062006F0000000002260010000000500072006500630069006F007300000008000000640062006F000000000226001E000000500072006500730065006E0074006100630069006F006E0065007300000008000000640062006F000000000226001A000000500072006F00640075006300630069006F006E0065007300000008000000640062006F0000000002260024000000500072006F00640075006300630069006F006E00450073007400610064006F007300000008000000640062006F00000000022600120000005200650070006F007200740065007300000008000000640062006F0000000002260010000000540065006100740072006F007300000008000000640062006F00000000022400120000005500730075006100720069006F007300000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D00000000000000000000000000010003000000000000000C0000000B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
SET IDENTITY_INSERT [dbo].[Teatros] ON 

INSERT [dbo].[Teatros] ([Id], [Nombre], [Boleteria], [Email], [SitioWeb], [Telefono]) VALUES (10, N'Teatro Nacional', 23841182, N'tn@yopmail.com', N'tnc.cr', 2555985)
INSERT [dbo].[Teatros] ([Id], [Nombre], [Boleteria], [Email], [SitioWeb], [Telefono]) VALUES (11, N'Melico Salazar', 58825560, N'tms@otromail.com', N'tms.cr', 8888155)
INSERT [dbo].[Teatros] ([Id], [Nombre], [Boleteria], [Email], [SitioWeb], [Telefono]) VALUES (12, N'Rubén Darío', 22405060, N'rdario@gmail.com', N'rdario.nic.com', 27710045)
INSERT [dbo].[Teatros] ([Id], [Nombre], [Boleteria], [Email], [SitioWeb], [Telefono]) VALUES (13, N'La Colmena', 44404475, N'tlc@yopmail.com', N'tlc.co.cr', 6646701)
INSERT [dbo].[Teatros] ([Id], [Nombre], [Boleteria], [Email], [SitioWeb], [Telefono]) VALUES (14, N'MicroTeatro', 29118192, N'uteatro@otromail.com', N'microteatro.cr', 25467965)
SET IDENTITY_INSERT [dbo].[Teatros] OFF
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'aperez', N'DoSm2TM+7jKpB8zs3yJXSM4k0wVVYT/tPDoRouDNjaXPyfTyNw==', 0, 206710046)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'carltonM', N'Va3wCAE8Z4NOe1FjyekvCXk3cT7hEazgtPSD9MANs/DSouvNyWX0gvWWDA==', 1, 902354876)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'gvega', N'VgUWS+ljmq4DUqjMJx3tOOQ+sNP876oWilvJsiXZ4rlOcVMeJJUx21+G7PfLww==', 1, 107890444)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'gvegaktrejos', N'y8YVX2Idb54lbqaxSyazLo61IvjuOrd4zbbhbk6nlvKp7Jn6fwP1HQ==', 2, 111490429)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'hrios', N'zCoEaA3V7+SLoN/UEvwwiB2QfC7e2x1JSTh5jNGDNWT0oE+MOcPHnMUx7u0=', 1, 108240665)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'JoaJimSen', N'Hc9KI1yCEontlpvQNKkTPna3/FVmKpT8HZTDS5cT5tWXSq2SNKQRF1Yx', 0, 901300979)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'lbravo', N'gHUm/dCqMNwdv9vQoncmuzMrO2TyR7GktvEkz10cGw4t0LJPNs2H4Lw=', 1, 402950337)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'lpadilla', N'5wOYnQdmMVbraASmaEnmw0UJ4qbVek8zSoLV2t7WF2S4ZOfDCSScIjc=', 2, 110400894)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'maleman', N'JHmejGf/en56Xe5mafzti1AcwJF83DOf0UpSXXvpSbvQKu5v73NNvcW6EhGq', 0, 109450564)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'mbolanos', N'Kr3lAgBhmW8dI3LUtWVGRXSlA+yM6uXtOZlJfuQZnQfAzm9mFrv6Hg==', 1, 204960060)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'mduran', N'WavLMA5rQnydokwdFdiebORaYfRaAsn/Cfx2WOTfGtkSbsSsc1Fy2tfX', 2, 306260506)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'nangulo', N'Iz8xv3IMRroVhL0nG4hj+BWAdNLuTo5tsb+WwH2gteFy2PQO6g==', 1, 109710805)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'pabloes', N'z1rpomEVVKUeu6nuVHcKcWLYYNRNCYsFFj39BzRS82MdeYUi9fQMGD8H0nSNNvc=', 2, 901314578)
INSERT [dbo].[Usuarios] ([Usuario], [Password], [IdAcceso], [CedulaPersona]) VALUES (N'ynazario', N'Ei/2qKtnRyVi17ySG8iBF7/qo7zeL0AlCa9CCkn8byKuVErytg==', 2, 306290526)
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_Boletos]    Script Date: 27/7/2020 5:59:25 p. m. ******/
ALTER TABLE [dbo].[Boletos] ADD  CONSTRAINT [AK_Boletos] UNIQUE NONCLUSTERED 
(
	[LetraFila] ASC,
	[IdBloqueFila] ASC,
	[IdPresentacion] ASC,
	[NumAsiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [AK_Precios]    Script Date: 27/7/2020 5:59:25 p. m. ******/
ALTER TABLE [dbo].[Precios] ADD  CONSTRAINT [AK_Precios] UNIQUE NONCLUSTERED 
(
	[IdProduccion] ASC,
	[IdBloque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_principal_name]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddBloque]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddFila]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddPersonaAndUsuario]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddPrecio]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddPresentacion]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddProduccion]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddTeatro]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spCambiarEstadoProduccion]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spCompraBoletosYFactura]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
			RAISERROR('Algún asiento ya fue comprado.',16,1)
		END CATCH 
	END 
GO
/****** Object:  StoredProcedure [dbo].[spDefinirPrecioBloqueParaProduccion]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAccesoById]    Script Date: 27/7/2020 5:59:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spGetAccesoById]
	@Id int
AS
	Select * 
	From Accesos
	Where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[spGetAsientosVaciosFila]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetBloqueByTeatro]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetBloquesByTeatroConPrecio]    Script Date: 27/7/2020 5:59:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetBloquesByTeatroConPrecio]
	@IdTeatro int,
	@IdPresentacion int
AS
	SELECT b.Id, b.NombreBloque
	From Bloques b
	Join Precios p On p.IdBloque = b.Id
	Join Presentaciones pre On pre.Id = @IdPresentacion
	WHERE b.IdTeatro = @IdTeatro AND p.IdProduccion = pre.IdProduccion
GO
/****** Object:  StoredProcedure [dbo].[spGetFilasByBloque]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetIdTeatroFromUsuario]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetInfoBloqueById]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetMatchingUser]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetPrecioByPresBloque]    Script Date: 27/7/2020 5:59:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spGetPrecioByPresBloque]
	@IdPresentacion int,
	@IdBloque int
AS
	Select p.Precio
	From Precios p
	Join Presentaciones pre On pre.Id = @IdPresentacion 
	Join Producciones pro On pro.Id = pre.IdProduccion
	WHERE p.IdBloque = @IdBloque And p.IdProduccion = pre.IdProduccion
GO
/****** Object:  StoredProcedure [dbo].[spGetPreciosByProduccion]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetPresentacionById]    Script Date: 27/7/2020 5:59:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spGetPresentacionById] 
	@IdPresentacion int
AS
	SELECT pre.Id, pre.Fecha, pre.Hora, pro.NombreObra, t.Nombre As NombreTeatro, t.Id AS IdTeatro
	FROM Presentaciones pre
	JOIN Producciones pro ON pro.Id = pre.IdProduccion
	JOIN Teatros t ON t.Id = pro.IdTeatro
	WHERE pre.Id = @IdPresentacion
GO
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesByFechaHora]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesByProduccion]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesRangoFechas]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetProduccionById]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetProduccionesByTeatro]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetProduccionesCartelera]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetProduccionesEstadoById]    Script Date: 27/7/2020 5:59:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spGetProduccionesEstadoById]
	@Id int
AS
	Select * 
	From ProduccionEstados
	Where Id = @Id
GO
/****** Object:  StoredProcedure [dbo].[spGetProduccionesEstados]    Script Date: 27/7/2020 5:59:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[spGetProduccionesEstados]
AS
	Select * 
	From ProduccionEstados

	
GO
/****** Object:  StoredProcedure [dbo].[spGetProduccionesInFechas]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetReporteDiario]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetTeatroById]    Script Date: 27/7/2020 5:59:25 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetTeatros]    Script Date: 27/7/2020 5:59:25 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetTeatros]
AS
	SELECT * 
	FROM Teatros
GO
USE [master]
GO
ALTER DATABASE [SistemaTeatros_BD1] SET  READ_WRITE 
GO
