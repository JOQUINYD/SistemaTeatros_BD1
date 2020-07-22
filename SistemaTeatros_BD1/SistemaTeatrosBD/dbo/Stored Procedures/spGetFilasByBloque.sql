CREATE PROCEDURE spGetFilasByBloque
	@IdBloque int
AS
	SELECT *
	FROM Filas
	WHERE IdBloque = @IdBloque
	ORDER BY Letra ASC