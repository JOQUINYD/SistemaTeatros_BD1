CREATE PROCEDURE [dbo].[spGetMatchingUser]
	@Usuario varchar(50)

	AS

	SELECT *
	FROM Usuarios u
	WHERE u.Usuario = @Usuario