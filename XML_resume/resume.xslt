<?xml version="1.0"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="resume">
    \documentclass{resume}

    \begin{document}
      <xsl:apply-templates/>
    \end{document}
  </xsl:template>

  <xsl:template match="section">
    \section{<xsl:value-of select="@name" />}
      <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>
