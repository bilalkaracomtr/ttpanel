.PHONY: help up down restart logs clean psql test migrate seed traefik mc env-check
.DEFAULT_GOAL := help

# Proje adı
PROJECT_NAME=ttpanel

# Ortam ve path
ENV_FILE ?= .env
ENV_PATH=config/env
ENV_API=$(ENV_PATH)/.env.api
TRAEFIK_PATH=../../services/traefik

# Compose komutu
DC=docker compose

## 🔄 Traefik servisi kontrol + başlat
traefik:
	@if ! docker ps --format '{{.Names}}' | grep -q '^traefik$$'; then \
		echo "🔁 Traefik servisi başlatılıyor..."; \
		cd $(TRAEFIK_PATH) && $(DC) up -d; \
	else \
		echo "✅ Traefik servisi zaten çalışıyor."; \
	fi

## ⬆️ Projeyi başlat (Traefik + Uygulamalar)
up: traefik
	@$(DC) up -d

## 🔻 Uygulamayı durdur
down:
	@$(DC) down

## 🔁 Yeniden başlat
restart:
	@$(MAKE) clean
	@cd $(TRAEFIK_PATH) && $(DC) down || true
	@$(MAKE) up

## 🔍 Logları izle
logs:
	@$(DC) logs -f --tail=100

## 🧼 Volume + ağ temizliği
clean:
	@$(DC) down -v --remove-orphans
	@docker volume prune -f
	@docker network prune -f

## 🐘 PostgreSQL'e bağlan
psql:
	@$(DC) exec postgres psql -U postgres -d ttpanel

## 🧪 API test çalıştır
test:
	@$(DC) exec api npm run test

## 🔄 Prisma migrate (Docker içinden, doğru schema yoluyla)
migrate:
	docker compose exec api env $(shell grep -v '^#' $(ENV_API) | xargs) npx prisma migrate dev --name init --schema=prisma/schema.prisma

## 🧨 Veritabanını sıfırla ve tüm migration'ları yeniden uygula
reset:
	docker compose exec api env $(shell grep -v '^#' $(ENV_API) | xargs) npx prisma migrate reset --schema=prisma/schema.prisma --force

## 🌱 Prisma seed (Docker içinden, doğru schema yoluyla)
seed:
	docker compose exec api env $(shell grep -v '^#' $(ENV_API) | xargs) npx prisma db seed --schema=prisma/schema.prisma

## 🔍 Ortam değişkeni kontrolü
env-check:
	@echo "🔎 Aktif .env dosyası içeriği:"
	@cat $(ENV_API)

## 🧱 Kısayol: Modül oluştur (örn: make mc system/access/role)
mc:
	@pnpm tsx scripts/module-create.ts $$(echo $(MAKECMDGOALS) | cut -d' ' -f2-)

## 🌱 Belirli modül için seed (örn: make ms system/access/role)
ms:
	@pnpm tsx scripts/module-seed.ts $$(echo $(MAKECMDGOALS) | cut -d' ' -f2-)

## 🧪 Belirli modül için test (örn: make mt system/access/role)
mt:
	@pnpm tsx scripts/module-test.ts $$(echo $(MAKECMDGOALS) | cut -d' ' -f2-)

# 🔗 AppModule'a modül ekle (örn: make mr system/access/role)
mr:
	pnpm tsx scripts/module-register.ts $$(echo $(MAKECMDGOALS) | cut -d' ' -f2-)

# Varsayılan hedefin dışında argümanları engelleme
%:
	@:

## 👋 Yardım menüsü
help:
	@echo ""
	@echo "TT Panel Makefile Komutları:"
	@echo "────────────────────────────────────────"
	@echo " make up                      → Traefik + TT Panel uygulamalarını başlat"
	@echo " make down                    → Uygulamaları durdur"
	@echo " make restart                 → Durdur + yeniden başlat"
	@echo " make logs                    → Logları izle"
	@echo " make clean                   → Volume + ağ temizliği"
	@echo " make psql                    → PostgreSQL terminali"
	@echo " make migrate                 → Prisma migration çalıştır (.env.api ile)"
	@echo " make reset                   → Veritabanını sıfırla ve tüm migration'ları yeniden uygula"
	@echo " make seed                    → Prisma seed çalıştır (.env.api ile)"
	@echo " make test                    → API testlerini çalıştır"
	@echo " make env-check               → .env.api içeriğini göster (kontrol amaçlı)"
	@echo " make mc system/access/role   → Yeni modül oluşturur"
	@echo " make ms system/access/role   → Belirli modülün seed dosyasını çalıştırır"
	@echo " make mt system/access/role   → Belirli modülün test klasörünü çalıştırır (Vitest)"
	@echo " make mr system/access/role   → AppModule'a modülü otomatik ekler"
	@echo ""
