# See https://just.systems/man/en/ for installation and usage

set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

# Sync all uv packages
sync:
    uv sync --all-groups

# Format using Ruff
fmt:
    uv run ruff format

# Lint using Ruff
lint:
    uv run ruff check .

# Typecheck using Ty
typecheck:
    uv run ty check .

# Test using pytest
test:
    uv run pytest

# Serve docs using mkdocs-material
docs:
    uv run mkdocs serve

# Show a radon maintainability index quality report
qa_report:
    uv run radon mi .

# Run quality check with Xenon
qa_guard:
    uv run xenon . --max-absolute A --max-modules A --max-average A
