CREATE PROCEDURE [dbo].[spGetProduccionesByTeatro]
	@IdTeatro int
AS
	SELECT po.Id, po.NombreObra, po.FechaInit, po.FechaFin, po.Tipo, pe.Estado, T.Nombre, po.Descripcion
	FROM Producciones po
	JOIN ProduccionEstados pe ON pe.Id = po.IdProduccionEstado
	JOIN Teatros t ON t.Id = po.IdTeatro
	WHERE po.IdTeatro = @IdTeatro