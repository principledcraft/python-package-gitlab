# A Python package template with a GitLab CI/CD pipeline

A template for a python package with a GitLab CI/CD template

## Requirements

- [uv](https://docs.astral.sh/uv/)
- [just](https://just.systems/)

## Development

Install dependencies:

```sh
just sync
```

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

## CI/CD

The GitLab pipeline runs on every push and has three stages:

| Stage    | Jobs                                                    |
|----------|---------------------------------------------------------|
| Build    | Build and push a Docker image to the GitLab registry    |
| Checks   | Lint, format check, type-check, test, vulnerability scan, code quality threshold |
| Docs     | Build and archive MkDocs documentation                  |

## Project structure

```
src/myapp/       # Package source
tests/           # pytest tests
docs/            # MkDocs documentation source
Dockerfile       # CI build image (Debian slim + uv)
justfile         # Local dev commands
pyproject.toml   # Project metadata, Ruff, and build config
mkdocs.yml       # Documentation config
.gitlab-ci.yml   # GitLab CI/CD pipeline
```
