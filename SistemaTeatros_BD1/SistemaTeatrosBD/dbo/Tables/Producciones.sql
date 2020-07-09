CREATE TABLE [dbo].[Producciones]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [NombreObra] VARCHAR(50) NOT NULL, 
    [FechaInit] DATE NOT NULL, 
    [FechaFin] DATE NOT NULL, 
    [Tipo] VARCHAR(50) NOT NULL, 
    [IdTeatro] INT NOT NULL, 
    CONSTRAINT [FK_Producciones_Teatros] FOREIGN KEY ([IdTeatro]) REFERENCES [Teatros]([Id])
)
