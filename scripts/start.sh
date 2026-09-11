#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VENV_DIR="$PROJECT_ROOT/.venv"
PYTHON_BIN="${PYTHON_BIN:-python3}"
START_JUPYTER="${START_JUPYTER:-1}"
INSTALL_STAMP="$VENV_DIR/.requirements-installed"
export MPLCONFIGDIR="$VENV_DIR/matplotlib"

cd "$PROJECT_ROOT"
mkdir -p "$MPLCONFIGDIR"

echo "▶ Python for Data Analysis — Study Environment"
echo "Project: $PROJECT_ROOT"

if [ ! -d "$VENV_DIR" ]; then
  echo "▶ Creating virtual environment in .venv"
  "$PYTHON_BIN" -m venv "$VENV_DIR"
fi

# shellcheck disable=SC1091
source "$VENV_DIR/bin/activate"

echo "▶ Using Python: $(python --version)"

if [ ! -f requirements.txt ]; then
  echo "✖ requirements.txt not found"
  exit 1
fi

if [ ! -f "$INSTALL_STAMP" ] || [ requirements.txt -nt "$INSTALL_STAMP" ]; then
  echo "▶ Installing dependencies from requirements.txt"
  python -m pip install --upgrade pip
  python -m pip install -r requirements.txt
  touch "$INSTALL_STAMP"
else
  echo "▶ Dependencies already installed"
fi

if [ "$START_JUPYTER" = "1" ]; then
  echo "▶ Starting Jupyter Notebook"
  echo "Press Ctrl+C to stop the server."
  jupyter notebook
else
  echo "▶ Environment ready. Run `make dev` to start Jupyter."
fi
