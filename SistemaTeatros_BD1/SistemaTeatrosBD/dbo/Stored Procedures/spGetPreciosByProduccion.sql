Create Procedure spGetPreciosByProduccion
	@IdProduccion int
AS
	Select p.Precio, b.NombreBloque
	From Precios p
	Join Bloques b on b.Id = p.IdBloque
	Where p.IdProduccion = @IdProduccion