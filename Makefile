# Piilotetaan arvot muuttujien taakse jotta vältetään taikamerkkijonot.
BIN_DIR := bin
BUILD_DIR := build

# Kerätään muuttujaan kaikki kuvatiedostot ja järjestetään ne tiedotosnimen
# perusteella.
SRC_IMAGES := $(sort $(wildcard *.png) $(wildcard *.jpg) $(wildcard *.webp))

# Esimerkki miten muuttujien arvoja voidaan tulostaa. Käytetään vain vianetsinnässä.
# $(info SRC_IMAGES: $(SRC_IMAGES))

# Muut tiedostot jotka täytyy siirtää palvelimelle.
SRC_OTHER := .htaccess gallery.css

# Luodaan kuvatiedostojen nimien perusteella lopullisten HTML tiedostojen
# nimet:
# 1) korvataan .png, .jpg ja .webp tiedostopäätteet .html tiedostopäätteellä
# 2) lisätään jokaisen nimen alkuun build/ polku
# Esimerkki:
# lähtötiedosto: skrolli-leol-20230922-ping.png
# kohdetiedosto: build/skrolli-leol-20230922-ping.html
HTML := $(patsubst %.png, %.html, $(SRC_IMAGES))
HTML := $(patsubst %.jpg, %.html, $(HTML))
HTML := $(patsubst %.webp, %.html, $(HTML))
HTML := $(addprefix $(BUILD_DIR)/, $(HTML))

# Esimerkki miten muuttujien arvoja voidaan tulostaa. Käytetään vain vianetsinnässä.
# $(info HTML: $(HTML))

# Tästä alkavat säännöt jotka kuvaavat miten uudet tiedostot pitää luoda.
# Makessa ensimmäinen sääntö on myös oletussääntö jota kutsutaan jos sääntöä
# ei anneta parametrina. Perinteisesti oletussäännön nimi on all: make all

# Yksinkertaistetusti säännön rakenne on seuraava:
# kohde: riippuvuudet
#	komento
# kohde on tiedosto joka luodaan
# riippuvuudet on optionaalinen lista tiedostoja joista kohde riippuu
# komento kertoo miten kohde luodaa (komentoja voi olla useampi)

# Sanotaan eksplisiittisesti että sääntö jonka kohde on all ei luo all nimistä
# tiedostoa.
.PHONY: all
# all kohde ei suorita komentoa mutta se riippuu kaikista niistä tiedostoista
# jotka löytyvät BUILD_DIR ja HTML muuttujista. Tämä käynnistää näiden
# tiedostojen luonnin.
all: $(BUILD_DIR) $(HTML)

# clean kohteella ei ole riippuvuuksia eikä se ole tiedosto joten sen komento
# ajetaan aina kun sääntöä kutsutaan: make clean. Tämä sääntö poistaa kaikki
# luodut tiedostot ja emacsin varmuuskopioteidostot (*~).
.PHONY: clean
clean:
	@rm -rf *~ $(BUILD_DIR) $(HTML)

# Luodaan build hakemisto ja kopioidaan sinne kaikki ne vakiotiedostot jotka
# sivusto tarvitsee (eli pääasiassa kuvatiedostot).
# Tämän hakemiston sisältö synkronoidaan myöhemmin palvelimelle.
# @ komennon alussa estää komennon kaiuttamisen
# $@ ja $^ ovat automaattisia muuttujia joista
# $@ on kohde (tiedostonimi)
# $^ on kaikki riippuvuudet
$(BUILD_DIR): $(SRC_IMAGES) $(SRC_OTHER)
	@mkdir -p $@
	@cp --force --preserve=timestamps $^ $@
	@touch $@

# Sääntö jolla luodaan .png päätteisestä tiedostosta (riippuvuus) vastaava
# .xml päätteinen tiedosto (kohde) image-metadata.sh ohjelman avulla
# (komento).  Automaattinen muuttuja $< tarkoittaa ensimmäistä
# riippuvuutta. Koska säännössä on vain yksi riippuvuus niin voitaisiin
# käyttää myös muuttujaa $^ joka tarkoittaa kaikkia riippuvuuksia.
%.xml: %.png
	@$(BIN_DIR)/image-metadata.sh $< $(SRC_IMAGES) > $@

# Sama kuin edellä mutta .jpg tiedostosta.
%.xml: %.jpg
	@$(BIN_DIR)/image-metadata.sh $< $(SRC_IMAGES) > $@

# Sama kuin edellä mutta .webp tiedostosta.
%.xml: %.webp
	@$(BIN_DIR)/image-metadata.sh $< $(SRC_IMAGES) > $@

# Sääntö jolla luodaan edellisilla säännöillä luodusta .xml tiedostosta
# (riippuvuus) lopullinen .html tiedosto (kohde) build hakemistoon. Sääntö
# riippuu myös XSLT ohjaustiedostosta (gallery.xsl) jossa määritellään .html
# tiedoston muoto.
$(BUILD_DIR)/%.html: %.xml gallery.xsl
	$(BIN_DIR)/saxon-xslt.sh $^ -o:$@
