CREATE Procedure [dbo].[spGetReporteDiario]
	
AS

	INSERT INTO Reportes
	SELECT  f.Fecha  , COUNT(*) , AVG(b.Precio) 
	FROM	Boletos b 
			JOIN	Facturas f ON (b.IdFactura = f.Id)
	WHERE f.Fecha = CONVERT(DATE,GETDATE())
	GROUP BY f.Fecha

	UNION 

	SELECT  GETDATE() , 0, 0
	WHERE NOT EXISTS (	SELECT  f.Fecha  , COUNT(*) , AVG(b.Precio) 
						FROM	Boletos b 
							JOIN	Facturas f ON (b.IdFactura = f.Id)
						WHERE f.Fecha = CONVERT(DATE,GETDATE())
						GROUP BY f.Fecha																			)