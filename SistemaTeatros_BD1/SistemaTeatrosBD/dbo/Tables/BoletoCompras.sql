CREATE TABLE [dbo].[BoletoCompras]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [NombreCliente] VARCHAR(50) NULL, 
    [IdProduccion] INT NULL, 
    [IdPresentacion] INT NULL, 
    CONSTRAINT [FK_BoletoCompras_ToProducciones] FOREIGN KEY ([IdProduccion]) REFERENCES [Producciones]([Id]), 
    CONSTRAINT [FK_BoletoCompras_ToPresentaciones] FOREIGN KEY ([IdPresentacion]) REFERENCES [Presentaciones]([Id])
)
