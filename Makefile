.PHONY: help up down restart logs clean psql test migrate seed traefik
.DEFAULT_GOAL := help

# Proje adı
PROJECT_NAME=ttpanel

# Ortam ve path
ENV_FILE ?= .env
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
	@$(MAKE) down
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

## 🔄 Prisma migrate + seed
migrate:
	@$(DC) exec api npx prisma migrate dev

seed:
	@$(DC) exec api npx prisma db seed

## 👋 Yardım menüsü
help:
	@echo ""
	@echo "TT Panel Makefile Komutları:"
	@echo "────────────────────────────────────────"
	@echo " make up        → Traefik + TT Panel uygulamalarını başlat"
	@echo " make down      → Uygulamaları durdur"
	@echo " make restart   → Durdur + yeniden başlat"
	@echo " make logs      → Logları izle"
	@echo " make clean     → Volume + ağ temizliği"
	@echo " make psql      → PostgreSQL terminali"
	@echo " make migrate   → Prisma migration çalıştır"
	@echo " make seed      → Prisma seed çalıştır"
	@echo " make test      → API testlerini çalıştır"
	@echo ""