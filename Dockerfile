FROM python:3.11-slim

RUN apt-get update && apt-get install -y git curl nodejs npm && rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

RUN git clone --recurse-submodules https://github.com/oproprioclaw-blip/hermes-agent.git .

RUN uv venv .venv && \
    . .venv/bin/activate && \
    uv pip install -e ".[all]"

CMD ["hermes", "gateway", "--toolsets", "web"]
