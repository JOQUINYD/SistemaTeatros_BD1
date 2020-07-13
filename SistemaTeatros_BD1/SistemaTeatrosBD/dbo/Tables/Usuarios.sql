CREATE TABLE [dbo].[Usuarios]
(
    [Usuario] VARCHAR(50) NOT NULL, 
    [Password] VARCHAR(150) NOT NULL, 
    [IdAcceso] INT NOT NULL, 
    [CedulaPersona] BIGINT NOT NULL, 
    CONSTRAINT [FK_Usuarios_ToAccesos] FOREIGN KEY ([IdAcceso]) REFERENCES [Accesos]([Id]), 
    CONSTRAINT [PK_Usuarios] PRIMARY KEY ([Usuario]), 
    CONSTRAINT [FK_Usuarios_Personas] FOREIGN KEY ([CedulaPersona]) REFERENCES [Personas]([Cedula]), )
