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
\documentclass{resume}

\begin{document}
<xsl:apply-templates />
\end{document}
  </xsl:template>

  <xsl:template match="section">
\section{<xsl:value-of select="title" />}
<xsl:apply-templates />
  </xsl:template>

  <!-- ignore the section/title node, because it is already used -->
  <xsl:template match="section/title" />

  <xsl:template match="school">
  </xsl:template>

  <xsl:template match="experience">
\experience{<xsl:value-of select="corp" />}{<xsl:value-of select="pos" />}{<xsl:value-of select="dates/from" />-<xsl:value-of select="dates/to" />}
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
