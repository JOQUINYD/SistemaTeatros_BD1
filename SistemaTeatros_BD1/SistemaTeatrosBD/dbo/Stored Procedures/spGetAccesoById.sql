Create Procedure spGetAccesoById
	@Id int
AS
	Select * 
	From Accesos
	Where Id = @Id