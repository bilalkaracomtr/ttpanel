# ------------------------------------
# 🧱 Base Layer (Nuxt + pnpm)
# ------------------------------------
FROM node:22 AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN corepack enable && corepack prepare pnpm@10.15.0 --activate
RUN pnpm config set injectWorkspacePackages true

WORKDIR /build

COPY pnpm-lock.yaml package.json pnpm-workspace.yaml ./
COPY apps/shop ./apps/shop

# ------------------------------------
# 🏗️ Build Layer (install + build)
# ------------------------------------
FROM base AS build

WORKDIR /build

RUN pnpm install --filter=shop... --frozen-lockfile
RUN pnpm --filter=shop build

# ------------------------------------
# 🧪 Development Layer (Nuxt Dev Server)
# ------------------------------------
FROM base AS dev

COPY --from=build /build /app
WORKDIR /app/apps/shop
EXPOSE 3020

CMD ["pnpm", "dev"]

# ------------------------------------
# 🚀 Production Layer (start Nuxt server)
# ------------------------------------
FROM node:22 AS production

WORKDIR /app

COPY --from=build /build/apps/shop/.output ./.output
COPY --from=build /build/apps/shop/package.json ./
COPY --from=build /build/node_modules ./node_modules

ENV NODE_ENV=production
EXPOSE 3020

CMD ["node", ".output/server/index.mjs"]
