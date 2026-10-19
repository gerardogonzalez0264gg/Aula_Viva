# ---------- Etapa 1: construir ----------
# Aqui se instalan las dependencias. Esta etapa NO llega a la imagen final.
FROM node:20-slim AS build
WORKDIR /app

# Primero se copian solo los archivos de dependencias (asi Docker guarda esta capa)
COPY package.json package-lock.json ./
# Instala solo lo necesario para produccion
RUN npm ci --omit=dev

# Luego se copia el codigo
COPY src/ ./src/

# ---------- Etapa 2: la imagen final ----------
# Imagen "distroless": sin shell ni herramientas extra, mas liviana y segura
FROM gcr.io/distroless/nodejs20-debian12:nonroot
WORKDIR /app

# Se copia solo lo que hace falta desde la etapa 1
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/src ./src

# Corre como usuario normal (no administrador)
USER nonroot

ENV NODE_ENV=production
EXPOSE 8080

# Esta imagen ya sabe ejecutar "node", solo le decimos que archivo abrir
CMD ["src/server.js"]
