/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  Table [dbo].[__RefactorLog]    Script Date: 23/7/2020 1:50:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__RefactorLog](
	[OperationKey] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OperationKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accesos]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bloques]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Boletos]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Boletos] UNIQUE NONCLUSTERED 
(
	[LetraFila] ASC,
	[IdBloqueFila] ASC,
	[IdPresentacion] ASC,
	[NumAsiento] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturas]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Filas]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Precios]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Presentaciones]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producciones]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProduccionEstados]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teatros]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddBloque]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddFila]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddPersonaAndUsuario]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddPrecio]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddPresentacion]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddProduccion]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spAddTeatro]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spCambiarEstadoProduccion]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spDefinirPrecioBloqueParaProduccion]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetAsientosVaciosFila]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetBloqueByTeatro]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetFilasByBloque]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetIdTeatroFromUsuario]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetInfoBloqueById]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetMatchingUser]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetPreciosByProduccion]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesByFechaHora]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesByProduccion]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetPresentacionesRangoFechas]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetProduccionById]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetProduccionesByTeatro]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetProduccionesCartelera]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetProduccionesInFechas]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetTeatroById]    Script Date: 23/7/2020 1:50:40 p. m. ******/
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
/****** Object:  StoredProcedure [dbo].[spGetTeatros]    Script Date: 23/7/2020 1:50:40 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetTeatros]
AS
	SELECT * 
	FROM Teatros
GO
