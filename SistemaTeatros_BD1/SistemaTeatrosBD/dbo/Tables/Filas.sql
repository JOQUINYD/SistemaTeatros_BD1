CREATE TABLE [dbo].[Filas]
(
    [Letra] CHAR(1) NOT NULL, 
    [NumAsientos] INT NOT NULL, 
    [IdBloque] INT NOT NULL, 
    CONSTRAINT [PK_Filas] PRIMARY KEY (Letra, IdBloque), 
    CONSTRAINT [FK_Filas_Bloques] FOREIGN KEY ([IdBloque]) REFERENCES [Bloques]([Id]) 
)
