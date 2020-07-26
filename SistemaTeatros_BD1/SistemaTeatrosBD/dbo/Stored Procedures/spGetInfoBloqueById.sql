CREATE PROCEDURE [dbo].[spGetInfoBloqueById]
	@IdBloque int
AS
	SELECT b.Id, b.IdTeatro, b.NombreBloque, t.Nombre AS NombreTeatro
	FROM Bloques b
	JOIN Teatros t ON t.Id = b.IdTeatro
	WHERE b.Id = @IdBloque