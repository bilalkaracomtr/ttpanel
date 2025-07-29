# Base image
FROM node:22

WORKDIR /app

# 📁 Workspace config önce gelir
COPY ./pnpm-workspace.yaml ./
COPY ./package.json ./pnpm-lock.yaml ./
COPY ./apps/shop/package.json ./apps/shop/

# corepack ve pnpm kur
RUN corepack enable && corepack prepare pnpm@latest --activate \
    && pnpm install --frozen-lockfile

# Tüm dosyaları kopyala
COPY . .

# Shop uygulamasını build et (opsiyonel, Nuxt dev modda gerekmez)
RUN pnpm --filter shop build

# Geliştirme için port aç
EXPOSE 3002

# Çalıştırma komutu (development modu)
CMD ["pnpm", "--filter", "shop", "dev"]
