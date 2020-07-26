Create Procedure [dbo].[spAddFila]
	@IdBloque int,
	@Letra char(1),
	@NumAsientos int
AS
	INSERT INTO Filas (IdBloque, Letra, NumAsientos)
	VALUES (@IdBloque, @Letra, @NumAsientos)