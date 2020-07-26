CREATE TABLE [dbo].[Precios]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [Precio] DECIMAL(19, 4) NOT NULL, 
    [IdProduccion] INT NOT NULL, 
    [IdBloque] INT NOT NULL, 
    CONSTRAINT [FK_Precios_Producciones] FOREIGN KEY ([IdProduccion]) REFERENCES [Producciones]([Id]), 
    CONSTRAINT [FK_Precios_Bloques] FOREIGN KEY ([IdBloque]) REFERENCES [Bloques]([Id]), 
    CONSTRAINT [AK_Precios] UNIQUE (IdProduccion, IdBloque)
)
