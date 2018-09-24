<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY tab "&#xA;">
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs"
  version="2.0">
<xsl:output method="xml" indent="yes"/>

  <xsl:template match="node() | @*">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" />
    </xsl:copy>
  </xsl:template>

  <xsl:strip-space elements="*" />
  <xsl:preserve-space elements="list item skills groupitem skill" />

  <xsl:template match="LaTeX">
    <cmd name="LaTeX" gr="0" />
  </xsl:template>

  <xsl:template match="*[@type='cmd']">
    <cmd>
      <xsl:attribute name="name"><xsl:value-of select="local-name()" /></xsl:attribute>
      <xsl:apply-templates select="keyvals" />
    </cmd>

    <xsl:apply-templates select="*[not(self::keyvals)]" />
  </xsl:template>

  <xsl:template match="keyvals">
    <parm>
      <TeXML escape="0"><xsl:apply-templates select="*" /></TeXML>
    </parm>
  </xsl:template>

  <xsl:template match="keyvals//*">
    <xsl:choose>
      <xsl:when test="* and not(super)">
        <!-- if it has child nodes, apply-templates to the child nodes -->
        <xsl:apply-templates />
      </xsl:when>
      <xsl:otherwise>
        <!-- otherwise, create a keyval out of the contents of this node -->
        <xsl:value-of select="local-name()" />
        <xsl:text>={</xsl:text>
        <xsl:apply-templates />
        <!-- <xsl:value-of select="." /> -->
        <xsl:text>},</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="resume">
    <TeXML>
      <!-- create header -->
      <cmd name="documentclass" nl2="1">
        <parm>resume</parm>
      </cmd>

      <!-- process content -->
      <env name="document">
        <xsl:apply-templates />
      </env>
    </TeXML>
  </xsl:template>

  <xsl:template match="section">
    <cmd name="section" nl2="1">
      <parm><xsl:value-of select="title" /></parm>
    </cmd>

    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="section/title" />

  <xsl:template match="list">
    <env name="itemize">
      <xsl:apply-templates />
    </env>
  </xsl:template>

  <xsl:template match="list/item">
    <cmd name="item" gr="0" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="." />
  </xsl:template>

  <xsl:template match="schools/longest" />

  <xsl:template match="skills">
    <env name="skills">
      <parm><xsl:value-of select="longest" /></parm>
      <xsl:apply-templates />
    </env>
  </xsl:template>

  <xsl:template match="skills/longest" />

  <xsl:template match="skills/group">
    <env name="groupitem">
      <parm><xsl:value-of select="title" /></parm>
      <xsl:apply-templates />
    </env>
  </xsl:template>

  <xsl:template match="skills/group/title" />

  <xsl:template match="skills/group/skill">
    <cmd name="item" gr="0" />
    <xsl:text> </xsl:text>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="awards">
    <env name="awards">
      <xsl:apply-templates />
    </env>
  </xsl:template>

  <xsl:template match="super">
    <cmd name="textsuperscript" gr="0">
      <param><xsl:value-of select="." /></param>
    </cmd>
  </xsl:template>

  <!-- superscripts in a keyval are already being escaped, so they need -->
  <!-- a different template -->
  <xsl:template match="keyvals//super">
    <xsl:text>\textsuperscript{</xsl:text>
    <xsl:value-of select="." />
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="LaTeX">
    <cmd name="LaTeX" gr="0" />
  </xsl:template>

  <xsl:template match="nobrksp">
    <spec cat="tilde" />
  </xsl:template>
</xsl:stylesheet>
