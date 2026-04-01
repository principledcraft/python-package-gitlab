# A Python package template with a GitLab CI/CD pipeline

A template for a Python package with a GitLab CI/CD pipeline.

## Dev container (recommended)

Requires the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension in VS Code. Open the repository and select **Reopen in Container** when prompted. Python 3.13, `uv`, `just`, and all VS Code extensions are provisioned automatically. Then run `just sync` to install dependencies.

## Manual setup

Requires [uv](https://docs.astral.sh/uv/) and [just](https://just.systems/).

```sh
just sync
```

## Commands

| Command          | Description                              |
|------------------|------------------------------------------|
| `just sync`      | Install all dependencies                 |
| `just fmt`       | Format code with Ruff                    |
| `just lint`      | Lint code with Ruff                      |
| `just typecheck` | Type-check with Ty                       |
| `just test`      | Run tests with pytest                    |
| `just docs`      | Serve documentation locally with MkDocs  |
| `just qa_report` | Maintainability index report via Radon   |
| `just qa_guard`  | Enforce code quality threshold via Xenon |

## AI-assisted development

This project includes a [CLAUDE.md](CLAUDE.md) — a guidelines file read by [Claude Code](https://claude.ai/code) at the start of every session. It encodes conventions for code quality, readability, and workflow so that AI-assisted changes stay consistent with the project's standards.

## CI/CD

The GitLab pipeline runs on every push and has three stages:

| Stage    | Jobs                                                    |
|----------|---------------------------------------------------------|
| Build    | Build and push a Docker image to the GitLab registry    |
| Checks   | Lint, format check, type-check, test, vulnerability scan, code quality threshold |
| Docs     | Build and archive MkDocs documentation                  |

## Project structure

```
src/myapp/         # Package source
tests/             # pytest tests
docs/              # MkDocs documentation source
.devcontainer/     # Dev container configuration
Dockerfile         # CI build image (Debian slim + uv)
justfile           # Local dev commands
pyproject.toml     # Project metadata, Ruff, and build config
mkdocs.yml         # Documentation config
.gitlab-ci.yml     # GitLab CI/CD pipeline
```
