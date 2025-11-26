<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Aircraft information</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; }
          h1 { font-size: 24px; margin-bottom: 20px; }
          h3 { font-size: 14px; }
          .checklist { padding: 8px; margin-top: 15px; font-size: 13px; font-weight: bold; page-break-after: avoid; }
          .checklistcontainer { page-break-inside: avoid; }
          .sectioncontainer { page-break-inside: avoid; }
          .section { margin-left: 20px; background-color: #E0E0E0; padding: 6px; margin-top: 10px; font-size: 12px; font-weight: bold; page-break-after: avoid; }
          .item { margin-left: 20px; font-size: 11px; margin-top: 4px; }
          .Preflight, .Postflight { background-color: #CCFFCC; }
          .DuringFlight { background-color: #CCE5FF; }
          .Emergency { background-color: #FFCCCC; }
          p { font-size: 11px; }
          li { font-size: 11px; }
          @media print {
            @page {
              size: A5 portrait;
              margin: 0.5cm;
            }
          }
        </style>
      </head>
      <body>
        <h1><xsl:value-of select="/Aircraft/@Registration"/> (<xsl:value-of select="/Aircraft/@Name"/>)</h1>
        <h3>Airplane data</h3>
        <div>
          <p>Empty weight: <xsl:value-of select="/Aircraft/@EmptyWeight"/>, arm: <xsl:value-of select="/Aircraft/@EmptyArmLon"/></p>
          <p>Maximum weight: <xsl:value-of select="/Aircraft/@MaximumWeight"/></p>
          <p>Envelope: <xsl:value-of select="/Aircraft/@Envelope"/></p>
        </div>
        <h3>Loading points</h3>
        <ul>
          <xsl:for-each select="/Aircraft/LoadingPoints/FuelLoadingPoint">
            <li><xsl:value-of select="@Name"/>, arm: <xsl:value-of select="@LeverArm"/></li>
          </xsl:for-each>
          <xsl:for-each select="/Aircraft/LoadingPoints/LoadingPoint">
            <li><xsl:value-of select="@Name"/>, arm: <xsl:value-of select="@LeverArm"/></li>
          </xsl:for-each>
        </ul>
        <h3 style="page-break-before: always">Checklists</h3>
        <xsl:for-each select="/Aircraft/ChecklistBundle/Checklist[@FlightPhase='Preflight']">
          <xsl:call-template name="checlist" />
        </xsl:for-each>
        <xsl:for-each select="/Aircraft/ChecklistBundle/Checklist[@FlightPhase='DuringFlight']">
          <xsl:call-template name="checlist" />
        </xsl:for-each>
        <xsl:for-each select="/Aircraft/ChecklistBundle/Checklist[@FlightPhase='Emergency']">
          <xsl:call-template name="checlist" />
        </xsl:for-each>
        <xsl:for-each select="/Aircraft/ChecklistBundle/Checklist[@FlightPhase='Postflight']">
          <xsl:call-template name="checlist" />
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="checlist">
    <div class="checklist {@FlightPhase}">
      <xsl:value-of select="@Name"/>
    </div>
    <div class="checklistcontainer">
      <xsl:for-each select="Section">
        <div class="sectioncontainer">
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
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>
</xsl:stylesheet>