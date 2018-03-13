<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output
    method="text"
    indent="no"/>

  <xsl:strip-space elements="*" />

  <xsl:template match="text()">
      <xsl:value-of select='normalize-space()'/>
  </xsl:template>

  <xsl:template match="resume">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="section">
    <xml:text># </xml:text><xsl:value-of select="title" /><xsl:text>&#10;</xsl:text>
    <xsl:apply-templates />
  </xsl:template>

  <!-- ignore the section/title node, because it is already used -->
  <xsl:template match="section/title" />

  <xsl:template match="school">
  </xsl:template>

  <xsl:template match="experience">
    <xsl:value-of select="corp" /><xsl:text>&#10;</xsl:text>
    <xsl:value-of select="pos" /><xsl:text>&#10;</xsl:text>
    <xsl:value-of select="dates/from" />-<xsl:value-of select="dates/to" /><xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="list" />
  </xsl:template>

  <!-- ignore experience metadata -->
  <!-- <xsl:template match="experience/corp" /> -->
  <!-- <xsl:template match="experience/pos" /> -->
  <!-- <xsl:template match="experience/dates" /> -->

  <xsl:template match="list">
\begin{itemize}
<xsl:apply-templates />
\end{itemize}
  </xsl:template>

  <xsl:template match="item">
\item <xsl:apply-templates />
  </xsl:template>
</xsl:stylesheet>
