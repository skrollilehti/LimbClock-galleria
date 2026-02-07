# Tämä on Apache HTTP palvelimen perusimage jonka räätälöimme.
FROM httpd:2.4

# Kopioidaan oma konfiguraatiotiedosto oikeaan paikkaan.
COPY httpd.conf /usr/local/apache2/conf/httpd.conf

# Poistetaan oletussivu jotta se ei sotke omaa sivustoamme.
RUN rm -f /usr/local/apache2/htdocs/index.html