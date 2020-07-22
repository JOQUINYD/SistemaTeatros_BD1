CREATE PROCEDURE spAddPersonaAndUsuario
	@Nombre varchar(50),
	@FechaNac date,
	@Cedula bigint,
	@Direccion nvarchar(150),
	@TelefonoCelular bigint,
	@TelefonoCasa bigint,
	@TelefonoOtro bigint,
	@Email varchar(150),
	@IdTeatro int,
	@Sexo char,
	@Usuario varchar(50),
	@Password varchar(150),
	@IdAcceso int
AS
	INSERT INTO Personas (Nombre, FechaNac, Cedula, Direccion, TelefonoCelular, TelefonoCasa, TelefonoOtro, Email, IdTeatro, Sexo)
	VALUES (@Nombre, @FechaNac, @Cedula, @Direccion, @TelefonoCelular, @TelefonoCasa, @TelefonoOtro, @Email, @IdTeatro, @Sexo)

	INSERT INTO Usuarios (Usuario, Password, IdAcceso, CedulaPersona)
	VALUES (@Usuario, @Password, @IdAcceso, @Cedula)