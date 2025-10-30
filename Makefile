MDBOOK ?= mdbook
PANDOC ?= pandoc
OUTPUT_DIR ?= output
BUILD_DIR ?= build
INPUTS := $(wildcard src/**/*.md)
OUTPUT_EXTS += pdf txt md rtf odt epub html docx 
OUTPUT_FILES := $(foreach file_ext, $(OUTPUT_EXTS), $(OUTPUT_DIR)/main.$(file_ext))
MAIN ?= src/TEXT.md src/Core/Preamble.md src/Core/Main.md src/Core/Rights.md
DEFAULT_FILE ?= DEFAULTS.yaml
all: clean $(OUTPUT_FILES)
serve: $(INPUTS)
	$(MDBOOK) serve --open

$(BUILD_DIR)/pdf/output.pdf: $(INPUTS)
	$(MDBOOK) build


$(OUTPUT_DIR)/main.% : $(INPUTS)
	@mkdir -p $(OUTPUT_DIR)
	$(PANDOC) --defaults $(DEFAULT_FILE) -o $@

# For whatever reason, pandoc's plain text output requires -t plain
$(OUTPUT_DIR)/main.txt : $(INPUTS)
	mkdir -p $(OUTPUT_DIR)
	$(PANDOC) -t plain --defaults $(DEFAULT_FILE) -o $@


clean: 
	@rm -rf $(BUILD_DIR) $(OUTPUT_DIR)
	@rm -rf output
