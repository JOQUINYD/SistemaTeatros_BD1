CREATE TABLE [dbo].[BoletoComprasFilas]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [LetraFila] CHAR(1) NULL, 
    [IdBoletoCompra] INT NULL, 
    [NumeroAsiento] INT NULL, 
    [IdBloqueFila] INT NULL, 
    CONSTRAINT [FK_BoletoComprasFilas_ToBoletoCompras] FOREIGN KEY ([LetraFila],[IdBloqueFila]) REFERENCES [Filas]([Letra],[IdBloque]), 
    CONSTRAINT [FK_BoletoComprasFilas_ToFilas] FOREIGN KEY ([IdBoletoCompra]) REFERENCES [BoletoCompras]([id])
)
