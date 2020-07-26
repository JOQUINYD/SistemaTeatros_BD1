
CREATE PROCEDURE [dbo].[spCompraBoletosYFactura]
	@Nombre_Cliente varchar(150),
	@Email nvarchar(320),
	@Fecha date,
	@Telefono int,
	@Hora time(7),
	@Numero_Aprobacion int,
	@Boletos as DatosBoletos READONLY

	AS
	BEGIN
		BEGIN TRY 
			BEGIN TRANSACTION
				
				INSERT INTO Facturas
				VALUES(@Nombre_Cliente,@Email,@Fecha,@Telefono,@Hora,@Numero_Aprobacion)
				DECLARE @Id_Factura INT = SCOPE_IDENTITY()

				INSERT INTO Boletos
				SELECT b.IdPresentacion,b.LetraFila,b.IdBloqueFila,prec.Precio ,@Id_Factura,b.NumAsiento
				FROM			@Boletos b 
						JOIN	Presentaciones pre ON (b.IdPresentacion = pre.Id)
						JOIN	Producciones prod ON (pre.IdProduccion = prod.Id)
						JOIN	Precios prec ON (prod.Id = prec.IdProduccion AND prec.IdBloque = b.IdBloqueFila)



			COMMIT TRANSACTION 
		END TRY
		BEGIN CATCH
			ROLLBACK TRANSACTION
			RAISERROR('Algún asiento ya fue comprado.',16,1)
		END CATCH 
	END