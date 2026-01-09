-- XML Modification Experiment
-- Experimental script for XML attribute manipulation using cursors
-- Platform: SQL Server
-- Status: Experimental - may not work as intended (see filename)


DECLARE @data TABLE(
	[Path] NVARCHAR(100)
	,[Attribute] NVARCHAR(100)
	,[Value] NVARCHAR(100)
);
INSERT INTO @data
	SELECT '/configuration/options/startup','showSplash','1'
	UNION ALL
	SELECT '/configuration/settings','idletime','1400'
	UNION ALL
	SELECT '/configuration/options/defaults','maxWindows','5';

--------------------------

DECLARE @xml XML = N'
<configuration>
	<options>
		<startup />
		<defaults />
	</options>
	<settings />
</configuration>
', @modifyCmd NVARCHAR(MAX);

DECLARE @xpath NVARCHAR(100), @value NVARCHAR(100), @attrib NVARCHAR(100), @path NVARCHAR(100);

--SELECT
--	[Path] + '/@' + [Attribute] AS [XPath]
--	,[Value]
--FROM @data;

DECLARE my_cursor CURSOR
	FOR SELECT [Path] + '/@' + [Attribute] AS [XPath], [Value], [Attribute], [Path]
		FROM @data;

OPEN my_cursor;

FETCH NEXT FROM my_cursor INTO @xpath, @value, @attrib,@path;

WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '-------';
	PRINT 'XPath:' + @xpath;
	PRINT 'Path:' + @path;
	PRINT 'Value:' + @value;
	PRINT 'Attribute:' + @attrib;
	PRINT 'Xml:';
	PRINT CAST(@xml AS NVARCHAR(MAX));

	--SET @modifyCmd = '
	--	replace value of (' + @xpath + ')[1]
	--	with "' + @value + '"
	--';
	--PRINT 'modifyCmd:';
	--PRINT CAST(@modifyCmd AS NVARCHAR(MAX));

	SET @xml.modify('
		insert attribute xml {sql:variable("@value")}
		as first into {sql:variable("@value")}[1]
	');

	FETCH NEXT FROM my_cursor INTO @xpath, @value, @attrib,@path;
END

CLOSE my_cursor;
DEALLOCATE my_cursor;
