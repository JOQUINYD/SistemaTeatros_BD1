CREATE Procedure [dbo].[spGetProduccionById]
	@IdProduccion int
AS
	SELECT po.Id, po.NombreObra, po.FechaInit, po.FechaFin, po.Tipo, pe.Estado, T.Nombre, po.Descripcion, po.IdProduccionEstado, po.IdTeatro
	FROM Producciones po
	JOIN ProduccionEstados pe ON pe.Id = po.IdProduccionEstado
	JOIN Teatros t ON t.Id = po.IdTeatro
	WHERE po.Id = @IdProduccion