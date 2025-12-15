PANDOC ?= pandoc
DEFAULT_DIR ?= ./defaults/
SRCS := $(wildcard src/**.md)
OUTPUT_DIR ?= output
OPTS := --lua-filter=lua/basic.lua
all: clean main.html main.pdf main.docx main.txt main.md main.epub main.rtf main.rst
.PHONY: all clean

main.%: $(SRCS) $(OUTPUT_DIR) 
	$(PANDOC) $(OPTS) --defaults $(DEFAULT_DIR)$*.yaml


clean: 
	rm -rf output
	mkdir output