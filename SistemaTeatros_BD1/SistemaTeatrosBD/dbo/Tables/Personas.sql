CREATE TABLE [dbo].[Personas]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [Nombre] VARCHAR(50) NOT NULL, 
    [FechaNac] DATE NOT NULL, 
    [Cedula] BIGINT NOT NULL, 
    [Direccion ] NVARCHAR(150) NOT NULL, 
    [TelefonoCelular] BIGINT NULL, 
    [TelefonoCasa] BIGINT NULL, 
    [TelefonoOtro] BIGINT NULL, 
    [Email] VARCHAR(150) NOT NULL
)
