# ---------- Etapa 1: dependencias ----------
FROM node:22-alpine AS deps

WORKDIR /app

# Copiamos solo el package.json desde src/
COPY src/package*.json ./
RUN npm install --omit=dev && mkdir -p node_modules

# ---------- Etapa 2: producción ----------
FROM node:22-alpine AS runner

WORKDIR /app

# Usuario no root por seguridad
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

ENV NODE_ENV=production
ENV PORT=3000

# Copiamos node_modules desde la etapa de deps
COPY --from=deps /app/node_modules ./node_modules

# Copiamos todo el contenido de src/ al workdir
COPY --chown=appuser:appgroup src/ ./

USER appuser

EXPOSE 3000

CMD ["node", "index.js"]