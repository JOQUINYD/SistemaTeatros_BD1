CREATE Procedure [dbo].[spGetPresentacionById] 
	@IdPresentacion int
AS
	SELECT pre.Id, pre.Fecha, pre.Hora, pro.NombreObra, t.Nombre As NombreTeatro, t.Id AS IdTeatro
	FROM Presentaciones pre
	JOIN Producciones pro ON pro.Id = pre.IdProduccion
	JOIN Teatros t ON t.Id = pro.IdTeatro
	WHERE pre.Id = @IdPresentacion