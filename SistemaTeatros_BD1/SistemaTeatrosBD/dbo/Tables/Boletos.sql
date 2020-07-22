CREATE TABLE [dbo].[Boletos]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [IdPresentacion] INT NOT NULL, 
    [LetraFila] CHAR(1) NOT NULL, 
    [IdBloqueFila] INT NOT NULL, 
    [Precio]  DECIMAL(19,4) NOT NULL,
    [IdFactura] INT NOT NULL, 
    [NumAsiento] INT NOT NULL, 
    CONSTRAINT [FK_Boleto_ToPresentaciones] FOREIGN KEY ([IdPresentacion]) REFERENCES [Presentaciones]([Id]),
    CONSTRAINT [FK_Boleto_ToFilas] FOREIGN KEY ([LetraFila],[IdBloqueFila]) REFERENCES [Filas]([Letra],[IdBloque]) ,
    CONSTRAINT [FK_Boleto_ToFactura] FOREIGN KEY ([IdFactura]) REFERENCES [Facturas](Id), 
    CONSTRAINT [AK_Boletos] UNIQUE (LetraFila,IdBloqueFila,IdPresentacion,NumAsiento) 
)
