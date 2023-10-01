BIN_DIR := bin
BUILD_DIR := build

SRC_IMAGES := $(sort $(wildcard *.png) $(wildcard *.jpg))
#$(info SRC_IMAGES: $(SRC_IMAGES))
SRC_OTHER := .htaccess gallery.css

HTML := $(patsubst %.png, %.html, $(SRC_IMAGES))
HTML := $(patsubst %.jpg, %.html, $(HTML))
HTML := $(addprefix $(BUILD_DIR)/, $(HTML))
#$(info HTML: $(HTML))

.PHONY: all
all: $(BUILD_DIR) $(HTML)

.PHONY: clean
clean:
	@rm -rf *~ $(BUILD_DIR) $(HTML)

$(BUILD_DIR): $(SRC_IMAGES) $(SRC_OTHER)
	@mkdir -p $@
	@cp --force --preserve=timestamps $^ $@
	@touch $@

%.xml: %.png
	@$(BIN_DIR)/gallery-init.sh $< $(SRC_IMAGES) > $@

%.xml: %.jpg
	@$(BIN_DIR)/gallery-init.sh $< $(SRC_IMAGES) > $@

$(BUILD_DIR)/%.html: %.xml gallery.xsl
	$(BIN_DIR)/saxon-xslt.sh $^ -o:$@
