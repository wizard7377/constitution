MDBOOK ?= mdbook
OUTPUT_DIR ?= output
BUILD_DIR ?= build
OUTPUT_TXT_FILE ?= output
OUTPUT_PDF_FILE ?= output
OUTPUT_TXT := $(OUTPUT_DIR)/$(OUTPUT_TXT_FILE).txt
OUTPUT_PDF := $(OUTPUT_DIR)/$(OUTPUT_PDF_FILE).pdf
INPUTS := $(wildcard src/**/*.md)

all: $(OUTPUT_PDF) $(OUTPUT_TXT)
serve: $(INPUTS)
	$(MDBOOK) serve --open

$(BUILD_DIR)/pdf/output.pdf: $(INPUTS)
	$(MDBOOK) build

$(BUILD_DIR)/text/output.txt: $(INPUTS)

$(OUTPUT_PDF) : $(BUILD_DIR)/pdf/output.pdf
	mkdir -p $(OUTPUT_DIR)
	cp $(BUILD_DIR)/pdf/output.pdf $(OUTPUT_PDF)

$(OUTPUT_TXT) : $(BUILD_DIR)/text/output.txt
	mkdir -p $(OUTPUT_DIR)
	cp $(BUILD_DIR)/pdf/output.pdf $(OUTPUT_TXT)

clean: 
	rm -rf $(BUILD_DIR) $(OUTPUT_DIR)