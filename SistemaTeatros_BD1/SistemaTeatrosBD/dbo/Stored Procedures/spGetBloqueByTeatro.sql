CREATE PROCEDURE [dbo].[spGetBloqueByTeatro]
	@IdTeatro int
AS
	SELECT *
	FROM Bloques
	WHERE IdTeatro = @IdTeatro