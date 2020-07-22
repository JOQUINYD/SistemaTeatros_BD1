CREATE PROCEDURE spGetTeatroById
	@IdTeatro int
AS
	SELECT * 
	FROM Teatros
	WHERE Id = @IdTeatro