.PHONY: help up rebuild down restart logs clean psql test migrate reset seed mc env-check env-copy-api env-copy-admin env-copy-shop mc ms mt mr curl curl-all
.DEFAULT_GOAL := help

# Proje adı
PROJECT_NAME=ttpanel
SERVICES = api admin shop mailpit pgweb minio traefik

# Ortam ve path
ENV_FILE ?= .env
ENV_PATH=config/env
ENV_API=$(ENV_PATH)/.env.api
ENV ?= dev

# Compose komutu
ifeq ($(ENV),prod)
  DC = docker compose -f docker-compose.prod.yml
else
  DC = docker compose -f docker-compose.yml
endif


up: ## ⬆️ Projeyi başlat #core
	@$(DC) up -d

rebuild: ## 🔁 Sistemi tam temizle, yeniden build et ve başlat #core
	@echo "🧹 Docker temizlik işlemleri başlatılıyor..."
	@docker compose -f docker-compose.yml down -v --remove-orphans
	@docker volume prune -f
	@docker network prune -f
	@echo "⚙️ Ana proje build ediliyor..."
	@$(DC) build --no-cache
	@$(DC) up -d
	@echo "✅ Tüm servisler yeniden başlatıldı."

down: ## 🔻 Uygulamayı durdur #core
	@$(DC) down

restart: ## 🔁 Yeniden başlat #core
	@$(MAKE) clean
	@$(MAKE) up

logs: ## 🔍 Logları izle #core
	@$(DC) logs -f --tail=100


clean: ## 🧼 Volume + ağ temizliği #core
	@$(DC) down -v --remove-orphans
	@docker volume prune -f
	@docker network prune -f

docker-clean: ## 🧨 Docker sistemini tamamen sıfırla (tüm container, image, volume vs.) #core
	@echo "🧨 Docker sistemi tamamen temizleniyor..."
	@docker stop $$(docker ps -aq) || true
	@docker rm -f $$(docker ps -aq) || true
	@docker rmi -f $$(docker images -aq) || true
	@docker volume rm -f $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls | grep -v 'bridge\|host\|none' | awk '{print $$1}') || true
	@docker system prune -a --volumes -f

psql: ## 🐘 PostgreSQL'e bağlan #db
	@$(DC) exec postgres psql -U postgres -d ttpanel

test: ## 🧪 API test çalıştır #test
	@$(DC) exec api npm run test

migrate: ## 🔄 Prisma migrate (Docker içinden, doğru schema yoluyla) #db
	$(DC) exec api env $(shell grep -v '^#' $(ENV_API) | xargs) npx prisma migrate dev --name init --schema=prisma/schema.prisma

reset: ## 🧨 Veritabanını sıfırla ve tüm migration'ları yeniden uygula #db
	$(DC) exec api env $(shell grep -v '^#' $(ENV_API) | xargs) npx prisma migrate reset --schema=prisma/schema.prisma --force

seed: ## 🌱 Prisma seed (Docker içinden, doğru schema yoluyla) #db
	$(DC) exec api env $(shell grep -v '^#' $(ENV_API) | xargs) npx prisma db seed --schema=prisma/schema.prisma

env-check: ## 🔍 Ortam değişkeni kontrolü #env
	@echo "🔎 Aktif .env dosyası içeriği:"
	@cat $(ENV_API)

env-copy-api: ## 🟢 API için .env dosyasını kopyala #env
	@echo "→ API için .env dosyası kopyalanıyor..."
	cp config/env/.env.api apps/api/.env

env-copy-admin: ## 🟢 Admin için .env dosyasını kopyala #env
	@echo "→ Admin için .env dosyası kopyalanıyor..."
	cp config/env/.env.admin apps/admin/.env

env-copy-shop: ## 🟢 Shop için .env dosyasını kopyala #env
	@echo "→ Shop için .env dosyası kopyalanıyor..."
	cp config/env/.env.shop apps/shop/.env

mc: ## 🧱 Kısayol: Modül oluştur (örn: make mc system/access/role) #scripts
	@pnpm tsx scripts/module-create.ts $$(echo $(MAKECMDGOALS) | cut -d' ' -f2-)

ms: ## 🌱 Belirli modül için seed (örn: make ms system/access/role) #scripts
	@pnpm tsx scripts/module-seed.ts $$(echo $(MAKECMDGOALS) | cut -d' ' -f2-)


mt: ## 🧪 Belirli modül için test (örn: make mt system/access/role) #scripts
	@pnpm tsx scripts/module-test.ts $$(echo $(MAKECMDGOALS) | cut -d' ' -f2-)

mr: ## 🔗 AppModule'a modül ekle (örn: make mr system/access/role) #scripts
	pnpm tsx scripts/module-register.ts $$(echo $(MAKECMDGOALS) | cut -d' ' -f2-)


curl: ## 🔍 Belirli servise HTTP curl kontrolü (örn: make curl api) #control
	@SERVICE=$(word 2, $(MAKECMDGOALS)); \
	URL=http://$$SERVICE.ttpanel.test; \
	echo "🌐 Kontrol ediliyor: $$URL"; \
	curl -s -o /dev/null -w "↪️  HTTP Status: %{http_code}\n" $$URL

curl-all: ## 🌐 Tüm servislerin HTTP durumlarını kontrol et #control
	@echo "🕐 Zaman: $$(date '+%T')"
	@echo "📦 Container Durumları:"
	@echo "────────────────────────────────────────";
	@docker ps --format "table {{.Names}}\t{{.Status}}"
	@echo ""
	@echo "🌐 HTTP Servis Kontrolleri:"
	@echo "────────────────────────────────────────";
	@for s in $(SERVICES); do \
		printf "• %-7s → http://$$s.ttpanel.test\n" "$$s"; \
		curl -s -o /dev/null -w "↪️  HTTP Status: %{http_code}\n\n" http://$$s.ttpanel.test; \
	done

# Varsayılan hedefin dışında argümanları engelleme
%:
	@:

help: ## 👋 Yardım menüsü
	@echo ""
	@echo "TT Panel Makefile Komutları:"
	@echo "───────────────────────────────────────────────────"
	@awk -F':.*## ' '/^[a-zA-Z0-9_-]+:.*##/ { \
		printf "  \033[1;36m%-20s\033[0m →  %s\n", $$1, $$2 \
	}' $(MAKEFILE_LIST) | sort
