# Tämä on Apache HTTP palvelimen peruskuva jonka räätälöimme.
# Docker osaa käydä lataamassa tämän kuvan Docker Hubista.
FROM httpd:2.4

# Kopioidaan oma konfiguraatiotiedosto oikeaan paikkaan palvelimella.
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Poistetaan oletussivu jotta se ei sotke omaa sivustoamme.
RUN rm -f /usr/local/apache2/htdocs/index.html