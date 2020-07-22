CREATE PROCEDURE spGetPresentacionesByProduccion
	@IdProduccion int
AS
	SELECT p.Fecha, p.Hora
	FROM Presentaciones p
	WHERE p.IdProduccion = @IdProduccion
	ORDER BY p.Fecha ASC, p.Hora ASC