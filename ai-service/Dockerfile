# ---------- Etapa 1: construir ----------
# Esta etapa instala las librerias. NO llega a la imagen final.
# Se usa Python 3.11 porque es la misma version que trae la imagen distroless de abajo.
FROM python:3.11-slim-bookworm AS build
WORKDIR /app

COPY requirements.txt .
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt

# ---------- Etapa 2: la imagen final ----------
# Imagen "distroless": sin shell ni herramientas extra, mas liviana y segura
FROM gcr.io/distroless/python3-debian12:nonroot
WORKDIR /app

# Se copian las librerias y el codigo
COPY --from=build /install /usr/local
COPY src/ ./src/

# Corre como usuario normal (no administrador)
USER nonroot

EXPOSE 8080
ENTRYPOINT ["python3", "src/main.py"]
