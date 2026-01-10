<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                
                xmlns:p="mwtm://ServiceBroker/Project/v1"
                
                exclude-result-prefixes="msxsl"
                >
  <xsl:output method="text" indent="yes"/>

  <xsl:template match="/p:Project">
    <xsl:text disable-output-escaping="yes"><![CDATA[/* Service Broker Creation Script for "]]></xsl:text>
    <xsl:value-of select="./@Name"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[" */
]]></xsl:text>

    <xsl:text disable-output-escaping="yes"><![CDATA[
/* XML Schema Collections */]]></xsl:text>
    <xsl:apply-templates select="./p:Xml-Schema-Collection" />

    <xsl:text disable-output-escaping="yes"><![CDATA[
/* Message Types */]]></xsl:text>
    <xsl:apply-templates select="./p:Message-Type" />

    <xsl:text disable-output-escaping="yes"><![CDATA[
/* Contracts */]]></xsl:text>
    <xsl:apply-templates select="./p:Contract" />

    <xsl:text disable-output-escaping="yes"><![CDATA[
/* Queues */]]></xsl:text>
    <xsl:apply-templates select="./p:Queue" />

    <xsl:text disable-output-escaping="yes"><![CDATA[
/* Services */]]></xsl:text>
    <xsl:apply-templates select="./p:Service" />

  </xsl:template>

  <!-- XML Schema Collections - Start -->
  <xsl:template match="p:Xml-Schema-Collection">
    <!--<Xml-Schema-Collection Schema="dbo" Name="XmlSchemaCollection1">
      <XmlSchema>
        <![CDATA[<xs:schema id='XMLSchema1'
    targetNamespace='http://tempuri.org/XMLSchema1.xsd'
    elementFormDefault='qualified'
    xmlns='http://tempuri.org/XMLSchema1.xsd'
    xmlns:xs='http://www.w3.org/2001/XMLSchema'
>
</xs:schema>]]>
      </XmlSchema>
    </Xml-Schema-Collection>-->
    <xsl:text disable-output-escaping="yes"><![CDATA[
CREATE XML SCHEMA COLLECTION []]></xsl:text>
    <xsl:value-of select="@Schema" />
    <xsl:text><![CDATA[].[]]></xsl:text>
    <xsl:value-of select="@Name" />
    <xsl:text><![CDATA[] AS N']]></xsl:text>
    <xsl:apply-templates select="./p:XmlSchema" />
    <xsl:text><![CDATA[';
]]></xsl:text>
  </xsl:template>
  <xsl:template match="p:XmlSchema">
    <xsl:call-template name="escape-single-quotes">
      <xsl:with-param name="text" select="text()" />
    </xsl:call-template>
  </xsl:template>
  <!-- XML Schema Collections - End -->

  <!-- Message Types - Start -->
  <xsl:template match="p:Message-Type">
    <!--
    <Message-Type Name="MessageType1" Validation="ValidXmlWithSchemaCollection">
      <Xml-Schema.Ref Schema="dbo" Name="XmlSchemaCollection1" />
    </Message-Type>
    -->
    <xsl:text disable-output-escaping="yes"><![CDATA[
CREATE MESSAGE TYPE []]></xsl:text>
    <xsl:value-of select="@Name" />
    <xsl:text disable-output-escaping="yes"><![CDATA[]
  /*[ AUTHORIZATION owner_name ]*/
  VALIDATION = ]]></xsl:text>
    <xsl:choose>
      <xsl:when test="@Validation = 'None'">NONE</xsl:when>
      <xsl:when test="@Validation = 'Empty'">EMPTY</xsl:when>
      <xsl:when test="@Validation = 'WellFormedXml'">WELL_FORMED_XML</xsl:when>
      <xsl:when test="@Validation = 'ValidXmlWithSchemaCollection'">
        <xsl:text disable-output-escaping="yes"><![CDATA[VALID_XML WITH SCHEMA COLLECTION []]></xsl:text>
        <xsl:value-of select="./p:Xml-Schema.Ref[1]/@Schema"/>
        <xsl:text disable-output-escaping="yes"><![CDATA[].[]]></xsl:text>
        <xsl:value-of select="./p:Xml-Schema.Ref[1]/@Name"/>
        <xsl:text disable-output-escaping="yes"><![CDATA[]]]></xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:text><![CDATA[;
]]></xsl:text>
  </xsl:template>
  <!-- Message Types - End -->

  <!-- Contracts - Start -->
  <xsl:template match="p:Contract">
    <!--<Contract Name="Contract1">
      <Message-Type.Ref Name="MessageType1" Sent-By="Any" />
    </Contract>-->

    <xsl:text disable-output-escaping="yes"><![CDATA[
CREATE CONTRACT []]></xsl:text>
    <xsl:value-of select="@Name" />
    <xsl:text disable-output-escaping="yes"><![CDATA[]
  /*[ AUTHORIZATION owner_name ]*/
  (]]></xsl:text>
    <xsl:choose>
      <xsl:when  test="./p:Message-Type.Ref">
        <xsl:apply-templates select="./p:Message-Type.Ref" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:text disable-output-escaping="yes"><![CDATA[
    [DEFAULT] SENT BY ANY]]></xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes"><![CDATA[
  );
]]></xsl:text>
  </xsl:template>
  <xsl:template match="p:Message-Type.Ref">
    <xsl:text disable-output-escaping="yes"><![CDATA[
    []]></xsl:text>
    <xsl:value-of select="@Name"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[] SEND BY ]]></xsl:text>
    <xsl:choose>
      <xsl:when test="@Sent-By = 'Any'">ANY</xsl:when>
      <xsl:when test="@Sent-By = 'Initiator'">INITIATOR</xsl:when>
      <xsl:when test="@Sent-By = 'Target'">TARGET</xsl:when>
    </xsl:choose>
    <xsl:if test="not(position() = last())">
      <xsl:text>,</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- Contracts - End -->

  <!-- Queues - Start -->
  <xsl:template match="p:Queue">
    <!--<Queue Schema="dbo" Name="Queue1" Status="true" Retention="false" Poison-Message-Handling="false">
    <Activator Schema="dbo" Name="sp_Handler1" Status="true" Max-Queue-Readers="10" />
  </Queue>-->
    <xsl:text disable-output-escaping="yes"><![CDATA[
CREATE QUEUE []]></xsl:text>
    <xsl:value-of select="@Schema" />
    <xsl:text><![CDATA[].[]]></xsl:text>
    <xsl:value-of select="@Name" />
    <xsl:text><![CDATA[]
  WITH
    STATUS = ]]></xsl:text>
    <xsl:choose>
      <xsl:when test="@Status = 'true'">ON</xsl:when>
      <xsl:otherwise>OFF</xsl:otherwise>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes"><![CDATA[,
    RETENTION = ]]></xsl:text>
    <xsl:choose>
      <xsl:when test="@Retention = 'true'">ON</xsl:when>
      <xsl:otherwise>OFF</xsl:otherwise>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes"><![CDATA[,
    POISON_MESSAGE_HANDLING (
      STATUS = ]]></xsl:text>
    <xsl:choose>
      <xsl:when test="@Poison-Message-Handling = 'true'">ON</xsl:when>
      <xsl:otherwise>OFF</xsl:otherwise>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes"><![CDATA[
    )]]></xsl:text>
    <xsl:apply-templates select="./p:Activator" />
    <xsl:text disable-output-escaping="yes"><![CDATA[
    /* [ ON { filegroup | [ DEFAULT ] } ] */
  ;
]]></xsl:text>

  </xsl:template>
  <xsl:template match="p:Activator">
    <xsl:text disable-output-escaping="yes"><![CDATA[,
    ACTIVATION (
      STATUS = ]]></xsl:text>
    <xsl:choose>
      <xsl:when test="./p:Activator/@Status = 'true'">ON</xsl:when>
      <xsl:otherwise>OFF</xsl:otherwise>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes"><![CDATA[,
      PROCEDURE_NAME = []]></xsl:text>
    <xsl:value-of select="@Schema" />
    <xsl:text><![CDATA[].[]]></xsl:text>
    <xsl:value-of select="@Name" />
    <xsl:text><![CDATA[],
      MAX_QUEUE_READERS = ]]></xsl:text>
    <xsl:value-of select="@Max-Queue-Readers" />
    <xsl:text><![CDATA[,
      EXECUTE AS SELF /*{ SELF | 'user_name' | OWNER }*/
    )]]></xsl:text>
  </xsl:template>
  
  <!-- Queues - End -->

  <!-- Services - Start -->
  <xsl:template match="p:Service">
    <!--<Service Name="Service1">
    <Queue.Ref Schema="dbo" Name="Queue1" />
    <Contract.Ref Name="Contract1" />
  </Service>-->
    <xsl:text disable-output-escaping="yes"><![CDATA[
CREATE SERVICE []]></xsl:text>
    <xsl:value-of select="@Name" />
    <xsl:text><![CDATA[]
  ON QUEUE []]></xsl:text>
    <xsl:value-of select="./p:Queue.Ref[1]/@Schema" />
    <xsl:text><![CDATA[].[]]></xsl:text>
    <xsl:value-of select="./p:Queue.Ref[1]/@Name" />
    <xsl:text><![CDATA[]
  (]]></xsl:text>
    <xsl:choose>
      <xsl:when test="./p:Contract.Ref">
        <xsl:apply-templates select="./p:Contract.Ref" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:text disable-output-escaping="yes"><![CDATA[
    [DEFAULT]]]></xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes"><![CDATA[
  );
]]></xsl:text>
  </xsl:template>
  <xsl:template match="p:Contract.Ref">
    <xsl:text disable-output-escaping="yes"><![CDATA[
    []]></xsl:text>
    <xsl:value-of select="@Name" />
    <xsl:text><![CDATA[]]]></xsl:text>
    <xsl:if test="not(position() = last())">
      <xsl:text>,</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- Services - End -->

  <!--
  <xsl:template match="@* | node()">
      <xsl:copy>
          <xsl:apply-templates select="@* | node()"/>
      </xsl:copy>
  </xsl:template>
  -->

  <!-- Functions - Start -->
  <xsl:template name="escape-single-quotes">
    <xsl:param name="text" />
    <xsl:call-template name="string-replace-all">
      <xsl:with-param name="text" select="$text" />
      <xsl:with-param name="replace">'</xsl:with-param>
      <xsl:with-param name="by">''</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="string-replace-all">
    <!-- http://stackoverflow.com/questions/3067113/xslt-string-replace/3067130#3067130 -->
    <xsl:param name="text" />
    <xsl:param name="replace" />
    <xsl:param name="by" />
    <xsl:choose>
      <xsl:when test="contains($text, $replace)">
        <xsl:value-of select="substring-before($text,$replace)" />
        <xsl:value-of select="$by" />
        <xsl:call-template name="string-replace-all">
          <xsl:with-param name="text"
          select="substring-after($text,$replace)" />
          <xsl:with-param name="replace" select="$replace" />
          <xsl:with-param name="by" select="$by" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- Functions - End -->
</xsl:stylesheet>
