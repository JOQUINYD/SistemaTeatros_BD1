CREATE PROCEDURE [dbo].[spAddTeatro]
	@Nombre varchar(50),
	@Boleteria int,
	@Email nvarchar(320),
	@SitioWeb nvarchar(500),
	@Telefono int
AS
	INSERT INTO Teatros (Nombre, Boleteria, Email, SitioWeb, Telefono)
	VALUES (@Nombre, @Boleteria, @Email, @SitioWeb, @Telefono)