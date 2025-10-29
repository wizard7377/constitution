MDBOOK ?= mdbook
PANDOC ?= pandoc
OUTPUT_DIR ?= output
BUILD_DIR ?= build
INPUTS := $(wildcard src/**/*.md)
MAIN ?= src/TEXT.md
all: $(OUTPUT_DIR)/main.pdf $(OUTPUT_DIR)/main.txt
serve: $(INPUTS)
	$(MDBOOK) serve --open

$(BUILD_DIR)/pdf/output.pdf: $(INPUTS)
	$(MDBOOK) build

$(BUILD_DIR)/text/output.txt: $(INPUTS)

$(OUTPUT_DIR)/main.pdf : $(MAIN)
	mkdir -p $(OUTPUT_DIR)
	$(PANDOC) -t pdf $^ -o $@

$(OUTPUT_DIR)/main.txt : $(MAIN)
	mkdir -p $(OUTPUT_DIR)
	$(PANDOC) -t plain $^ -o $@
clean: 
	rm -rf $(BUILD_DIR) $(OUTPUT_DIR)
	rm -rf output