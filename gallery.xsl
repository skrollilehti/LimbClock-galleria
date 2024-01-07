<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="#all"
    expand-text="yes"
>
    <xsl:output method="html"/>

    <xsl:template match="/meta" name="xsl:initial-template">
        <html lang="fi"> 
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <meta name="description" content="Leo Loikkasen Skrollin lukijakanavilla julkaisemaa kuvitusta (CC BY-SA 4.0)."/>
                <meta name="author" content="webmaster@metsankulma.net"/>
                <link rel="stylesheet" type="text/css" href="gallery.css"/>
                <title>limbclock @ Skrollin lukijakanavat</title> 
            </head> 
            <body>
                <h1>limbclock @ Skrollin lukijakanavat</h1>
                <p>Leo Loikkasen <a href="https://limbclock.itch.io/">limbclock</a>-nimimerkillä <a href="https://skrolli.fi/">Skrollin</a><xsl:text> </xsl:text><a href="https://skrolli.fi/lukijakanavat/">lukijakanavilla</a> julkaisemaa kuvitusta.</p>
                <p>Kaikki kuvat ja "vitsin takaa"-tekstit on lisensoitu <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/deed.fi">Creative Commons Nimeä-JaaSamoin 4.0 Kansainvälinen</a> lisenssillä.</p>
                <img id="license_image" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png"/>
                <div id="navi_years">
                  [<a href="2023/alku">2023 alku</a>]
                  [<a href="2023/loppu">2023 loppu</a>]
                  [<a href="2024/alku">2024 alku</a>]
                  [<a href="2024/loppu">2024 loppu</a>]
                </div>
                <div id="navi_all">
                    <xsl:apply-templates select="navigation/first|navigation/prev|navigation/next|navigation/last"/>
                </div>
                <xsl:apply-templates select="description"/>
                <xsl:copy-of select="img"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="first|prev|next|last" mode="#default">
        [<xsl:copy-of select="a"/>]
    </xsl:template>

    <xsl:template match="description" mode="#default">
      <details>
        <summary>Vitsin takaa</summary>
        <xsl:copy-of select="normalize-space(text())"/>
      </details>
    </xsl:template>

</xsl:stylesheet>
