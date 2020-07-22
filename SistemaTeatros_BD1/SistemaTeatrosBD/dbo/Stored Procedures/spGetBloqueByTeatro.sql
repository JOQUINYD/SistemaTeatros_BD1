CREATE PROCEDURE spGetBloqueByTeatro
	@IdTeatro int
AS
	SELECT *
	FROM Bloques
	WHERE IdTeatro = @IdTeatro