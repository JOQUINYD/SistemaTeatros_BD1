CREATE TABLE [dbo].[Usuarios]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [Usuario] VARCHAR(150) NOT NULL, 
    [Password] VARCHAR(100) NOT NULL, 
 
    [IdAcceso] INT NULL, 
    CONSTRAINT [AK_Usuario] UNIQUE (Usuario), 
    CONSTRAINT [FK_Usuarios_ToAccesos] FOREIGN KEY ([IdAcceso]) REFERENCES [Accesos]([id])
)
