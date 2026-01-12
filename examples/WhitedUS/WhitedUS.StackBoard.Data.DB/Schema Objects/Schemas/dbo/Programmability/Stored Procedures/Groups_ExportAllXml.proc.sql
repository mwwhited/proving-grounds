-- =============================================
-- Author:		Matthew Whited
-- Create date: 10/23/2011
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Groups_ExportAllXml
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		Name "@name"
		,[Description] "@description"
		,[HIdString] "@hid"
	FROM [Groups]
	FOR XMl PATH('group'), ROOT('groups')
END