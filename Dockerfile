FROM ghcr.io/astral-sh/uv:bookworm
WORKDIR /app

ENV UV_LINK_MODE=hardlink 
ENV UV_CACHE_DIR=/opt/uv-cache/
ENV VIRTUAL_ENV=/opt/env

RUN uv venv /opt/env --python 3.11

# MINIMUM BUILD (Doesnt re run when requirements.txt is modified)
RUN --mount=type=bind,source=./requirements.txt,target=/app/requirements.txt \
 uv pip install -r requirements.txt

# FULL REPO
COPY ./ /app
RUN uv pip install -r requirements.txt

CMD ["python"]
