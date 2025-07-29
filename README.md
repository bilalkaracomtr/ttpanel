# 🧩 TT Panel

Modüler, API-first ve geliştirici dostu bir dijital yönetim paneli.
TT Panel; e-ticaret, içerik, üretim, finans ve entegrasyon süreçlerini tek noktadan yönetmek için tasarlanmış açık mimarili bir sistemdir.

---

## 🔧 Özellikler

- ✅ Modüler yapı (her işlev bağımsız modül)
- ✅ NestJS tabanlı API-first backend
- ✅ Nuxt 3 ile SSR destekli yönetim paneli
- ✅ Çok dilli destek, tema sistemi, JWT auth
- ✅ Traefik ile subdomain yönlendirme
- ✅ Terminal-first geliştirme (Makefile + Docker)

---

## 🧱 Kullanılan Teknolojiler

| Katman         | Teknoloji                         |
|----------------|-----------------------------------|
| Backend        | NestJS (TypeScript + Fastify)     |
| Frontend       | Nuxt 3 + Vue 3 + TailwindCSS      |
| Veritabanı     | PostgreSQL + Prisma ORM           |
| Depolama       | MinIO (S3 uyumlu)                 |
| Cache & Queue  | Redis + BullMQ                    |
| SMTP           | Mailpit (geliştirme ortamı)       |
| Test           | Vitest, Supertest, Cypress        |
| Geliştirme     | Docker, Makefile, .env yönetimi   |

---

## 🚀 Kurulum

### 1. Gerekli bağımlılıklar:

- Docker + Docker Compose
- Node.js (v18+)
- Git + SSH erişimi

### 2. .env dosyaları:

```bash
cp config/env/.env.example .env
cp config/env/.env.api.example .env.api
cp config/env/.env.admin.example .env.admin
cp config/env/.env.shop.example .env.shop
```

### 3. Servisleri başlat:

```bash
make up
```

## 🧪 Geliştirme Komutları

```makefile
make up         # Docker ortamını başlatır (-d)
make down       # Ortamı durdurur
make reset      # Tüm verileri siler ve yeniden başlatır
make logs       # Servis loglarını takip eder
make psql       # PostgreSQL terminal bağlantısı açar
make seed       # Başlangıç verilerini yükler (planlı)
```

---

## 📁 Proje Yapısı (özet)

```bash
apps/           → api, admin, shop uygulamaları
modules/        → tüm işlevsel modüller (commerce, system, content...)
services/       → postgres, redis, mailpit, minio gibi altyapılar
config/         → ortam dosyaları, docker betikleri, ssl
scripts/        → reset, seed, setup gibi terminal betikleri
tests/          → unit, integration, e2e test klasörleri
docs/           → geliştirme rehberleri ve GPT üretim dosyaları
```

---

## 📜 Lisans

Bu proje şu anda iç kullanım amaçlı geliştirilmektedir.
Açık kaynak lisanslama planı Faz 3 sonrasında belirlenecektir.
