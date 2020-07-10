CREATE TABLE [dbo].[Producciones]
(
	[Id] INT NOT NULL  IDENTITY (0, 1), 
    [NombreObra] VARCHAR(50) NOT NULL, 
    [FechaInit] DATE NOT NULL, 
    [FechaFin] DATE NOT NULL, 
    [Tipo] VARCHAR(50) NOT NULL, 
    [IdTeatro] INT NOT NULL, 
    [Descripcion] VARCHAR(300) NULL, 
    [IdTipo ] INT NULL, 
    CONSTRAINT [PK_Producciones] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Producciones_Teatros] FOREIGN KEY ([IdTeatro]) REFERENCES [Teatros]([Id]), 
    CONSTRAINT [FK_Producciones_ToProduccionesTipos] FOREIGN KEY ([IdTipo ]) REFERENCES [ProduccionesTipos]([id])
    
)
