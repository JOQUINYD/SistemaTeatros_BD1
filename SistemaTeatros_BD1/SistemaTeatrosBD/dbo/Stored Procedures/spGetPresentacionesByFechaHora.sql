Create Procedure spGetPresentacionesByFechaHora
	@Fecha date,
	@Hora time(7),
	@IdTeatro int
AS
	Select p.Id
	From Presentaciones p
	Join Producciones pr ON pr.Id = p.IdProduccion AND pr.IdTeatro = @IdTeatro
	Where p.Fecha = @Fecha AND p.Hora = @Hora