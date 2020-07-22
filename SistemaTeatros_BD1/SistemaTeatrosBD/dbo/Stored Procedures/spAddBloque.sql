Create Procedure spAddBloque
	@NombreBloque varchar(50),
	@IdTeatro int
AS
	INSERT INTO Bloques (NombreBloque, IdTeatro)
	VALUES (@NombreBloque, @IdTeatro)