---
title: "TT Panel – Teknik Yapı"
description: "Projenin teknoloji yığını, mimari tercihleri ve klasör düzeni"
category: "Teknik"
tags: ["tech stack", "architecture", "dev environment", "dev flow"]
icon: "🛠️"
status: "active"
---

# 🛠️ Teknik Altyapı ve Geliştirme Kararları

Bu doküman, TT Panel projesinin teknik altyapısını, mimari tercihlerini ve klasör yapısını tanımlar.

Amacı:
- Modüler, sürdürülebilir ve test edilebilir bir yapı kurmak
- Takım içinde ortak teknik zemini oluşturmak
- Geliştirme sürecini sadeleştirmek ve mikroservis mimarisine hazırlık sağlamak

Kullanılan klasör düzeni, servis yapıları ve teknoloji tercihleri;
geliştirici deneyimi, ortam yönetimi, otomasyon ve ileri düzey entegrasyonlar gözetilerek planlanmıştır.

---

## 🧱 Temel Teknoloji Yığını (Tech Stack)

TT Panel projesinde kullanılan temel teknolojiler ve altyapı araçları aşağıda özetlenmiştir.  
Her satır, sistemin teknik bileşenini ve öğrenme durumunu temsil eder.

> 🟢: Kullanıma hâkim  
> 🟡: Temel düzeyde biliniyor  
> 🟠: Öğrenme sürecinde  
> 🔴: Henüz çalışılmadı / planlı

| Katman              | Teknoloji / Araç                            | Öğrenme Durumu            |
|---------------------|---------------------------------------------|---------------------------|
| Frontend            | Vue 3, Nuxt 3, Tailwind CSS                 | Vue: 🟢, Nuxt/TW: 🟡       |
| Backend             | NestJS (TypeScript + Fastify)               | JS: 🟢, Nest/TS: 🟠        |
| Veritabanı          | PostgreSQL                                  | SQL: 🟢                    |
| ORM                 | Prisma                                      | 🟡                         |
| Önbellek            | Redis                                       | 🟠                         |
| Kuyruk Sistemi      | BullMQ + Redis                              | 🔴                         |
| Depolama            | MinIO (S3 uyumlu)                           | 🔴                         |
| CI/CD               | GitHub Actions, Docker Compose              | Git: 🟡, Docker: 🟠        |
| Versiyonlama        | Git + GitHub (dev / staging / prod)         | 🟡                         |
| Ödeme Sistemleri    | Stripe, Iyzico, PayTR (modüler yapı)        | 🔴                         |
| Test Ortamı         | Vitest, Supertest, Cypress                  | 🟠                         |
| Ortam Yönetimi      | .env dosyaları, Makefile, script’ler        | 🟢                         |
| İzleme & Loglama    | Sentry (planlı), Logtail, Prometheus        | 🔴                         |
| Analytics           | Plausible, GA4                              | 🟠                         |
| Auth & Security     | JWT, Guard, Role, bcrypt, CSRF, CORS        | 🟠                         |
| Kod Kalitesi        | ESLint, Prettier                            | 🟢                         |
| Geliştirici Araçları| VSCode, Volar, Devtools, Docker CLI         | 🟢                         |
| Tema Sistemi        | Tailwind + Layout                           | 🟡                         |
| Çoklu Dil Desteği   | Nuxt i18n (admin/public)                    | 🔴                         |
| Görev Yönetimi      | Makefile, npm script, setup.ts              | 🟢                         |
| Analitik İzleme     | GA4, gtag.js, GTM, Facebook Pixel           | GA4: 🟢, Pixel: 🟢, GTM: ⚪️ |
| Sunucu Takibi       | Facebook CAPI, Conversion API endpoint      | CAPI: 🟡                   |
| Pazarlama Feed      | Google Merchant XML/JSON Feed               | Feed: 🟡                   |

---

## 🧩 Mimari Yaklaşım

TT Panel, kurumsal düzeyde e-ticaret ve otomasyon sistemleri üretmek üzere kurgulanmış,  
**gruplu modüler yapıya sahip**, mikroservise dönüşebilecek bir monorepo sistemidir.

---

### 🎯 Temel İlkeler

- **Monorepo mimarisi**  
  `apps/`, `modules/`, `services/` gibi ayrık klasör yapıları ile yönetilir.

- **Modüler monolit yapı**  
  Her iş alanı (`product`, `billing`, `crm`, `faq`) bağımsız modül olarak tanımlanır.  
  Sistem tek uygulama olarak çalışır ancak modüller gerektiğinde mikroservislere dönüştürülebilir.

- **Domain bazlı gruplama**  
  Modüller `modules/` altında `commerce/`, `content/`, `system/`, `automation/`, `integration/` gibi iş alanlarına göre gruplanır.

- **Katmanlı mimari**  
  Her modül; `controller → service → repository → prisma → database` akışını izler.

- **API-first yaklaşımı**  
  Tüm işlemler backend servisleri üzerinden yürütülür (REST tabanlı).

- **Tip güvenliği**  
  TypeScript, DTO ve Prisma ile uçtan uca tip doğruluğu sağlanır.

- **Modül içi standart yapı**  
  Her modül; `entity/`, `dto/`, `service/`, `controller/`, `tests/` dizinlerine sahiptir.

- **Çoklu frontend desteği**  
  `apps/admin`, `apps/public`, `apps/mobile` gibi arayüzler paralel çalışabilir.

- **Terminal-first geliştirme**  
  `Makefile`, `scripts/`, `docker-compose`, `.env.example` ile sade ve tekrar edilebilir kurulum sağlanır.

- **Çok kiracılı yapı (multi-tenant)**  
  Başlangıçta row-based tenant uygulanır; schema-based geçişe uygundur.

- **Tema ve marka özelleştirme**  
  Tailwind + layout sistemi ile admin arayüzü marka bazlı özelleştirilebilir.

- **Mikroservise uygunluk**  
  Modüller bireysel veya grup bazında servisleşmeye uygundur.  
  Örnekler:
  - `commerce/` grubu: `catalog/`, `order/`, `customer/`
  - Dış bağımlı modüller: `billing`, `crm`, `media`, `notification`

---

Bu yapı sayesinde hem **tek uygulama gibi çalışan** hem de  
**bağımsız servisleşmeye hazır** bir sistem mimarisi kurulmuştur.

---

## 📂 Proje Klasör Yapısı ve Yapısal Organizasyon

TT Panel projesi, modüler, çok katmanlı ve servis uyumlu bir mimariye sahiptir.  
Aşağıdaki klasör yapısı, bu mimarinin fiziksel organizasyonunu ve geliştirme disiplinini yansıtır.

---

### 📁 Klasör Ağacı

```bash
├── .vscode
│   ├── extensions.json
│   └── settings.json
├── apps
│   ├── admin
│   │   └── .gitkeep
│   ├── api
│   │   └── .gitkeep
│   ├── mobile
│   │   └── .gitkeep
│   └── public
│       └── .gitkeep
├── config
│   ├── ci
│   │   └── .gitkeep
│   ├── docker
│   │   ├── admin
│   │   │   └── Dockerfile
│   │   ├── api
│   │   │   └── Dockerfile
│   │   ├── mailpit
│   │   │   └── .gitkeep
│   │   ├── postgres
│   │   │   └── .gitkeep
│   │   ├── public
│   │   │   └── Dockerfile
│   │   ├── redis
│   │   │   └── .gitkeep
│   │   └── traefik
│   │       └── .gitkeep
│   ├── env
│   │   ├── .env.admin.example
│   │   ├── .env.api.example
│   │   ├── .env.example
│   │   ├── .env.mailpit.example
│   │   ├── .env.minio.example
│   │   ├── .env.postgres.example
│   │   ├── .env.public.example
│   │   ├── .env.redis.example
│   │   ├── .env.staging
│   │   └── .env.test
│   ├── ssl
│   │   └── .gitkeep
│   └── system
│       └── .gitkeep
├── docs
│   ├── dev
│   │   └── .gitkeep
│   ├── gpt
│   │   ├── guide
│   │   │   ├── copilot-guide.md
│   │   │   ├── git-strategy.md
│   │   │   ├── production-guide.md
│   │   │   └── vscode-setup-guide.md
│   │   ├── sessions
│   │   │   ├── 2025-07-02.md
│   │   │   ├── 2025-07-14.md
│   │   │   ├── 2025-07-15.md
│   │   │   ├── 2025-07-16.md
│   │   │   └── 2025-07-17.md
│   │   └── system
│   │       ├── 01-beginning.md
│   │       ├── 02-goals.md
│   │       ├── 03-modules.md
│   │       ├── 04-tech.md
│   │       ├── 05-roadmap.md
│   │       ├── gpt-file-format.md
│   │       ├── gpt-identity.yaml
│   │       ├── memory-system.yaml
│   │       ├── memory-workspace.yaml
│   │       └── memory.yaml
│   └── manual
│       └── .gitkeep
├── modules
│   ├── automation
│   │   ├── accounting
│   │   │   └── .gitkeep
│   │   ├── bank
│   │   │   └── .gitkeep
│   │   ├── billing
│   │   │   └── .gitkeep
│   │   ├── calendar
│   │   │   └── .gitkeep
│   │   ├── cash
│   │   │   └── .gitkeep
│   │   ├── checklist
│   │   │   └── .gitkeep
│   │   ├── crm
│   │   │   └── .gitkeep
│   │   ├── expense
│   │   │   └── .gitkeep
│   │   ├── follow-up
│   │   │   └── .gitkeep
│   │   ├── insight
│   │   │   └── .gitkeep
│   │   ├── message
│   │   │   └── .gitkeep
│   │   ├── production
│   │   │   └── .gitkeep
│   │   ├── reminder
│   │   │   └── .gitkeep
│   │   ├── schedule
│   │   │   └── .gitkeep
│   │   ├── task
│   │   │   └── .gitkeep
│   │   ├── ticket
│   │   │   └── .gitkeep
│   │   └── workflow
│   │       └── .gitkeep
│   ├── commerce
│   │   ├── catalog
│   │   │   ├── attribute
│   │   │   │   └── .gitkeep
│   │   │   ├── brand
│   │   │   │   └── .gitkeep
│   │   │   ├── category
│   │   │   │   └── .gitkeep
│   │   │   ├── file
│   │   │   │   └── .gitkeep
│   │   │   ├── product
│   │   │   │   ├── controller
│   │   │   │   │   └── .gitkeep
│   │   │   │   ├── dto
│   │   │   │   │   └── .gitkeep
│   │   │   │   ├── entity
│   │   │   │   │   └── .gitkeep
│   │   │   │   ├── repository
│   │   │   │   │   └── .gitkeep
│   │   │   │   ├── service
│   │   │   │   │   └── .gitkeep
│   │   │   │   ├── tests
│   │   │   │   │   └── .gitkeep
│   │   │   │   └── module.ts
│   │   │   ├── stock
│   │   │   │   └── .gitkeep
│   │   │   ├── supplier
│   │   │   │   └── .gitkeep
│   │   │   └── variant
│   │   │       └── .gitkeep
│   │   ├── customer
│   │   │   ├── activity
│   │   │   │   └── .gitkeep
│   │   │   ├── address
│   │   │   │   └── .gitkeep
│   │   │   ├── consent
│   │   │   │   └── .gitkeep
│   │   │   ├── contact
│   │   │   │   └── .gitkeep
│   │   │   ├── customer
│   │   │   │   └── .gitkeep
│   │   │   ├── group
│   │   │   │   └── .gitkeep
│   │   │   ├── login-history
│   │   │   │   └── .gitkeep
│   │   │   ├── notification
│   │   │   │   └── .gitkeep
│   │   │   ├── point
│   │   │   │   └── .gitkeep
│   │   │   ├── return-request
│   │   │   │   └── .gitkeep
│   │   │   ├── review
│   │   │   │   └── .gitkeep
│   │   │   └── wishlist
│   │   │       └── .gitkeep
│   │   ├── marketing
│   │   │   ├── analytics
│   │   │   │   └── .gitkeep
│   │   │   ├── banner
│   │   │   │   └── .gitkeep
│   │   │   ├── campaign
│   │   │   │   └── .gitkeep
│   │   │   ├── conversion
│   │   │   │   └── .gitkeep
│   │   │   ├── coupon
│   │   │   │   └── .gitkeep
│   │   │   ├── event
│   │   │   │   └── .gitkeep
│   │   │   ├── merchant
│   │   │   │   └── .gitkeep
│   │   │   ├── popup
│   │   │   │   └── .gitkeep
│   │   │   ├── promotion
│   │   │   │   └── .gitkeep
│   │   │   ├── referral
│   │   │   │   └── .gitkeep
│   │   │   ├── seo
│   │   │   │   └── .gitkeep
│   │   │   └── utm
│   │   │       └── .gitkeep
│   │   └── order
│   │       ├── cart
│   │       │   └── .gitkeep
│   │       ├── history
│   │       │   └── .gitkeep
│   │       ├── invoice
│   │       │   └── .gitkeep
│   │       ├── note
│   │       │   └── .gitkeep
│   │       ├── order
│   │       │   └── .gitkeep
│   │       ├── payment
│   │       │   └── .gitkeep
│   │       ├── return
│   │       │   └── .gitkeep
│   │       ├── shipment
│   │       │   └── .gitkeep
│   │       ├── status
│   │       │   └── .gitkeep
│   │       └── transaction
│   │           └── .gitkeep
│   ├── content
│   │   ├── banner
│   │   │   └── .gitkeep
│   │   ├── blog
│   │   │   └── .gitkeep
│   │   ├── faq
│   │   │   └── .gitkeep
│   │   ├── form
│   │   │   └── .gitkeep
│   │   ├── media
│   │   │   └── .gitkeep
│   │   ├── page
│   │   │   └── .gitkeep
│   │   ├── portfolio
│   │   │   └── .gitkeep
│   │   ├── section
│   │   │   └── .gitkeep
│   │   ├── slider
│   │   │   └── .gitkeep
│   │   ├── testimonial
│   │   │   └── .gitkeep
│   │   └── video
│   │       └── .gitkeep
│   ├── integration
│   │   ├── amazon
│   │   │   └── .gitkeep
│   │   ├── api-client
│   │   │   └── .gitkeep
│   │   ├── api-provider
│   │   │   └── .gitkeep
│   │   ├── aras
│   │   │   └── .gitkeep
│   │   ├── e-invoice
│   │   │   └── .gitkeep
│   │   ├── etsy
│   │   │   └── .gitkeep
│   │   ├── logo
│   │   │   └── .gitkeep
│   │   ├── mikro
│   │   │   └── .gitkeep
│   │   ├── parasut
│   │   │   └── .gitkeep
│   │   ├── ship-integrator
│   │   │   └── .gitkeep
│   │   ├── slack
│   │   │   └── .gitkeep
│   │   ├── sms
│   │   │   └── .gitkeep
│   │   ├── smtp
│   │   │   └── .gitkeep
│   │   ├── webhook
│   │   │   └── .gitkeep
│   │   ├── whatsapp
│   │   │   └── .gitkeep
│   │   └── yurtici
│   │       └── .gitkeep
│   └── system
│       ├── access
│       │   ├── auth
│       │   │   └── .gitkeep
│       │   ├── permission
│       │   │   └── .gitkeep
│       │   ├── role
│       │   │   └── .gitkeep
│       │   ├── token
│       │   │   └── .gitkeep
│       │   └── user
│       │       └── .gitkeep
│       ├── config
│       │   ├── config
│       │   │   └── .gitkeep
│       │   ├── language
│       │   │   └── .gitkeep
│       │   ├── maintenance
│       │   │   └── .gitkeep
│       │   ├── settings
│       │   │   └── .gitkeep
│       │   └── theme
│       │       └── .gitkeep
│       ├── log
│       │   └── .gitkeep
│       ├── notify
│       │   ├── announcement
│       │   │   └── .gitkeep
│       │   ├── changelog
│       │   │   └── .gitkeep
│       │   └── notification
│       │       └── .gitkeep
│       └── profile
│           └── .gitkeep
├── packages
│   ├── eslint-config
│   │   └── .gitkeep
│   ├── tsconfig
│   │   └── .gitkeep
│   └── ui
│       └── .gitkeep
├── scripts
│   └── .gitkeep
├── services
│   ├── mailpit
│   │   └── .gitkeep
│   ├── minio
│   │   └── .gitkeep
│   ├── postgres
│   │   └── data
│   │       └── .gitkeep
│   ├── redis
│   │   └── data
│   │       └── .gitkeep
│   └── worker
│       └── .gitkeep
├── tests
│   ├── e2e
│   │   └── .gitkeep
│   ├── integration
│   │   └── .gitkeep
│   └── unit
│       └── .gitkeep
├── .env
├── .env.admin
├── .env.api
├── .env.mailpit
├── .env.minio
├── .env.postgres
├── .env.public
├── .env.redis
├── .gitignore
├── CHANGELOG.md
├── LICENSE
├── Makefile
├── README.md
└── docker-compose.yml
```

---

### 📘 Klasör Açıklamaları

Her klasör, projenin yapısal mimarisinde belirli bir sorumluluğu üstlenir.  
Bu bölümde, kök dizindeki ana klasörlerin görev ve kapsamları açıklanır.

---

#### `apps/` – Uygulama Katmanı

Bu klasör, projedeki her bir istemci ya da arayüz uygulamasını içerir.  
Her uygulama kendi bağımsız giriş noktasıdır ve `modules/` altındaki iş mantığını kullanır.

- `api/` → NestJS ile geliştirilmiş REST API uygulamasıdır.  
- `admin/` → Nuxt 3 tabanlı yönetici panelidir (SSG + SSR destekli).  
- `public/` → Son kullanıcıya açık e-ticaret arayüzüdür.  
- `mobile/` → Opsiyonel olarak Flutter veya Expo tabanlı mobil istemcidir.

Bu yapı sayesinde frontend–backend ayrımı netleştirilmiş ve çoklu arayüz desteği sağlanmıştır.

---

#### `modules/` – İş Modülleri

Sistemin tüm iş mantığı bu klasörde domain gruplarına bölünmüş şekilde yer alır.  
Her bir grup, kendi alt modüllerini içerir ve bağımsız geliştirmeye uygundur.  
Tüm modüller `apps/api` tarafından kullanılmak üzere export edilir.

- `commerce/` → Ürün, sipariş, müşteri, pazarlama gibi e-ticaret modülleri  
- `automation/` → Görev yönetimi, üretim, CRM gibi operasyonel süreçler  
- `system/` → Yetkilendirme, ayarlar, bildirimler gibi çekirdek sistem bileşenleri  
- `integration/` → Mikro, Logo, SMS, kargo gibi dış servis entegrasyonları  
- `content/` → Blog, sayfa, slider gibi içerik sunum bileşenleri

Her modül, kendi içinde standart dizin yapısını takip eder:  
`controller/`, `service/`, `repository/`, `dto/`, `entity/`, `tests/`, `module.ts`

Bu yapı DDD (Domain Driven Design) yaklaşımına yakın, modüler monolit mimariye uygundur.

---

#### `services/` – Altyapı Servisleri

Projenin dış bağımlılıklarını (database, cache, mail, storage vb.) içeren servis yapılandırmaları bu klasörde yer alır.  
Her klasör, genellikle bir Docker konteynerine karşılık gelir ve `docker-compose.yml` ile entegre çalışır.

- `postgres/` → PostgreSQL veritabanı ve ilgili init dosyaları  
- `redis/` → Redis sunucusu (BullMQ kuyruk sistemiyle birlikte kullanılır)  
- `mailpit/` → Geliştirme ortamı için SMTP test ve mail önizleme servisi  
- `minio/` → S3 uyumlu dosya depolama sunucusu  
- `worker/` → Kuyruk işleyicisi (Redis + BullMQ üzerinden arka plan görevleri)

Bu yapı, servislerin koddan bağımsız ve izole biçimde yönetilmesini sağlar.

---

#### `packages/` – Paylaşılan Paketler

Bu klasör, frontend ve backend uygulamaları arasında ortak kullanılan yapıların merkezi olarak tutulduğu yerdir.  
Her alt klasör kendi içinde bağımsız bir paket gibi yapılandırılır ve diğer uygulamalarda import edilerek kullanılır.

- `ui/` → Vue/Nuxt bileşenleri (buton, form elemanları, layout’lar, temalar vb.)  
- `tsconfig/` → Ortak TypeScript yapılandırması  
- `eslint-config/` → Kod kalite kurallarının merkezi yönetimi

Bu yapı, tekrar eden kodları ortadan kaldırır, stil ve işleyiş bütünlüğü sağlar.

---

#### `config/` – Ortam ve Sistem Yapılandırmaları

Projenin çalışma ortamlarına, servis tanımlarına ve sistem ayarlarına dair tüm konfigürasyon dosyaları bu klasörde toplanır.  
Koddan bağımsız tutularak ortam geçişlerini kolaylaştırır ve altyapı kontrolünü merkezileştirir.

- `docker/` → Her servis için Dockerfile ve yapılandırma betikleri  
- `env/` → Uygulamalara özel `.env.example` dosyaları (admin, api, public...)  
- `ssl/` → Yerel geliştirme için kendi imzalanmış SSL sertifikaları (opsiyonel)  
- `system/` → Sabit JSON/YAML sistem konfigürasyonları (örnek: ülkeler, para birimleri, ayarlar)  
- `ci/` → (boş) Gelecekte CI/CD senaryoları için yer ayrılmıştır

Bu klasör, proje altyapısının sürdürülebilirliğini ve tekrarlanabilir kurulumunu garanti altına alır.

---

#### `tests/` – Test Altyapısı

Projedeki test senaryoları modüllerden bağımsız olarak bu klasörde organize edilir.  
Amaç, testlerin ayrı katmanlarda tutulması ve test stratejilerinin daha net uygulanabilmesidir.

- `unit/` → Birim testleri (her modülün servis, helper veya mantıksal parçaları için)  
- `integration/` → Modüller arası veri ve iş akışı testleri  
- `e2e/` → Uygulama düzeyinde uçtan uca testler (Cypress, Playwright, vs.)

Bu yapı sayesinde testlerin türüne göre ayrıştırılması sağlanır, CI/CD süreçlerine daha kolay entegre edilir.

---

#### `scripts/`, `Makefile`, `.env.example` – Yardımcı Geliştirici Araçları

Bu klasör ve dosyalar, geliştirici deneyimini kolaylaştırmak ve tekrar edilebilir kurulumlar sağlamak için yapılandırılmıştır.

- `scripts/` → Otomasyon komutları, kurulum ve bakım betikleri  
- `Makefile` → CLI üzerinden çağrılabilen görev tanımları (`make dev`, `make reset-db` gibi)  
- `.env.example` → Ortam değişkenleri için şablon dosya (onboarding sürecini kolaylaştırır)

---

#### `docs/` – Teknik Belgeler ve GPT Destekli Üretim Sistemi

Bu klasör, hem geliştirici belgelerini hem de GPT destekli üretim sistemini içerir.  
Kod barındırmaz; ancak tüm mimari kararlar, faz planları, modül şemaları ve proje hafızası burada tutulur.  
Belgeler, kullanım amacına göre alt klasörlerde organize edilmiştir:

- `manual/` → Panel, modül, servis gibi sistem bölümlerine dair geliştirici belgeleri  
- `dev/` → Ortam kurulumu, yerel geliştirme ve CLI komutlarına dair açıklamalar  
- `gpt/` → GPT'nin üretim sürecine katıldığı tüm kontrol dosyaları ve içerikler:

    - `01-beginning.md`  → Başlangıç süreci, planlama, benchmark sistemleri ve öğrenme süreci
    - `02-goals.md` → Projenin hedefleri, vizyonu ve başarı ölçütleri  
    - `03-modules.md` → Modül organizasyonu, gruplama, API-first yaklaşım  
    - `04-tech.md` → Kullanılan teknolojiler, mimari tercih ve klasör düzeni  
    - `05-roadmap.md` → Faz/sprint planlaması ve üretim stratejisi 
    - `gpt-identity.yaml` → GPT'nin yetkileri ve davranış modeli  
    - `memory.yaml` → Sprint/faz geçmişi, proje hafızası  
    - `memory-system.yaml` → Kişisel sistem bilgisi (versiyonlamaya dahil edilmez)
    - `memory-workspace.yaml` → Yerel geliştirme ortamı, servis yapılandırmaları, proje yolları ve makefile tanımları 
    - `gpt-file-format.md` → Markdown biçim ve başlık standartları  

    Bu klasör:
    - Kod içermez ama tüm teknik üretim mantığını taşır  
    - Planlama, sprint, modülleme ve mimari kararların arşividir  
    - Versiyon kontrolüne alınmalı; yalnızca kişisel içerikler dışlanmalıdır (`memory-system.yaml` gibi)

Bu yapı sayesinde, teknik planlama ve üretim süreçleri merkezi ve takip edilebilir biçimde yönetilir.

---

## 🔐 Güvenlik ve Yetkilendirme

TT Panel’de hedef; geliştirici deneyimini bozmadan, güvenli ve ölçeklenebilir bir yapı kurmaktır.

- JWT tabanlı oturum ve erişim yönetimi  
- Rol ve izin bazlı yetkilendirme (örn. `role`, `permission` modülleri)  
- CSRF, XSS, CORS gibi güvenlik önlemleri Nuxt ve NestJS içinde yönetilir  
- API rate limit ve brute force önleme sistemleri (planlı)  
- Şifreli tüm veriler `bcrypt` ile saklanır  
- Ortam değişkenleri (`.env`) ile hassas veriler izole edilir  
- NestJS `Guard` ve `Strategy` yapılarıyla modül bazlı erişim kontrolü  
- Refresh token yönetimi ve oturum süresi kontrolü (planlı)  
- Gelişmiş loglama ve yetkisiz erişim takibi `log` ve `notify` sistemleriyle entegre edilebilir

---

## 🧪 Test ve Kalite Süreci

Test altyapısı Faz 2'de aktif hâle getirilecektir.  
Amaç; modül bazlı, ortam izole ve CI destekli bir test sistemi kurmaktır.

- **Unit test** → `Vitest` ile servis/metot odaklı  
- **Integration test** → `Supertest` ile API uçlarının doğrulanması  
- **UI test** → `Cypress` ile panel ve kullanıcı arayüz davranışları  
- **Test verisi üretimi** → `factory`, `seed`, `mock` destekli yapı  
- **CI entegrasyonu** → `npm run test` komutu GitHub Actions ile tetiklenir  
- **Ortam ayrımı** → `.env.test` dosyası ile izole test ortamı oluşturulur  
- **Kod kalitesi** → `ESLint` + `Prettier` ile otomatik kontrol ve biçimlendirme  
- **Coverage & commit hook** → Test coverage takibi ve commit öncesi kontroller (`husky`, `lint-staged`, planlı)

---

## 🧭 Yerel Geliştirme Dizini: `devroot/`

`/Volumes/Workspace/devroot`, TT Panel ve diğer projelerin bulunduğu ana geliştirme dizinidir.  
Tüm üretim süreci bu kök dizin altında organize edilir.

| Klasör        | Açıklama |
|---------------|----------|
| `projects/`   | TT Panel gibi aktif projelerin bulunduğu ana klasördür. Her proje kendi içinde `apps/`, `modules/`, `services/` gibi yapılara ayrılır. |
| `sandbox/`    | Açık kaynaklı e-ticaret çözümlerinin test ve benchmark amacıyla kurulduğu deneme alanıdır. |
| `services/`   | Traefik gibi ortak altyapı servislerinin Docker yapılandırmaları burada tutulur. İzole çalışmaya uygundur. |

> Bu yapı sayesinde projeler, test ortamları ve altyapı servisleri ayrı ama birlikte çalışabilir şekilde organize edilir.

---

## 🐳 Geliştirme Ortamı

Kod yazımı, test ve modül entegrasyonlarını kolaylaştırmak için **Docker tabanlı, izole bir geliştirme ortamı** kurgulanmıştır.  
Amaç; her geliştiricinin tek komutla tüm servisleri ayağa kaldırabileceği, sade ama genişletilebilir bir yapı sunmaktır.

---

### 📦 Kullanılan Docker Servisleri

| Servis       | Açıklama                                      | Subdomain               |
|--------------|-----------------------------------------------|--------------------------|
| **api**      | NestJS backend (`apps/api`)                   | `api.ttpanel.local`      |
| **admin**    | Nuxt 3 admin panel (`apps/admin`)             | `admin.ttpanel.local`    |
| **public**   | Nuxt 3 ziyaretçi arayüzü (`apps/public`)      | `public.ttpanel.local`   |
| **postgres** | PostgreSQL veritabanı                         | –                        |
| **pgweb**    | PostgreSQL UI arayüzü                         | `db.ttpanel.local`       |
| **redis**    | BullMQ kuyruğu ve cache yönetimi              | –                        |
| **minio**    | S3 uyumlu dosya servisi (görsel yükleme)      | `minio.ttpanel.local`    |
| **mailpit**  | E-posta test sistemi                          | `mail.ttpanel.local`     |
| **traefik**  | Reverse proxy + subdomain yönlendirme         | `traefik.ttpanel.local`  |

> Subdomain yönlendirmeleri `traefik` container’ı üzerinden yapılır.  
> Geliştirici makinesinde `/etc/hosts` dosyasına uygun domain tanımları yapılmalıdır.  
> Her servis `.env` dosyaları ile izole edilebilir yapıdadır.

---

### 📂 Docker Dosya Yapısı

Dockerfile’lar ve servis bazlı betikler `config/docker/` altında gruplanmıştır.  
Her servis kendi klasöründe izole edilmiştir.

```bash
config/
└── docker/
    ├── api/                 # NestJS için Dockerfile
    ├── admin/               # Nuxt 3 admin panel
    ├── public/              # Ziyaretçi arayüzü
    ├── postgres/
    │   └── init.sql         # İlk kullanıcı ve tablo yapısı
    ├── minio/
    │   └── create-buckets.sh
    ├── mailpit/
    └── pgweb/
```

---

### 📐 docker-compose Standartları

TT Panel geliştirme ortamında `docker-compose.yml` dosyaları oluşturulurken aşağıdaki teknik kurallara uyulur:

- `version:` alanı **kullanılmaz** → Docker Compose otomatik sürüm ile çalışır  
- `volumes:` üst düzeyde tanımlanmaz, her servis altında (`services.<name>.volumes`) tanımlanır  
- `networks.traefik.external: true` olarak ayarlanır → Hazır kurulu global `traefik` ağı kullanılır  
- `networks.ttpanel.name: ttpanel` ve `driver: bridge` olarak tanımlanır → İç ağ için yerel network

> Bu kurallar, `docker-compose` yapı dosyalarında sadelik, izolasyon ve uyumluluk sağlamak için zorunludur.

---

### ⚙️ Ortam Yapılandırması

- Tüm servisler Docker + Docker Compose ile konteynerize edilir  
- Ortam dosyaları: `.env`, `.env.staging`, `.env.test`, `.env.local`  
- Her servis için ayrı `.env` dosyası yazılabilir (`.env.api`, `.env.admin` vb.)  
- Ortam değişkenleri, merkezi `docker-compose.yml` üzerinden servis içine inject edilir  
- SMTP testi için `mailpit`, veritabanı arayüzü için `pgweb` kullanılır  
- Her servis kendi `Dockerfile` dosyasıyla inşa edilir (monorepo uyumlu yapı)  
- Geliştiriciye özel yapılandırmalar `.env.local` üzerinden yapılabilir  
- Geliştirme imajları `dev.Dockerfile` gibi özel tanımlarla ayrıştırılabilir (planlı)

---

### 🛠️ Makefile Komutları (planlanan)

| Komut             | Açıklama                                                |
|-------------------|---------------------------------------------------------|
| `make up`         | Tüm ortamı başlatır (`docker-compose up -d`)            |
| `make down`       | Tüm ortamı durdurur                                     |
| `make logs api`   | Yalnızca `api` servisinin loglarını gösterir            |
| `make psql`       | PostgreSQL veritabanına CLI erişimi sağlar              |
| `make seed`       | Başlangıç verilerini yükler (`prisma db seed` vb.)      |
| `make reset`      | Tüm verileri sıfırlar ve ortamı yeniden başlatır        |

---

### 🌐 /etc/hosts Örneği

```txt
127.0.0.1 api.ttpanel.local
127.0.0.1 admin.ttpanel.local
127.0.0.1 public.ttpanel.local
127.0.0.1 minio.ttpanel.local
127.0.0.1 mail.ttpanel.local
127.0.0.1 db.ttpanel.local
```

---

### 🧠 Geliştirme Yaklaşımı

- Servisler sade, izole ve bağımsız çalışacak şekilde yapılandırılmıştır  
- Tüm trafik `traefik` üzerinden yönlendirilir  
- Admin paneli, API ve veritabanı doğrudan test edilebilir  
- MinIO, Redis ve Mailpit gibi bağımlı servisler otomatik olarak başlatılır  
- Hot reload ve sade terminal logları ile geliştirme akışı hızlandırılmıştır  
- Prettier ve ESLint entegrasyonu ile kod kalitesi otomatik korunur  
- `package.json` script’leri ve `Makefile` birlikte terminal-first geliştirme alışkanlığı destekler

---

## 📘 Öğrenme Sıralaması (Önerilen Akış)

Aşağıdaki sıra, hem TT Panel’in teknik önceliklerine hem de mevcut bilgi seviyene göre önerilmiştir:

1. ✅ **Vue 3 → Nuxt 3 → Tailwind CSS**  
   _Bootstrap deneyimin sayesinde hızlı adapte olunabilir._  

2. ✅ **TypeScript → NestJS modül yapısı**  
   _JavaScript bilgin çok iyi; sadece tip güvenliği ve Nest modül mimarisi üzerine odaklanılmalı._  

3. ✅ **Makefile + scripts → Terminal-first üretim alışkanlığı**  
   _Zaten son aylarda ciddi ilerleme sağladın._  

4. ✅ **ESLint + Prettier**  
   _Kod kalitesi, biçim standardı ve otomatik düzeltme alışkanlığı kazandırır._  

5. ✅ **Prisma + PostgreSQL ilişkileri**  
   _SQL bilgin güçlü; bu nedenle Prisma öğrenimi hızlı olacaktır._  

6. 🟡 **Auth: JWT + bcrypt + session + guard + strategy**  
7. 🟡 **Upload / MinIO**  
8. 🟡 **Redis → BullMQ → Task Queue yapısı**  
9. 🟡 **Test sistemleri → Vitest, Supertest, Cypress**  
10. 🔁 **CI / GitHub Actions**

---

## 🛠️ Geliştirme Notu

> Bu dosya, TT Panel sisteminin teknik pusulası olarak düzenlenmiştir.  
> Mimari bütünlüğü korumak için tüm yeni modüller bu yapıya uygun geliştirilmeli;  
> büyüme, sadeleşme ve çok geliştiricili senaryolar önceden düşünülerek ilerlenmelidir.

## ✍️ Kapanış Notu

> Bu belge yalnızca bir teknoloji listesi değil, bir **mimari hafızadır**.  
> Sistem büyüdükçe bu dosya referans olacak,  
> her yeni geliştirici ve GPT üretimi bu yapıya bağlı çalışacaktır.