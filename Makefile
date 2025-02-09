.PHONY: doc-site clean

doc-site:
	@echo "Cleaning old documentation..."
	rm -rf docs
	@echo "Generating markdown documentation..."
	ldoc . --dir docs --ext md --format markdown --verbose

clean:
	rm -rf docs