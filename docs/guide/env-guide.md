# 🌍 Ortam Dosyaları Rehberi (`.env.*`)

Bu dosya, TT Panel projesindeki farklı çalışma ortamlarının nasıl tanımlandığını ve kullanıldığını açıklar.

---

## 🔁 Ortam Türleri

| Ortam     | Amaç                             | Dosya                     | Açıklama                                       |
|-----------|----------------------------------|---------------------------|------------------------------------------------|
| dev       | Geliştirme ortamı                | `.env.api`                | Kod yazarken aktif olan ortam                  |
| test      | Otomatik test ortamı             | `.env.api.test`           | Test komutları (`make test`, CI/CD) için       |
| prod      | Canlı sistem (production)        | `.env.api.prod`           | Yayınlanan gerçek sistemin ortam dosyası       |

---

## 🗂️ Dosya Konumu

Tüm `.env.*` dosyaları şu klasörde tutulur:

```
config/env/
```

---

## 🧪 Örnek: Test Ortamı

`config/env/.env.api.test` içeriği:

```dotenv
NODE_ENV=test
APP_NAME=ttpanel-api-test
APP_PORT=3100

DATABASE_URL=postgresql://postgres:postgres@postgres:5432/ttpanel_test?schema=public
REDIS_HOST=redis
REDIS_PORT=6379
REDIS_PASSWORD=redis

JWT_SECRET=test-secret
JWT_EXPIRES_IN=60s
JWT_REFRESH_EXPIRES_IN=1h

SMTP_HOST=mailpit
SMTP_PORT=1025
```

---

## 🚀 Örnek: Production Ortamı

`config/env/.env.api.prod` içeriği:

```dotenv
NODE_ENV=production
APP_NAME=ttpanel-api
APP_PORT=3000

DATABASE_URL=postgresql://${PROD_DB_USER}:${PROD_DB_PASS}@prod-db:5432/ttpanel?schema=public
REDIS_HOST=prod-redis
REDIS_PORT=6379
REDIS_PASSWORD=${PROD_REDIS_PASSWORD}

JWT_SECRET=${PROD_JWT_SECRET}
JWT_EXPIRES_IN=3600s
JWT_REFRESH_EXPIRES_IN=7d

SMTP_HOST=smtp.sendgrid.net
SMTP_PORT=587
SMTP_USER=apikey
SMTP_PASS=${SENDGRID_API_KEY}
```

---

## 📦 Ortam Seçimi Ne Zaman Yapılır?

- Yerel geliştirme → `.env.api` (default)
- Test runner (örn: `make test`) → `.env.api.test`
- Gerçek deploy (CI/CD pipeline) → `.env.api.prod`

---

## ⚠️ Notlar

- Gerçek API anahtarları ve şifreler `.env.api.prod` içinde **değil**, dışarıdan verilir
- `NODE_ENV` değerine göre uygulama çalışma biçimi değişir (örnek: cache, log seviyesi)

---

## 🧠 Bonus: `Makefile` ortam desteği (opsiyonel)

```makefile
ENV_PATH=config/env
ENV_FILE ?= $(ENV_PATH)/.env.api

migrate:
	@docker compose --env-file $(ENV_FILE) exec api npx prisma migrate dev
```

Kullanım:
```bash
make migrate ENV_FILE=config/env/.env.api.test
```

---
