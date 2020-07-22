Create Procedure spAddPrecio
	@IdProduccion int,
	@IdBloque int,
	@Precio decimal(19,4)
AS
	Insert Into Precios (IdProduccion, IdBloque, Precio)
	Values (@IdProduccion, @IdBloque, @Precio)