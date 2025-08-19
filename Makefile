.PHONY: help up infra-up apps-up down clean restart logs rebuild docker-clean psql test generate migrate reset seed env-check env-copy mc ms mt mr curl curl-all
.DEFAULT_GOAL := help

# Proje adı
PROJECT_NAME=ttpanel
SERVICES = api admin shop mailpit pgweb minio traefik

# Ortam ve env dosyaları
ENV_PATH=config/env
ENV_TARGET ?= api
ENV_FILE=$(ENV_PATH)/.env.$(ENV_TARGET)

# Compose komutu
DC = docker compose

up: ## ⬆️ Projeyi başlat
	@$(DC) up -d
	@echo "🚀 Proje başlatıldı. Logları izlemek için 'make logs' komutunu kullanabilirsiniz."

infra-up: ## 🏗️ Sadece infra profilli servisleri başlat
	@$(DC) up -d traefik postgres pgweb redis minio mailpit

apps-up: ## 🖥️ Sadece apps profilli servisleri başlat
	@$(DC) up -d api admin shop

down: ## 🔻 Uygulamayı durdur #core
	@$(DC) down
	@echo "⏹️ Proje durduruldu."

clean: ## 🧼 Volume + ağ temizliği #core
	@$(DC) down -v --remove-orphans
	@docker volume prune -f
	@docker network prune -f
	@echo "🧼 Temizlik tamamlandı."

clean-%: ## 🧼 Belirli servisi temizle (örn: make clean-api) #core
	@$(DC) down $* -v --remove-orphans
	@echo "🧼 $* servisi temizlendi."

restart: ## 🔁 Temizleyip yeniden başlat
	@$(MAKE) clean
	@$(MAKE) up
	@echo "🔁 Proje yeniden başlatıldı."

logs: ## 🔍 Tüm servisin logunu izle (örn: make logs) #core
	@$(DC) logs -f --tail=100

logs-%: ## 🔍 Belirli servisin logunu izle (örn: make logs-api) #core
	@$(DC) logs -f --tail=100 $*

rebuild: ## 🔁 Temizle → Build --no-cache → Başlat #core
	@$(MAKE) clean
	@echo "⚙️ Ana proje build ediliyor..."
	@$(DC) build --no-cache
	@$(DC) up -d
	@echo "✅ Tüm servisler yeniden başlatıldı."

rebuild-%: ## 🔁 Belirli servisi temizle → Build --no-cache → Başlat (örn: make rebuild-api) #core
	@$(MAKE) clean-$*
	@echo "⚙️ $* servisi build ediliyor..."
	@$(DC) build $*
	@$(DC) up -d $*
	@echo "✅ $* servisi yeniden başlatıldı."

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
	pnpm --filter api run test

generate: ## 🧬 Prisma generate (sadece api)
	pnpm --filter api exec prisma generate

migrate:
	@name=$(word 2, $(MAKECMDGOALS)); \
	if [ -z "$$name" ]; then \
		echo "⛔ Lütfen bir migrate ismi verin: make migrate create_users"; \
		exit 1; \
	fi; \
	echo "🔄 Migrate başlatılıyor: $$name"; \
	pnpm --filter api exec prisma migrate dev --name $$name

reset: ## 🧨 Prisma reset (sadece api)
	pnpm --filter api exec prisma migrate reset --force

seed: ## 🌱 Prisma seed (sadece api)
	pnpm --filter api exec prisma db seed

env-check: ## 🔍 .env dosyasını göster (örn: make env-check admin) #env
	@target=$(word 2, $(MAKECMDGOALS)); \
	echo "🔎 Aktif .env dosyası: config/env/.env.$$target"; \
	cat config/env/.env.$$target

env-copy: ## 🟢 .env dosyasını apps klasörüne kopyala (örn: make env-copy admin) #env
	@target=$(word 2, $(MAKECMDGOALS)); \
	echo "→ $$target için .env dosyası kopyalanıyor..."; \
	cp config/env/.env.$$target apps/$$target/.env

mc: ## 🧱 Modül oluştur (örn: make mc system/access/role) #scripts
	@mod=$(word 2, $(MAKECMDGOALS)); \
	echo "🧱 Modül oluşturuluyor: $$mod"; \
	pnpm tsx scripts/module-create.ts $$mod

ms: ## 🌱 Modül seed (örn: make ms system/access/role) #scripts
	@mod=$(word 2, $(MAKECMDGOALS)); \
	echo "🌱 Modül seed ediliyor: $$mod"; \
	pnpm tsx scripts/module-seed.ts $$mod

mt: ## 🧪 Modül testlerini Jest ile çalıştır (örn: make mt system/access/role) #scripts
	@mod=$(word 2, $(MAKECMDGOALS)); \
	echo "🧪 Jest ile test ediliyor: $$mod"; \
	pnpm --filter api exec jest src/modules/$$mod/test --passWithNoTests

mr: ## 🔗 AppModule'a modül ekle (örn: make mr system/access/role) #scripts
	@mod=$(word 2, $(MAKECMDGOALS)); \
	echo "🔗 Modül ekleniyor: $$mod"; \
	pnpm tsx scripts/module-register.ts $$mod


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
