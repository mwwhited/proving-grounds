DECLARE @xslt XML = N'<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <tables>
      <xsl:apply-templates select="//master.sys.tables" />
    </tables>
  </xsl:template>
  
  <xsl:template match="master.sys.tables">
    <table name="{@name}" id="{@object_id}" />  
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>';
DECLARE @xml XML = (SELECT *
FROM [master].[sys].[tables]
FOR XML AUTO, ROOT('tables'));

SELECT @xml, @xslt;


DECLARE @result XML = [dbo].[ApplyXsltTransform]( @xml, @xslt);

SELECT @result;
