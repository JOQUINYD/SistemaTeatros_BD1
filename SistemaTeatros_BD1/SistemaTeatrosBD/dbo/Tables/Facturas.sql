CREATE TABLE [dbo].[Facturas]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY (0, 1), 
    [NombreCliente] VARCHAR(150) NOT NULL, 
    [Email] NVARCHAR(320) NOT NULL, 
    [Fecha] DATE NOT NULL, 
    [Telefono] INT NOT NULL, 
    [Hora] TIME NOT NULL, 
    [NumeroAprobacion] INT NOT NULL, 

)
