CREATE TABLE [dbo].[Teatros]
(
	[Id] INT NOT NULL IDENTITY(0, 1), 
    [Nombre] VARCHAR(50) NOT NULL, 
    [Boleteria] INT NOT NULL, 
    [Email] NVARCHAR(320) NOT NULL, 
    [SitioWeb] NVARCHAR(500) NOT NULL, 
    [Telefono] INT NOT NULL, 
    [CedulaPersona] BIGINT NULL, 
    CONSTRAINT [PK_Teatros] PRIMARY KEY ([Id]), 
    CONSTRAINT [FK_Teatros_Personas] FOREIGN KEY ([CedulaPersona]) REFERENCES [Personas]([Cedula])
)
