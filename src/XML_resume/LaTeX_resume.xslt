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

  <xsl:template match="schools">
\begin{schools}{<xsl:value-of select="longest" />}
<xsl:apply-templates />
\end{schools}
  </xsl:template>

  <!-- ignore the schools/longest node, because it is already used -->
  <xsl:template match="schools/longest" />

  <xsl:template match="school">
    \school{name={<xsl:value-of select="name" />},loc={<xsl:value-of select="location" />},from={<xsl:value-of select="dates/from" />},to={<xsl:value-of select="dates/to" />},major={<xsl:value-of select="major" />},minor={<xsl:value-of select="minor" />},year={<xsl:value-of select="year" />},gpa={<xsl:value-of select="gpa" />},grad={<xsl:value-of select="grad" />}}
  </xsl:template>

  <xsl:template match="experience">
    &tab;\experience{corp={<xsl:value-of select="corp" />},pos={<xsl:value-of select="pos" />},from={<xsl:value-of select="dates/from" />},to={<xsl:value-of select="dates/to" />}}&cr;
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

  <xsl:template match="skills">
\begin{skills}{<xsl:value-of select="longest" />}
<xsl:apply-templates />
\end{skills}
  </xsl:template>

  <!-- ignore the skills/longest node, because it is already used -->
  <xsl:template match="skills/longest" />

  <xsl:template match="skill">
    \item [<xsl:value-of select="group" />] <xsl:value-of select="text" />
  </xsl:template>
</xsl:stylesheet>
