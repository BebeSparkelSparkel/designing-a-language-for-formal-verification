# Makefile for rendering GitHub-flavored Markdown files to HTML for publication on X

# Directories
SERIES_DIR = series
ADJUNCTS_DIR = adjuncts
BUILD_DIR = build

# Find all markdown files
SERIES_MD = $(wildcard $(SERIES_DIR)/*.md)
ADJUNCTS_MD = $(wildcard $(ADJUNCTS_DIR)/*.md)
ALL_MD = $(SERIES_MD) $(ADJUNCTS_MD)

# Convert paths to build HTML files
SERIES_HTML = $(patsubst $(SERIES_DIR)/%.md,$(BUILD_DIR)/$(SERIES_DIR)/%.html,$(SERIES_MD))
ADJUNCTS_HTML = $(patsubst $(ADJUNCTS_DIR)/%.md,$(BUILD_DIR)/$(ADJUNCTS_DIR)/%.html,$(ADJUNCTS_MD))
ALL_HTML = $(SERIES_HTML) $(ADJUNCTS_HTML)

# Tools and options
PANDOC = pandoc
PANDOC_OPTS = --ascii -f gfm -t html
SED = sed
TR = tr

# Main targets
.PHONY: all clean dirs

all: dirs $(ALL_HTML)

# Create build directory structure
dirs:
	mkdir -p $(BUILD_DIR)/$(SERIES_DIR) $(BUILD_DIR)/$(ADJUNCTS_DIR)

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

# Rule to convert a single file to clipboard (for manual use)
.PHONY: to-clipboard
to-clipboard:
	@if [ -z "$(FILE)" ]; then \
		echo "Usage: make to-clipboard FILE=path/to/file.md"; \
	else \
		cat $(FILE) | $(SED) 's/\\\(\\[{}]\)/\1/g' | $(SED) -f mark-code-block-newlines.sed | $(PANDOC) $(PANDOC_OPTS) | $(SED) 's/A/908345a0978235/g' | $(SED) 's/lf492317/A/g' | $(TR) '\nA' ' \n' |  $(SED) 's/908345a0978235/A/g' | xclip -selection clipboard && \
		echo "Content from $(FILE) has been copied to clipboard for X"; \
	fi

# General rule for converting Markdown to HTML
$(BUILD_DIR)/%.html: %.md
	@echo "Converting $< to $@"
	@mkdir -p $(dir $@)
	@cat $< | $(SED) 's/\\\(\\[{}]\)/\1/g' | $(SED) -f mark-code-block-newlines.sed | $(PANDOC) $(PANDOC_OPTS) | $(SED) 's/A/908345a0978235/g' | $(SED) 's/lf492317/A/g' | $(TR) '\nA' ' \n' |  $(SED) 's/908345a0978235/A/g' > $@

# Generate a list of all available documents
.PHONY: list
list:
	@echo "Available Series Documents:"
	@for file in $(SERIES_MD); do echo "  $$file"; done
	@echo "Available Adjunct Documents:"
	@for file in $(ADJUNCTS_MD); do echo "  $$file"; done

# Convert a specific series file
.PHONY: series
series:
	@if [ -z "$(NUM)" ]; then \
		echo "Usage: make series NUM=XX"; \
	else \
		FILE=$$(find $(SERIES_DIR) -name "$(NUM)*.md" | head -1); \
		if [ -z "$$FILE" ]; then \
			echo "No series file starting with $(NUM) found"; \
		else \
			$(MAKE) to-clipboard FILE=$$FILE; \
		fi; \
	fi

# Convert a specific adjunct file by partial name
.PHONY: adjunct
adjunct:
	@if [ -z "$(NAME)" ]; then \
		echo "Usage: make adjunct NAME=partial-name"; \
	else \
		FILE=$$(find $(ADJUNCTS_DIR) -name "*$(NAME)*.md" | head -1); \
		if [ -z "$$FILE" ]; then \
			echo "No adjunct file containing '$(NAME)' found"; \
		else \
			$(MAKE) to-clipboard FILE=$$FILE; \
		fi; \
	fi

# Help target
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all            - Convert all markdown files to HTML in the build directory"
	@echo "  clean          - Remove build directory"
	@echo "  list           - List all available markdown files"
	@echo "  to-clipboard   - Copy a specific file's HTML to clipboard (usage: make to-clipboard FILE=path/to/file.md)"
	@echo "  series         - Copy a specific series file to clipboard by number (usage: make series NUM=01)"
	@echo "  adjunct        - Copy a specific adjunct file to clipboard by partial name (usage: make adjunct NAME=modules)"
	@echo "  help           - Show this help message"
