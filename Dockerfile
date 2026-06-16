FROM node:20-bookworm-slim AS ui-builder

WORKDIR /app/ui

COPY ui/package.json ui/package-lock.json ./
RUN npm ci

COPY ui/ ./
RUN npm run build


FROM python:3.11-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

WORKDIR /app

COPY requirements.txt ./

RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && playwright install --with-deps chromium \
    && rm -rf /root/.cache/pip

COPY . .
COPY --from=ui-builder /app/ui/dist ./ui/dist

RUN mkdir -p /app/data

EXPOSE 8765

VOLUME ["/app/data"]

CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "8765"]
