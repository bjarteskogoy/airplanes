<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Aircraft Checklists</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; }
          h1 { font-size: 24px; margin-bottom: 20px; }
          .checklist { padding: 8px; margin-top: 15px; font-size: 13px; font-weight: bold; }
          .section { background-color: #E0E0E0; padding: 6px; margin-top: 10px; font-size: 12px; font-weight: bold; }
          .item { margin-left: 20px; font-size: 11px; margin-top: 4px; }
          .Preflight, .Postflight { background-color: #CCFFCC; }
          .DuringFlight { background-color: #CCE5FF; }
          .Emergency { background-color: #FFCCCC; }
        </style>
      </head>
      <body>
        <h1><xsl:value-of select="/Aircraft/@Name"/> (<xsl:value-of select="/Aircraft/@Registration"/>)</h1>
        <xsl:for-each select="/Aircraft/ChecklistBundle/Checklist">
          <xsl:sort select="@FlightPhase" data-type="text" order="ascending"/>
          <div class="checklist {@FlightPhase}">
            <xsl:value-of select="@Name"/>
          </div>

          <xsl:for-each select="Section">
            <xsl:if test="string-length(@Name) &gt; 1">
              <div class="section">
                <xsl:value-of select="@Name"/>
              </div>
            </xsl:if>

            <xsl:for-each select="CheckItem">
              <div class="item">
                <xsl:value-of select="@Challenge"/>: <xsl:value-of select="@Response"/>
              </div>
            </xsl:for-each>
          </xsl:for-each>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>