# Makefile für Pandoc mit Markdown-Linting und dynamischen Zielen

# Makefile mit korrektem Docker-Aufruf
SHELL := /bin/bash -euo pipefail

# Standard-Pandoc-Optionen
TEMPLATE ?= eisvogel
HIGHLIGHT_STYLE ?= tango

%.pdf: %.md
	docker run --rm -v "$(CURDIR):/data" -u $$(id -u):$$(id -g) pandoc/extra $< -o $@ \
		--template=$(TEMPLATE) \
		--syntax-highlighting=$(HIGHLIGHT_STYLE)
	@echo "✅ Generiert: $@"


# Markdown-Syntax prüfen (z. B. `make lint-03_was`)
lint-%:
	@if [ ! -f "$*.md" ]; then \
		echo "❌ Fehler: Datei '$*.md' nicht gefunden."; \
		exit 1; \
	fi
	npx markdownlint-cli "$*.md" --fix  # Optional: Automatische Korrekturen
	@echo "✅ Linting abgeschlossen für: $*.md"

# PDF löschen (z. B. `make clean-03_was`)
clean-%:
	@if [ ! -f "$*.pdf" ]; then \
		echo "ℹ️  Keine PDF-Datei '$*.pdf' zum Löschen gefunden."; \
	else \
		rm -f "$*.pdf"; \
		echo "🗑️  Gelöscht: $*.pdf"; \
	fi

# Hilfetext
help:
	@echo "📖 Makefile-Hilfe:"
	@echo "  make NAME.pdf      # PDF aus NAME.md erzeugen"
	@echo "  make lint-NAME     # Markdown-Syntax prüfen (NAME.md)"
	@echo "  make clean-NAME    # NAME.pdf löschen"
	@echo "  make help          # Diese Hilfe anzeigen"
	@echo "  make TEMPLATE=xy  # Benutzerdefiniertes Template nutzen"

.PHONY: lint-% clean-% help
