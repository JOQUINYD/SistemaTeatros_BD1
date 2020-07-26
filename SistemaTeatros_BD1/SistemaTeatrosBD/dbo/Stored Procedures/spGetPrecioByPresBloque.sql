Create Procedure spGetPrecioByPresBloque
	@IdPresentacion int,
	@IdBloque int
AS
	Select p.Precio
	From Precios p
	Join Presentaciones pre On pre.Id = @IdPresentacion 
	Join Producciones pro On pro.Id = pre.IdProduccion
	WHERE p.IdBloque = @IdBloque And p.IdProduccion = pre.IdProduccion