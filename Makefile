# RecFlow-PyTorch
 
PYTHON  = python3
VENV    = chalu
PIP     = $(VENV)/bin/pip
PY      = $(VENV)/bin/python
 
# ──────────────────────────── Setup ────────────────────────────
 
.PHONY: setup install clean nuke help
 
setup: $(VENV)/bin/activate install
	@echo "Ready. Run: source venv/bin/activate"
 
$(VENV)/bin/activate:
	$(PYTHON) -m venv $(VENV)
 
install: $(VENV)/bin/activate
	$(PIP) install --upgrade pip
	$(PIP) install -e ".[dev]"
 
clean:
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -name "*.pyc" -delete 2>/dev/null || true
	@echo "Cleaned"
 
nuke: clean
	rm -rf $(VENV) *.egg-info src/*.egg-info
	@echo "Nuked. Run 'make setup' to rebuild."
 
help:
	@grep -E '^[a-zA-Z_-]+:.*?##' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'
 
.DEFAULT_GOAL := help