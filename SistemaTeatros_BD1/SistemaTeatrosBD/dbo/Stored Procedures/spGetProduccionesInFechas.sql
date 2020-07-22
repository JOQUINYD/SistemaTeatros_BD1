CREATE PROCEDURE [dbo].[spGetProduccionesInFechas]
	@Fecha_Inicio DATE,
	@Fecha_Final DATE

	AS 
	SELECT DISTINCT po.Id, po.NombreObra, po.FechaInit, po.FechaFin, po.Tipo, pe.Estado, T.Nombre, po.Descripcion, po.IdTeatro, po.IdProduccionEstado
	FROM Producciones po
	JOIN ProduccionEstados pe ON pe.Id = po.IdProduccionEstado
	JOIN Teatros t ON t.Id = po.IdTeatro
	JOIN Presentaciones pr ON pr.IdProduccion = po.Id
	WHERE po.IdProduccionEstado != 0 AND (pr.Fecha BETWEEN @Fecha_Inicio and @Fecha_Final)