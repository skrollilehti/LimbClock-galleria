# Kuinka LimbClock galleriaa ajetaan paikallisesti

Tässä README tiedostossa kerrotaan kuinka sivustoa ajetaan paikallisesti [Docker](https://www.docker.com/) kontissa (_Docker container_) pyörivällä [Apache HTTP](https://httpd.apache.org/) palvelimella.

"Virallista" http://limbclock.metsankulma.net/ sivustoa ylläpidetään [ISP](https://en.wikipedia.org/wiki/Internet_service_provider) palvelimelta käyttäen jaettua Apache HTTP palvelinta ([shared web hosting](https://en.wikipedia.org/wiki/Shared_web_hosting_service)).

Tämän ISP:n käyttämän tekniikan takia sivusto käyttää Apache HTTP palvelimen konfigurointiin `.htaccess` tiedostoa jonka käyttöä ei muissa tilanteissa suositella. Yleisesti palvelin olisi aina syytä konfiguroida käyttämällä palvelimen pääasiallista konfigurointitiedostoa (` httpd.conf.`). Palvelimen [dokumentaatio](https://httpd.apache.org/docs/2.4/howto/htaccess.html):

> In general, you should only use .htaccess files when you don't have access to the main server configuration file.
> [...]
> This is particularly true, for example, in cases where ISPs are hosting multiple user sites on a single machine, and want their users to be able to alter their configuration.

## Apache HTTP Docker-kuva

Virallinen Apache HTTP Docker-kuva (_Docker image_) löytyy Docker Hubista:
* https://hub.docker.com/_/httpd

Lisäohjeita alkuun pääsyyn:
* https://www.docker.com/blog/how-to-use-the-apache-httpd-docker-official-image/

## limbclock gallerian kontitus

Dockerin käytössä tarvittavat tiedostot löytyvät `docker/` hakemistosta. Niitä käytetään seuraavasti:

1. Luo sivusto normaalisti `make` komennolla (tapahtuu päähakemistossa):
```bash
$ make
```

Tämä luo ja päivittää `build/` hakemiston sisällön joka on jaettu myös konttiin. Näin paikallisesti tehdyt muutokset ovat heti käytössä myös kontissa pyörivälle HTTP palvelimelle.

2. Rakenna kaikki tarvittavat Docker-kuvat ja kontit ja käynnistä HTTP palvelin (tapahtuu `docker/` hakemistossa):
```bash
$ docker compose up --build
```

Nyt selain vastaa osoitteesta http://localhost/ joka on sama sivu kuin mitä varsinaisella palvelimella osoitteessa http://limbclock.metsankulma.net/

Ilman `--detach` lippua Docker kontti käynnistyy komentoriviterminaalissa edustalle ja sen voi lopettaa `CTRL-C` näppäinyhdistelmällä.

3. Käytön jälkeen poista kaikki luodut kontit (tapahtuu `docker/` hakemistossa) ja kuvat:
```bash
$ docker compose rm --force
$ docker image rm limbclock-galleria:latest
```

Docker määrittely koostuu seuraavista tiedostoista:

* `Dockerfile` tiedostolla luodaan sopivasti konfiguroitu Docker-kuva Apache HTTP Docker-kuvan pohjalta.
* `httpd.conf` sisältää HTTP palvelimen konfiguraation.
* `compose.yaml` [Docker Compose](https://docs.docker.com/compose/) tiedosto jolla määritellään Dockerin toiminta.
