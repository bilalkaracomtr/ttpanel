# ------------------------------------
# 🧱 Base Layer (ortak ortam)
# ------------------------------------
FROM node:22 AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN corepack enable && corepack prepare pnpm@10.14.0 --activate
RUN pnpm config set injectWorkspacePackages true

WORKDIR /build

COPY pnpm-lock.yaml package.json pnpm-workspace.yaml ./
COPY apps/api ./apps/api

# ------------------------------------
# 🏗️ Build Layer (install + build + prisma)
# ------------------------------------
FROM base AS build

WORKDIR /build

RUN pnpm install --filter=api... --frozen-lockfile
RUN pnpm --filter=api build
RUN pnpm --filter=api exec prisma generate || echo "No Prisma client"

# ------------------------------------
# 🧪 Development Layer (watch + CLI)
# ------------------------------------
FROM base AS dev

COPY --from=build /build /app
WORKDIR /app/apps/api
EXPOSE 3000

CMD ["pnpm", "start:dev"]

# ------------------------------------
# 🚀 Production Layer (sadece çalıştırma)
# ------------------------------------
FROM base AS production

WORKDIR /app/apps/api

COPY --from=build /build/apps/api/package.json ./
COPY --from=build /build/apps/api/dist ./dist
COPY --from=build /build/node_modules /app/node_modules
COPY --from=build /build/apps/api/node_modules ./node_modules

ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "dist/main.js"]

