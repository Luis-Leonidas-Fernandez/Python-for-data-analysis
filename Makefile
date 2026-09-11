.PHONY: dev install clean help

PYTHON_BIN ?= python3

dev: ## Create the virtual environment, install dependencies, and start Jupyter Notebook
	PYTHON_BIN=$(PYTHON_BIN) ./scripts/start.sh

install: ## Create the virtual environment and install dependencies without starting Jupyter
	PYTHON_BIN=$(PYTHON_BIN) START_JUPYTER=0 ./scripts/start.sh

clean: ## Remove local virtual environment and Python cache files
	rm -rf .venv
	find . -type d -name "__pycache__" -prune -exec rm -rf {} +
	find . -type d -name ".ipynb_checkpoints" -prune -exec rm -rf {} +

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "%-12s %s\n", $$1, $$2}'
