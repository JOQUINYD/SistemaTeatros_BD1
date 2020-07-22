CREATE PROCEDURE spGetIdTeatroFromUsuario
	@Usuario varchar(50)
AS
	SELECT p.IdTeatro
	From Usuarios u
	JOIN Personas p ON p.Cedula = u.CedulaPersona
	WHERE u.Usuario = @Usuario