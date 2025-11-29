# Start from slim Debian
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies: python, pip, curl, git, and docker-cli
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        python3-venv \
        curl \
        git \
        docker.io \
        ca-certificates \
        zip \
    && rm -rf /var/lib/apt/lists/*

# Install uv (from PyPI)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN export UV_LINK_MODE=copy

ENV PATH="/root/.local/bin:${PATH}"

RUN uv tool install uv-secure

WORKDIR /

COPY . .

RUN uv sync --all-groups

# Run as root (default) – allows access to Docker socket and registry push
CMD [ "bash" ]