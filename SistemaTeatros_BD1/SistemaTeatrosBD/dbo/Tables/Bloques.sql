﻿CREATE TABLE [dbo].[Bloques]
(
	[Id] INT NOT NULL, 
    [NombreBloque] VARCHAR(50) NOT NULL, 
    [IdTeatro] INT NOT NULL, 
    CONSTRAINT [PK_Bloques] PRIMARY KEY ([Id]), 
    CONSTRAINT [FK_Bloques_Teatros] FOREIGN KEY ([IdTeatro]) REFERENCES [Teatros]([Id])
)
