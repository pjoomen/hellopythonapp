FROM cgr.dev/chainguard/wolfi-base:latest as builder

ARG version=3.13

ENV \
    LANG=C.UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/app/venv/bin:$PATH"

WORKDIR /app
RUN apk update && apk add python-$version py${version}-pip && \
    chown -R nonroot:nonroot /app/

USER nonroot
RUN python -m venv /app/venv

COPY requirements.txt /app/
RUN pip install --no-cache-dir --disable-pip-version-check --progress-bar off -r requirements.txt && \
	pip uninstall pip --yes

FROM cgr.dev/chainguard/python:latest

LABEL \
  org.opencontainers.image.source=https://github.com/pjoomen/hellopythonapp
WORKDIR /app
ENV \
  PYTHONUNBUFFERED=1 \
  PATH="/app/venv/bin:$PATH"

COPY app/ ./
COPY --from=builder /app/venv /app/venv

EXPOSE 8080
ENTRYPOINT ["gunicorn", "wsgi", "--bind=0.0.0.0:8080", "--log-level=INFO", "--timeout=180"]
