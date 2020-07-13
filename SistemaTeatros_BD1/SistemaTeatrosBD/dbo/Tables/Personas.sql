CREATE TABLE [dbo].[Personas]
(
    [Nombre] VARCHAR(50) NOT NULL, 
    [FechaNac] DATE NOT NULL, 
    [Cedula] BIGINT NOT NULL, 
    [Direccion] NVARCHAR(150) NOT NULL, 
    [TelefonoCelular] BIGINT NULL, 
    [TelefonoCasa] BIGINT NULL, 
    [TelefonoOtro] BIGINT NULL, 
    [Email] VARCHAR(150) NOT NULL, 
    [IdTeatro] INT NULL, 
    [Sexo] CHAR(1) NOT NULL, 
    CONSTRAINT [PK_Personas] PRIMARY KEY ([Cedula]), 
    CONSTRAINT [FK_Personas_Teatros] FOREIGN KEY ([IdTeatro]) REFERENCES [Teatros]([Id])
)
