CREATE TABLE [dbo].[Presentaciones]
(
	[Id] INT NOT NULL IDENTITY, 
    [Fecha] DATE NOT NULL, 
    [Hora] TIME NOT NULL, 
    [IdProduccion] INT NOT NULL, 
    CONSTRAINT [PK_Presentaciones] PRIMARY KEY ([Id]), 
    CONSTRAINT [FK_Presentaciones_Producciones] FOREIGN KEY ([IdProduccion]) REFERENCES [Producciones]([Id])
)
