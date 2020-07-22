CREATE PROCEDURE spAddProduccion
	@Nombre varchar(50),
	@Descripcion varchar(300),
	@Tipo varchar(50),
	@Fecha_Init date,
	@Feccha_Fin date,
	@ID_Teatro int 


	AS
	INSERT INTO Producciones (NombreObra,Descripcion,FechaInit,FechaFin,IdTeatro,Tipo)
	VALUES (@Nombre,@Descripcion,@Fecha_Init,@Feccha_Fin,@ID_Teatro,@Tipo)