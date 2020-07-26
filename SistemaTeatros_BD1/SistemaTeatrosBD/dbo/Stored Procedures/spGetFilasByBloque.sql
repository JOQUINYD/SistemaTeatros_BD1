CREATE PROCEDURE [dbo].[spGetFilasByBloque]
	@IdBloque int
AS
	SELECT *
	FROM Filas
	WHERE IdBloque = @IdBloque
	ORDER BY Letra ASC