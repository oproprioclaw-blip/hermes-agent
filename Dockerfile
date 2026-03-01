FROM python:3.11-slim

RUN apt-get update && apt-get install -y git curl nodejs npm && rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

RUN git submodule update --init --recursive

RUN uv venv .venv && \
    . .venv/bin/activate && \
    uv pip install -e ".[all]" && \
    uv pip install -e "./mini-swe-agent"

CMD ["hermes", "gateway", "--toolsets", "web"]
