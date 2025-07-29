# Base image
FROM node:22

WORKDIR /app

# 📁 Workspace config önce gelir
COPY ./pnpm-workspace.yaml ./
COPY ./package.json ./pnpm-lock.yaml ./
COPY ./apps/admin/package.json ./apps/admin/

# corepack ve pnpm kur
RUN corepack enable && corepack prepare pnpm@latest --activate \
    && pnpm install --frozen-lockfile

# Tüm dosyaları kopyala
COPY . .

# Admin uygulamasını build et (opsiyonel, Nuxt dev modda gerekmez)
RUN pnpm --filter admin build

# Geliştirme için port aç
EXPOSE 3001

# Çalıştırma komutu (development modu)
CMD ["pnpm", "--filter", "admin", "dev"]
