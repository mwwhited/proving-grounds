<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:s="http://schemas.outofbanddevelopment.com/FormEngine/2015/05/v1"
                xmlns:sd="http://schemas.outofbanddevelopment.com/FormEngine/Results/2015/05/v1"
                
                xmlns:url="clr-type:System.Web.Mvc.UrlHelper, System.Web.Mvc"
                
                exclude-result-prefixes="msxsl xsl s sd">
  <xsl:output method="html" indent="yes" />

  <xsl:param name="sd:form-data" />

  <xsl:template match="/s:form">
    <input id="__current_page" name="__current_page" type="hidden" value="{$sd:form-data/sd:data[@key='__current_page']/@value}" />
    <div id="form-body">
      <div id="form-header">
        <h1>
          <xsl:value-of select="./@title" />
        </h1>
        <xsl:if test="./@sub-title">
          <h2>
            <xsl:value-of select="./@sub-title" />
          </h2>
        </xsl:if>
      </div>

      <div id="page-set" class="pages">
        <xsl:attribute name="data-entry-point">
          <xsl:value-of select="(//s:page[@entry-point = 'true' or @entry-point = 1] | //s:page)[1]/@slug"/>
        </xsl:attribute>

        <xsl:apply-templates select="./s:page" />
      </div>

      <input name="form-title" value="{@title}" type="hidden" />
      <input name="form-subtitle" value="{@sub-title}" type="hidden" />

      <xsl:call-template name="javascript-local-rules">
        <xsl:with-param name="questions" select="//s:question" />
      </xsl:call-template>
    </div>

  </xsl:template>

  <xsl:template name="javascript-local-rules">
    <xsl:param name="questions" />
    <script type="text/javascript">
      <xsl:text><![CDATA[
        window.OobDev = window.OobDev || {};
        window.OobDev.Questionnaires = window.OobDev.Questionnaires || {};]]></xsl:text>

      <xsl:text><![CDATA[
        window.OobDev.Questionnaires.Rules = []]></xsl:text>

      <!--$questions/s:rules/s:set-if | $questions/s:rules/s:set-if-not-->
      <xsl:for-each select="$questions/s:rules/*[not(self::s:options)]">
        <xsl:text><![CDATA[
          { 'type':']]></xsl:text><xsl:value-of select="local-name()" /><xsl:text><![CDATA[', ]]></xsl:text>
        <xsl:text><![CDATA[ 'targetId':']]></xsl:text><xsl:value-of select="../../@group"/><xsl:text>_</xsl:text><xsl:value-of select="count(../../preceding-sibling::*)+1"/><xsl:text><![CDATA[', ]]></xsl:text>
        <xsl:text><![CDATA[ 'sourceQuestion':']]></xsl:text><xsl:value-of select="./@group" /><xsl:text><![CDATA[', ]]></xsl:text>
        <xsl:text><![CDATA[ 'sourceValue':']]></xsl:text><xsl:value-of select="./@equals" /><xsl:text><![CDATA[' } ]]></xsl:text>
        <xsl:if test="position() != last()">
          <xsl:text><![CDATA[,]]></xsl:text>
        </xsl:if>
      </xsl:for-each>

      <xsl:text><![CDATA[
        ];
]]></xsl:text>
    </script>
  </xsl:template>

  <xsl:template match="s:page">
    <div class="page" style="display:hidden;">
      <xsl:attribute name="id">
        <xsl:text>page-</xsl:text>
        <xsl:value-of select="@slug"/>
      </xsl:attribute>

      <h3 class="page-title">
        <xsl:value-of select="@title"/>
      </h3>
      <xsl:if test="@sub-title">
        <h4 class="page-sub-title">
          <xsl:value-of select="@sub-title"/>
        </h4>
      </xsl:if>

      <xsl:apply-templates select="." mode="page-navbar" />

      <ol>
        <xsl:attribute name="type">
          <xsl:call-template name="get-ol-type">
            <xsl:with-param name="node" select="." />
          </xsl:call-template>
        </xsl:attribute>

        <xsl:apply-templates select="./s:question" />
      </ol>

    </div>
  </xsl:template>

  <xsl:template match="s:page" mode="page-navbar">
    <div class="navbar navbar-default page-controls">
      <ul class="nav navbar-nav">

        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
            Pages <span class="caret"></span>
          </a>
          <ul class="dropdown-menu" role="menu">
            <xsl:for-each select="../s:page">
              <li>
                <a>
                  <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="@slug"/>
                  </xsl:attribute>
                  <xsl:value-of select="@title" />
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </li>

        <xsl:if test="./s:button">
          <xsl:for-each select="./s:button">
            <li>
              <xsl:choose>
                <xsl:when test="@action = 'goto'">
                  <xsl:apply-templates select="." mode="create-link">
                    <xsl:with-param name="href">
                      <xsl:text>#</xsl:text>
                      <xsl:value-of select="@target"/>
                    </xsl:with-param>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="@action = 'show'">
                  <xsl:apply-templates select="." mode="create-link">
                    <xsl:with-param name="onclick">
                      <xsl:text>showPage('</xsl:text>
                      <xsl:value-of select="@target"/>
                      <xsl:text>')</xsl:text>
                    </xsl:with-param>
                  </xsl:apply-templates>
                </xsl:when>
                <xsl:when test="@action = 'hide'">
                  <xsl:apply-templates select="." mode="create-link">
                    <xsl:with-param name="onclick">
                      <xsl:text>hidePage('</xsl:text>
                      <xsl:value-of select="@target"/>
                      <xsl:text>')</xsl:text>
                    </xsl:with-param>
                  </xsl:apply-templates>
                </xsl:when>

                <!--<xs:enumeration value="put" />-->
                <xsl:when test="@action = 'put'">
                  <xsl:apply-templates select="." mode="create-link">
                    <xsl:with-param name="onclick">
                      <xsl:text>putFormData(this, '</xsl:text>
                      <xsl:value-of select="@target"/>
                      <xsl:text>')</xsl:text>
                    </xsl:with-param>
                  </xsl:apply-templates>
                </xsl:when>
              </xsl:choose>
            </li>
          </xsl:for-each>

        </xsl:if>
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="s:button" mode="create-link">
    <xsl:param name="onclick"></xsl:param>
    <xsl:param name="href"></xsl:param>
    <a>
      <xsl:if test ="$href">
        <xsl:attribute name="href">
          <xsl:value-of select="$href"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:if test ="$onclick">
        <xsl:attribute name="onclick">
          <xsl:value-of select="$onclick"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:attribute name="class">
        <xsl:text>page-action-</xsl:text>
        <xsl:value-of select="@action"/>
        <xsl:if test="@class">
          <xsl:text> </xsl:text>
          <xsl:value-of select="@class"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:value-of select="@label" />
    </a>
  </xsl:template>

  <xsl:template match="s:question">
    <xsl:variable name="group-name">
      <xsl:value-of select="@group"/>
      <!--<xsl:call-template name="string-join">
        <xsl:with-param name="nodes" select="./ancestor-or-self::node()/@group" />
        <xsl:with-param name="delimiter">_</xsl:with-param>
      </xsl:call-template>-->
    </xsl:variable>
    <xsl:variable name="question-id">
      <xsl:value-of select="$group-name"/>
      <xsl:text>_</xsl:text>
      <xsl:value-of select="count(preceding-sibling::*)+1"/>
    </xsl:variable>

    <!-- Note: If Add other check if extra values exists... if so add extra "Other" fields-->
    <xsl:choose>
      <xsl:when test="@control = 'AddCheckOtherBox'">
        <xsl:apply-templates select="." mode="ensure-other-CheckRadioBox">
          <xsl:with-param name="control-type">checkbox</xsl:with-param>
          <xsl:with-param name="group-name" select="$group-name" />
          <xsl:with-param name="question-id" select="$question-id" />
        </xsl:apply-templates>
      </xsl:when>
      <xsl:when test="@control = 'AddRadioOtherBox'">
        <xsl:apply-templates select="." mode="ensure-other-CheckRadioBox">
          <xsl:with-param name="control-type">radio</xsl:with-param>
          <xsl:with-param name="group-name" select="$group-name" />
          <xsl:with-param name="question-id" select="$question-id" />
        </xsl:apply-templates>
      </xsl:when>
    </xsl:choose>

    <xsl:choose>
      <xsl:when test="@control = 'Hidden'">
        <xsl:apply-templates select="." mode="question-type-Hidden">
          <xsl:with-param name="group-name" select="$group-name" />
          <xsl:with-param name="question-id" select="$question-id" />
        </xsl:apply-templates>
      </xsl:when>

      <xsl:otherwise>

        <li id="li-{$question-id}"
            class="group-{@group} control-{@control} group-name-{$group-name}">
          <xsl:choose>
            <xsl:when test="@control = 'RadioBox'">
              <xsl:apply-templates select="." mode="question-type-CheckRadioBox">
                <xsl:with-param name="control-type">radio</xsl:with-param>
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'CheckBox'">
              <xsl:apply-templates select="." mode="question-type-CheckRadioBox">
                <xsl:with-param name="control-type">checkbox</xsl:with-param>
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'DropDownBox'">
              <xsl:apply-templates select="." mode="question-type-DropDownBox">
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'TextBox'">
              <xsl:apply-templates select="." mode="question-type-TextBox">
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'MultilineTextBox'">
              <xsl:apply-templates select="." mode="question-type-MultilineTextBox">
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'FieldSet'">
              <xsl:apply-templates select="." mode="question-type-FieldSet">
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'Label'">
              <xsl:apply-templates select="." mode="question-type-Label">
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>

            <xsl:when test="@control = 'RadioOtherBox'">
              <xsl:apply-templates select="." mode="question-type-CheckRadioOtherBox">
                <xsl:with-param name="control-type">radio</xsl:with-param>
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'CheckOtherBox'">
              <xsl:apply-templates select="." mode="question-type-CheckRadioOtherBox">
                <xsl:with-param name="control-type">checkbox</xsl:with-param>
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>

            <xsl:when test="@control = 'AddCheckOtherBox'">
              <xsl:apply-templates select="." mode="question-type-AddCheckRadioOtherBox">
                <xsl:with-param name="control-type">checkbox</xsl:with-param>
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'AddRadioOtherBox'">
              <xsl:apply-templates select="." mode="question-type-AddCheckRadioOtherBox">
                <xsl:with-param name="control-type">radio</xsl:with-param>
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>

            <xsl:when test="@control = 'PageSet'">
              <xsl:apply-templates select="." mode="question-type-PageSet">
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>
            <xsl:when test="@control = 'ReadOnly'">
              <xsl:apply-templates select="." mode="question-type-ReadOnly">
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:when>

            <xsl:otherwise>
              <xsl:apply-templates select="." mode="question-type-Label">
                <xsl:with-param name="group-name" select="$group-name" />
                <xsl:with-param name="question-id" select="$question-id" />
              </xsl:apply-templates>
            </xsl:otherwise>
          </xsl:choose>
        </li>

      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

  <xsl:template name="string-join">
    <xsl:param name="nodes" />
    <xsl:param name="delimiter">,</xsl:param>
    <xsl:for-each select="$nodes">
      <xsl:value-of select="."/>
      <xsl:if test="not(position() = last())">
        <xsl:value-of select="$delimiter"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <xsl:template name="string-split">
    <!--http://stackoverflow.com/questions/9075427/xslt-1-0-convert-delimited-string-to-node-set-->
    <xsl:param name="input"/>
    <xsl:param name="separator">,</xsl:param>
    <xsl:param name="node-name">node</xsl:param>

    <xsl:choose>
      <xsl:when test="string-length($input) = 0"/>
      <xsl:when test="contains($input, $separator)">
        <xsl:element name="{$node-name}">
          <xsl:value-of select="substring-before($input, $separator)"/>
        </xsl:element>
        <xsl:call-template name="string-split">
          <xsl:with-param name="input" select="substring-after($input, $separator)"/>
          <xsl:with-param name="separator" select="$separator"/>
          <xsl:with-param name="node-name" select="$node-name"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$node-name}">
          <xsl:value-of select="$input"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="get-group-name">
    <xsl:param name="node" />
    <xsl:call-template name="string-join">
      <xsl:with-param name="nodes" select="$node/ancestor-or-self::node()/@group" />
      <xsl:with-param name="delimiter">_</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="get-ol-type">
    <xsl:param name="node" />

    <xsl:variable name="types">
      <type value="i" />
      <type value="1" />
      <type value="A" />
      <type value="I" />
      <type value="a" />
    </xsl:variable>

    <xsl:value-of select="msxsl:node-set($types)/type[(count(msxsl:node-set($node)/ancestor-or-self::node())-1) mod count(msxsl:node-set($types)/type)]/@value"/>
  </xsl:template>

  <xsl:template name="is-field-checked">
    <xsl:param name="control-type" />
    <xsl:param name="question" />
    <xsl:param name="group-name" />
    <xsl:param name="value" />

    <xsl:choose>
      <xsl:when test="$control-type = 'radio'">
        <xsl:if test="$sd:form-data/sd:data[@key=$group-name]/@value = $value">
          <xsl:attribute name="checked">checked</xsl:attribute>
        </xsl:if>
      </xsl:when>
      <xsl:when test="$control-type = 'checkbox'">

        <xsl:variable name="submitted-values">
          <xsl:call-template name="string-split">
            <xsl:with-param name="input" select="$sd:form-data/sd:data[@key=$group-name]/@value" />
          </xsl:call-template>
        </xsl:variable>

        <xsl:if test="msxsl:node-set($submitted-values)/node[text() = $value]">
          <xsl:attribute name="checked">checked</xsl:attribute>
        </xsl:if>
      </xsl:when>

    </xsl:choose>

  </xsl:template>
  <xsl:template name="get-field-values-other">
    <xsl:param name="question" />
    <xsl:param name="group-name" />
    <xsl:param name="siblings" />

    <xsl:variable name="submitted-values">
      <xsl:call-template name="string-split">
        <xsl:with-param name="input" select="$sd:form-data/sd:data[@key=$group-name]/@value" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:for-each select="msxsl:node-set($submitted-values)/node">
      <xsl:variable name="temp-value"  select="text()" />
      <xsl:if test="not($question/ancestor-or-self::*[last()]//s:question[@group = $group-name and @value = $temp-value])">
        <node>
          <xsl:value-of select="$temp-value"/>
        </node>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="question-item-template">
    <xsl:param name="question" />
    <xsl:param name="question-id" />
    <xsl:param name="template-before" />
    <xsl:param name="template-after" />
    <xsl:param name="group-name" />

    <xsl:copy-of select="$template-before"/>

    <label for="{$question-id}">
      <xsl:value-of select="$question/@body"/>
    </label>
    <xsl:if test="$template-after">
      <xsl:copy-of select="$template-after"/>
    </xsl:if>
    <xsl:if test="$question/s:question">
      <ol class="row">
        <xsl:attribute name="type">
          <xsl:call-template name="get-ol-type">
            <xsl:with-param name="node" select="." />
          </xsl:call-template>
        </xsl:attribute>

        <xsl:apply-templates select="$question/s:question" />
      </ol>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="ensure-other-CheckRadioBox" match="s:question">
    <xsl:param name="control-type" />
    <xsl:param name="question" />
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />

    <xsl:variable name="siblings" select="(following-sibling::s:question | preceding-sibling::s:question)" />
    <xsl:variable name="others-control-count" select="count($siblings[@control = 'RadioOtherBox' or @control = 'CheckOtherBox'])" />

    <xsl:variable name="other-values">
      <xsl:call-template name="get-field-values-other">
        <xsl:with-param name="question" select="." />
        <xsl:with-param name="siblings" select="$siblings" />
        <xsl:with-param name="group-name" select="$group-name" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="other-values-count" select="count(msxsl:node-set($other-values)/*)" />

    <xsl:if test="$other-values-count > $others-control-count">
      <xsl:for-each select="msxsl:node-set($other-values)/*[position() > $others-control-count]">
        <xsl:variable name="new-value" select="." />
        <xsl:variable name="new-control-type">
          <xsl:choose>
            <xsl:when test="$control-type = 'radio'">
              <xsl:text>RadioOtherBox</xsl:text>
            </xsl:when>
            <xsl:when test="$control-type = 'checkbox'">
              <xsl:text>CheckOtherBox</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:variable>

        <xsl:variable name="new-other">
          <s:question group="{$group-name}" body="Other" value="{$new-value}" control="{$new-control-type}" />
        </xsl:variable>
        <xsl:variable name="new-question-id">
          <xsl:value-of select="$question-id"/>
          <xsl:text>__</xsl:text>
          <xsl:value-of select="position()"/>
        </xsl:variable>

        <li>
          <div>
            <xsl:call-template name="question-item-template">
              <xsl:with-param name="question" select="msxsl:node-set($new-other)/*[1]" />
              <xsl:with-param name="question-id" select="$new-question-id" />
              <xsl:with-param name="group-name" select="$group-name" />
              <xsl:with-param name="template-before">
                <input id="{$new-question-id}"
                       name="{$group-name}"
                       value="{$new-value}"
                       type="{$control-type}"
                       data-linked="secondary-{$new-question-id}"
                       onchange="checkLinkedSet(this)"
                       onclick="focusLinked(this)">
                  <xsl:call-template name="is-field-checked">
                    <xsl:with-param name="control-type" select="$control-type" />
                    <xsl:with-param name="question" select="msxsl:node-set($new-other)/*[1]" />
                    <xsl:with-param name="group-name" select="$group-name" />
                    <xsl:with-param name="value" select="$new-value" />
                  </xsl:call-template>
                </input>
              </xsl:with-param>
              <xsl:with-param name="template-after">
                <input id="secondary-{$question-id}"
                       name="secondary-{$group-name}"
                       value="{$new-value}"
                       type="text"
                       data-rule-required="true"
                       data-linked="{$question-id}"
                       onchange="setLinkedValue(this)" />
                <span id="valid-{$question-id}"
                      class="field-validation-valid"
                      data-valmsg-for="{$group-name}"
                      data-valmsg-replace="true"></span>
              </xsl:with-param>
            </xsl:call-template>
          </div>
        </li>

      </xsl:for-each>
    </xsl:if>

  </xsl:template>

  <xsl:template mode="question-type-CheckRadioBox" match="s:question">
    <xsl:param name="control-type" />
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />

    <xsl:variable name="value">
      <xsl:choose>
        <xsl:when test="@value">
          <xsl:value-of select="@value"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@body"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="question-item-template">
      <xsl:with-param name="question" select="." />
      <xsl:with-param name="question-id" select="$question-id" />
      <xsl:with-param name="group-name" select="$group-name" />
      <xsl:with-param name="template-before">
        <input id="{$question-id}"
               name="{$group-name}"
               value="{$value}"
               data-rule-required="true"
               type="{$control-type}"
               onchange="checkLinkedSet(this)">
          <xsl:call-template name="is-field-checked">
            <xsl:with-param name="control-type" select="$control-type" />
            <xsl:with-param name="question" select="." />
            <xsl:with-param name="group-name" select="$group-name" />
            <xsl:with-param name="value" select="$value" />
          </xsl:call-template>
        </input>
      </xsl:with-param>
      <xsl:with-param name="template-after">
        <span id="valid-{$question-id}"
              class="field-validation-valid"
              data-valmsg-for="{$group-name}"
              data-valmsg-replace="true"></span>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="question-type-DropDownBox" match="s:question">
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />

    <xsl:variable name="value">
      <xsl:value-of select="@value"/>
    </xsl:variable>

    <xsl:call-template name="question-item-template">
      <xsl:with-param name="question" select="." />
      <xsl:with-param name="question-id" select="$question-id" />
      <xsl:with-param name="group-name" select="$group-name" />
      <xsl:with-param name="template-after">
        <!--http://stackoverflow.com/questions/5268182/how-to-remove-namespaces-from-xml-using-xslt-->
        <select id="{$question-id}"
                name="{$group-name}"
                data-rule-required="true">

          <xsl:for-each select="./s:rules/s:options/s:option">
            <option value="{@value}">
              <xsl:if test="@value = $sd:form-data/sd:data[@key=$group-name]/@value">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:value-of select="text()"/>
            </option>
          </xsl:for-each>
        </select>
        <span id="valid-{$question-id}"
              class="field-validation-valid"
              data-valmsg-for="{$group-name}"
              data-valmsg-replace="true"></span>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="question-type-TextBox" match="s:question">
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />

    <xsl:variable name="value">
      <xsl:choose>
        <xsl:when test="$sd:form-data/sd:data[@key=$group-name]/@value">
          <xsl:value-of select="$sd:form-data/sd:data[@key=$group-name]/@value"/>
        </xsl:when>
        <xsl:when test="@value">
          <xsl:value-of select="@value"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="question-item-template">
      <xsl:with-param name="question" select="." />
      <xsl:with-param name="question-id" select="$question-id" />
      <xsl:with-param name="group-name" select="$group-name" />
      <xsl:with-param name="template-after">
        <input id="{$question-id}"
               name="{$group-name}"
               value="{$value}"
               data-rule-required="true"
               type="text" />
        <span id="valid-{$question-id}"
              class="field-validation-valid"
              data-valmsg-for="{$group-name}"
              data-valmsg-replace="true"></span>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="question-type-MultilineTextBox" match="s:question">
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />

    <xsl:variable name="value">
      <xsl:choose>
        <xsl:when test="$sd:form-data/sd:data[@key=$group-name]/@value">
          <xsl:value-of select="$sd:form-data/sd:data[@key=$group-name]/@value"/>
        </xsl:when>
        <xsl:when test="@value">
          <xsl:value-of select="@value"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="question-item-template">
      <xsl:with-param name="question" select="." />
      <xsl:with-param name="question-id" select="$question-id" />
      <xsl:with-param name="group-name" select="$group-name" />
      <xsl:with-param name="template-after">
        <div>
          <textarea id="{$question-id}"
                    name="{$group-name}"
                    data-rule-required="true" >
            <xsl:value-of select="$value"/>
          </textarea>
          <span id="valid-{$question-id}"
                class="field-validation-valid"
                data-valmsg-for="{$group-name}"
                data-valmsg-replace="true"></span>
        </div>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="question-type-FieldSet" match="s:question">
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />
    <fieldset>
      <legend for="{$question-id}">
        <xsl:value-of select="./@body"/>
      </legend>

      <xsl:if test="./s:question">
        <ol>
          <xsl:attribute name="type">
            <xsl:call-template name="get-ol-type">
              <xsl:with-param name="node" select="." />
            </xsl:call-template>
          </xsl:attribute>

          <xsl:apply-templates select="./s:question" />
        </ol>
      </xsl:if>
    </fieldset>
  </xsl:template>
  <xsl:template mode="question-type-Label" match="s:question">
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />
    <xsl:call-template name="question-item-template">
      <xsl:with-param name="question" select="." />
      <xsl:with-param name="question-id" select="$question-id" />
      <xsl:with-param name="group-name" select="$group-name" />
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="question-type-CheckRadioOtherBox" match="s:question">
    <xsl:param name="control-type" />
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />
    <xsl:param name="output-value" />

    <xsl:variable name="values">
      <xsl:call-template name="get-field-values-other">
        <xsl:with-param name="question" select="." />
        <xsl:with-param name="siblings" select="(following-sibling::s:question | preceding-sibling::s:question)" />
        <xsl:with-param name="group-name" select="$group-name" />
      </xsl:call-template>
    </xsl:variable>
    <!-- Note: Updating this section to ensure that multiple "other" fields will be populated -->
    <xsl:variable name="values-position">
      <xsl:value-of select="count(preceding-sibling::s:question[@control = 'RadioOtherBox' or @control = 'CheckOtherBox']) + 1" />
    </xsl:variable>
    <xsl:variable name="value">
      <xsl:value-of select="msxsl:node-set($values)/node[position() = $values-position]/text()"/>
    </xsl:variable>

    <xsl:call-template name="question-item-template">
      <xsl:with-param name="question" select="." />
      <xsl:with-param name="question-id" select="$question-id" />
      <xsl:with-param name="group-name" select="$group-name" />
      <xsl:with-param name="template-before">
        <input id="{$question-id}"
               name="{$group-name}"
               value="{$value}"
               type="{$control-type}"
               data-linked="secondary-{$question-id}"
               onchange="checkLinkedSet(this)"
               onclick="focusLinked(this)">
          <xsl:call-template name="is-field-checked">
            <xsl:with-param name="control-type" select="$control-type" />
            <xsl:with-param name="question" select="." />
            <xsl:with-param name="group-name" select="$group-name" />
            <xsl:with-param name="value" select="$value" />
          </xsl:call-template>
        </input>
      </xsl:with-param>
      <xsl:with-param name="template-after">
        <input id="secondary-{$question-id}"
               name="secondary-{$group-name}"
               value="{$value}"
               type="text"
               data-rule-required="true"
               data-linked="{$question-id}"
               onchange="setLinkedValue(this)" />
        <span id="valid-{$question-id}"
              class="field-validation-valid"
              data-valmsg-for="{$group-name}"
              data-valmsg-replace="true"></span>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="question-type-AddCheckRadioOtherBox" match="s:question">
    <xsl:param name="control-type" />
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />
    <xsl:call-template name="question-item-template">
      <xsl:with-param name="question" select="." />
      <xsl:with-param name="question-id" select="$question-id" />
      <xsl:with-param name="group-name" select="$group-name" />
      <xsl:with-param name="template-before">
        <input id="secondary-{$question-id}"
               name="secondary-{$group-name}"
               value="{@value}"
               type="button"
               data-target-id="{$question-id}"
               data-target-group="{$group-name}"
               onclick="addOtherBox(this, '{$control-type}')" />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="question-type-ReadOnly" match="s:question">
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />

    <xsl:variable name="value">
      <xsl:choose>
        <xsl:when test="$sd:form-data/sd:data[@key=$group-name]/@value">
          <xsl:value-of select="$sd:form-data/sd:data[@key=$group-name]/@value"/>
        </xsl:when>
        <xsl:when test="@value">
          <xsl:value-of select="@value"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:call-template name="question-item-template">
      <xsl:with-param name="question" select="." />
      <xsl:with-param name="question-id" select="$question-id" />
      <xsl:with-param name="group-name" select="$group-name" />
      <xsl:with-param name="template-after">
        <input id="{$question-id}"
               name="{$group-name}"
               value="{$value}"
               type="hidden" />
        <span>
          <xsl:value-of select="$value"/>
        </span>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <xsl:template mode="question-type-Hidden" match="s:question">
    <xsl:param name="group-name" />
    <xsl:param name="question-id" />

    <xsl:variable name="value">
      <xsl:choose>
        <xsl:when test="$sd:form-data/sd:data[@key=$group-name]/@value">
          <xsl:value-of select="$sd:form-data/sd:data[@key=$group-name]/@value"/>
        </xsl:when>
        <xsl:when test="@value">
          <xsl:value-of select="@value"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <input id="{$question-id}"
           name="{$group-name}"
           value="{$value}"
           type="hidden" />

    <xsl:if test="./s:question">
      <ol>
        <xsl:attribute name="type">
          <xsl:call-template name="get-ol-type">
            <xsl:with-param name="node" select="." />
          </xsl:call-template>
        </xsl:attribute>

        <xsl:apply-templates select="./s:question" />
      </ol>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="copy-node" match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" mode="copy-node"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
