CREATE PROCEDURE [dbo].[spDefinirPrecioBloqueParaProduccion]
	@Id_Bloque int ,
	@Id_Produccion int,
	@Precio decimal(19,4)

	AS 

	INSERT INTO Precios (Precio,IdProduccion,IdBloque)
	VALUES (@Precio,@Id_Produccion,@Id_Bloque)