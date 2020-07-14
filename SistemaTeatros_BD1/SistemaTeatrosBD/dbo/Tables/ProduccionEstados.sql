CREATE TABLE [dbo].[ProduccionEstados]
(
	[Id] INT NOT NULL IDENTITY(0, 1), 
    [Estado] VARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_ProduccionEstados] PRIMARY KEY ([Id]) 
)
