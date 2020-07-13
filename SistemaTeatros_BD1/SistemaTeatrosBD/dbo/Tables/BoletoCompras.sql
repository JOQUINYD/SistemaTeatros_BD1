CREATE TABLE [dbo].[BoletoCompras]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [NombreCliente] VARCHAR(50) NOT NULL, 
    [IdPresentacion] INT NOT NULL, 
    CONSTRAINT [FK_BoletoCompras_ToPresentaciones] FOREIGN KEY ([IdPresentacion]) REFERENCES [Presentaciones]([Id])
)
