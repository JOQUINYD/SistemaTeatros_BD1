CREATE PROCEDURE [dbo].[spGetAsientosVaciosFila]
	@IdPresentacion int,
	@IdBloque int,
	@Letra char(1)
AS
	DECLARE @NumAsientos int
	SET @NumAsientos = (SELECT f.NumAsientos FROM Filas f WHERE f.IdBloque = @IdBloque AND f.Letra = @Letra)

	SELECT ones.n + 10*tens.n + 100*hundreds.n + 1000*thousands.n AS numAsi
	FROM (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) ones(n),
		 (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) tens(n),
		 (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) hundreds(n),
		 (VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) thousands(n)
	WHERE ones.n + 10*tens.n + 100*hundreds.n + 1000*thousands.n BETWEEN 1 AND @NumAsientos AND ones.n + 10*tens.n + 100*hundreds.n + 1000*thousands.n NOT IN (SELECT NumAsiento FROM Boletos WHERE IdPresentacion = @IdPresentacion AND IdBloqueFila = @IdBloque AND LetraFila = @Letra)																							
	ORDER BY 1