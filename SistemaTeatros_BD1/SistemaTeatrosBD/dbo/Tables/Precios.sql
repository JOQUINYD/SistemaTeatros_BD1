CREATE TABLE [dbo].[Precios]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [Precio] DECIMAL(19, 4) NULL, 
    [IdProducciones] INT NULL, 
    [IdBloques] INT NULL, 
    CONSTRAINT [FK_Precios_Producciones] FOREIGN KEY ([IdProducciones]) REFERENCES [Producciones]([id]), 
    CONSTRAINT [FK_Precios_Bloques] FOREIGN KEY ([IdBloques]) REFERENCES [Bloques]([id])
)
