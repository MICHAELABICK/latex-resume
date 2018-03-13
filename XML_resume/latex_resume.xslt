<?xml version="1.0"?>
<!-- TODO: Determine why entities are not working -->
<!DOCTYPE stylesheet [
  <!ENTITY space "<xsl:text> </xsl:text>">
  <!ENTITY tab "<xsl:text>&#x9;</xsl:text>">
  <!ENTITY cr "<xsl:text>&#13;</xsl:text>">
]>
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
    <xsl:text>\documentclass{resume}

\begin{document}</xsl:text>&cr;
    <xsl:apply-templates />
    <xsl:text>\end{document}</xsl:text>
  </xsl:template>

  <xsl:template match="section">
    &tab;<xsl:text>\section{</xsl:text><xsl:value-of select="title" /><xsl:text>}</xsl:text>&cr;
    <xsl:apply-templates />
  </xsl:template>

  <!-- ignore the section/title node, because it is already used -->
  <xsl:template match="section/title" />

  <xsl:template match="school">
  </xsl:template>

  <xsl:template match="experience">
    &tab;<xsl:text>\experience{</xsl:text><xsl:value-of select="corp" />}{<xsl:value-of select="pos" />}{<xsl:value-of select="dates/from" />-<xsl:value-of select="dates/to" /><xsl:text>}</xsl:text>&cr;
    <xsl:apply-templates select="list" />
  </xsl:template>

  <!-- ignore experience metadata -->
  <!-- <xsl:template match="experience/corp" /> -->
  <!-- <xsl:template match="experience/pos" /> -->
  <!-- <xsl:template match="experience/dates" /> -->

  <xsl:template match="list">
    &tab;<xsl:text>\begin{itemize}</xsl:text>&cr;
    <xsl:apply-templates />
    &tab;<xsl:text>\end{itemize}</xsl:text>&cr;
  </xsl:template>

  <xsl:template match="item">
\item <xsl:apply-templates />
  </xsl:template>
</xsl:stylesheet>
