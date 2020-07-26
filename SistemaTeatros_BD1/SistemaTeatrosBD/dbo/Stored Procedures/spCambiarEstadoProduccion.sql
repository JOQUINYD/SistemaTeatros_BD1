CREATE PROCEDURE [dbo].[spCambiarEstadoProduccion]
	@Id_Estado int ,
	@Id_Produccion int 

	AS 
	UPDATE Producciones
	SET IdProduccionEstado = @Id_Estado
	WHERE  Id = @Id_Produccion