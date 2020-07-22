CREATE PROCEDURE spGetPresentacionesRangoFechas
	@Fecha_Inicio DATE,
	@Fecha_Final DATE

	AS 

	SELECT * 
	FROM Presentaciones p
	WHERE p.Fecha BETWEEN @Fecha_Inicio and @Fecha_Final