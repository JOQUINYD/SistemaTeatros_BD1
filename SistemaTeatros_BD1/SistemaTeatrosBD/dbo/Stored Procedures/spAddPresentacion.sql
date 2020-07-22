CREATE PROCEDURE spAddPresentacion
	@Fecha date,
	@Hora time(7),
	@IdProduccion int 

AS
	INSERT INTO Presentaciones (Fecha, Hora, IdProduccion)
	VALUES (@Fecha, @Hora, @IdProduccion)