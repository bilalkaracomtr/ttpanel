---
title: "TT Panel – Üretim Yol Haritası"
description: "Bu dosya, TT Panel projesinin faz bazlı üretim sürecini, sprint yapılarını ve modül geliştirme dizilimini tanımlar. GPT destekli teknik üretim bu plana bağlı yürütülür."
category: "Planlama"
tags: ["roadmap", "faz", "sprint", "zamanlama", "hedef", "takip", "gpt", "modül üretimi"]
icon: "🗺️"
status: "active"
---

# 🗺️ TT Panel – Üretim Yol Haritası

Bu belge, TT Panel projesinin üretim sürecini fazlara, sprintlere ve modül gruplarına ayırarak tanımlar.
Tüm geliştirme süreci hem zaman bazlı hem de hedef bazlı olarak planlanır;
GPT destekli üretim bu yol haritası üzerinden yürütülür ve takip edilir.

Yol haritası yalnızca bir zaman çizelgesi değil;
modüler mimarinin nasıl büyüyeceğini, hangi sırayla inşa edileceğini ve hangi çıktılarla test edileceğini gösteren teknik bir pusuladır.

---

## 🎯 Yol Haritasının Amacı

- Üretim sürecini **faz bazlı bölümlere** ayırmak
- Her fazın içerisinde **ölçülebilir sprint hedefleri** tanımlamak
- Modül gruplarını, önceliklerini ve bağımlılıklarını netleştirmek
- Geliştirici – GPT – sistem dosyaları arasında **tekil referans noktası** oluşturmak
- Zaman yönetimini kontrol edilebilir ve izlenebilir kılmak

> Bu dosya, yalnızca planlama değil, **yürütme ve değerlendirme** aracıdır.
> Dosyada tanımlı her faz `memory.yaml > milestones` ile senkronize ilerler, sprint çıktıları test edilebilir yapıda tamamlanır.

---

## 🧠 Yol Haritası Yapı Mantığı

Bu yol haritası, TT Panel üretim sürecini **faz → sprint → modül → çıktı** şeklinde çok katmanlı bir yapıda kurgular.

Her faz:
- Belirli bir hedefe (örneğin: MVP, entegrasyon, ürünleşme) odaklanır
- Bağımsız sprintlerden oluşur
- Sprintler ise teknik çıktılar (modüller, sistemler, testler) ile tanımlanır

Yapı şu şekilde modellenmiştir:

| Seviye     | Tanım                                                                 |
|------------|-----------------------------------------------------------------------|
| **Faz**    | Stratejik üretim dönemi (örn: MVP, otomasyon, SaaS yayını)            |
| **Sprint** | 1–2 haftalık üretim döngüsü, her biri tamamlanabilir modül odaklıdır |
| **Modül**  | Teknik çıktı: `modules/<grup>/<modül>/` klasörü olarak açılır        |
| **Çıktı**  | Kod, test, yapı dosyası, panel bileşeni, API endpoint gibi tamamlayıcı üretimler |

---

### ⛓️ Bağımlılık ve Sıralama

- Modüller **gruplarına göre sıralı** olarak geliştirilir (`commerce` → `system` → `automation`)
- Her sprint, önceki fazın çıktıları üzerine kurulur
- Ortak yapılar (`apps/`, `services/`, `config/`) önceki fazlarda tamamlanır
- GPT üretimi yalnızca aktif faz + sprint üzerinden yürür

> Yol haritası, sadece görev dizilimi değil;
> **modüler üretimin önceliklendirme sistemidir.**

---

## 🧩 Üretim Felsefesi

TT Panel’in yol haritası, yalnızca bir zaman çizelgesi değil;
**modüler, test edilebilir ve sürdürülebilir üretim zihniyetinin bir yansımasıdır.**

Aşağıdaki ilkeler bu üretim sisteminin temelini oluşturur:

---

### 🔧 1. Modüler ve Gruplu Geliştirme

- Her işlevsel alan (`product`, `auth`, `billing` vs.) kendi modülü içinde geliştirilir
- Modüller gruplara ayrılarak (`commerce`, `system`, `automation`, `content`, `integration`) yönetilir
- Her modül, kendi içinde tamamlanabilir ve test edilebilir olacak şekilde yapılandırılır
- Gerektiğinde mikroservise dönüştürülebilecek izolasyonda kurgulanır

---

### 🧪 2. Test Edilebilirlik Önceliği

- Her modülün test kapsamı sprint içerisinde tanımlanır
- `Vitest`, `Supertest`, `Cypress` gibi araçlarla unit, integration ve e2e testler yazılır
- Testler `.env.test` ortamında izole olarak çalıştırılır
- Geliştirme yalnızca "çalışan kod" değil, "doğrulanabilir sistem" üretimine odaklanır

---

### 📦 3. Terminal-First ve Ortam Temelli Kurulum

- Geliştirme, Makefile + scripts + Docker Compose ile terminal üzerinden yürütülür
- Tüm servisler `.env` dosyalarıyla izole şekilde tanımlanır
- `apps/`, `modules/`, `services/`, `config/` gibi klasör yapıları önce kurulur, sonra içerik üretilir

---

### 🤝 4. GPT ile Ortak Üretim

- Tüm fazlar ve sprintler GPT tarafından adım adım eşlik edilerek yürütülür
- GPT yalnızca içerik değil, **dosya, klasör, kod, test ve yapı üretimi** yapar
- Yol haritası GPT’nin üretim referansıdır – başka hiçbir dosya bu düzeyde bağlayıcı değildir

---

### 📈 5. Ölçeklenebilirlik ve Ürünleşme Vizyonu

- TT Panel, ilk sürümde kuruma özel çözüm olarak geliştirilecek
- Ancak her yapı, gelecekte SaaS modeline geçebilecek esneklikle hazırlanır
- Tenant sistemi, lisans yapısı, tema ve modül kontrolü sonraki fazlarda ürünleşmeyi mümkün kılar

> Bu üretim felsefesi, yalnızca teknik değil;
> **düzenli, sürdürülebilir ve evrimsel üretim pratiğidir.**

---

## 🧩 Üretim Fazları ve Genel Plan

TT Panel projesi, fazlara ayrılmış üretim döngüsüyle planlanır.
Her faz, belirli bir ürün bileşenine odaklanır ve bağımsız sprintlerle yönetilir.
Bu bölümde fazların genel görünümü sunulur, ardından her faz detaylı şekilde açıklanır.

| Faz No | Süre                  | Başlık                            | Ana Amaç / Odak                                   | Hedef Alanlar / Modül Grupları                                                                     |
|--------|-----------------------|-----------------------------------|---------------------------------------------------|----------------------------------------------------------------------------------------------------|
| Faz 1  | 2025-07-13 → 09-01    | MVP – E-Ticaret + Sistem + İçerik | E-ticaret işleyişi, auth sistemi, içerik yönetimi | `commerce/`: product, order, customer<br>`system/`: auth, user, settings<br>`content/`: page, blog |
| Faz 2  | planlı                | Operasyon ve Otomasyon            | Üretim, görev, finans, takvim süreçleri           | `automation/`: production, task, billing, crm, schedule                                            |
| Faz 3  | planlı                | Entegrasyon Modülleri             | Dış servislerle API entegrasyonları               | `integration/`: mikro, trendyol, yurtici, smtp, webhook                                            |
| Faz 4  | planlı                | Ürünleşme ve SaaS Hazırlığı       | Tenant, tema, lisans, yetki sistemleri            | `system/`: tenant, license, theme, language, access                                                |
| Faz 5  | planlı                | İlk Yayın ve Müşteri Süreci       | Dış müşteri kurulumu, domain yönlendirme, SMTP    | `deployment/`: staging setup, prod config, KVKK, feedback panel                                    |

---

### 🔹 Faz 1 – MVP: E-Ticaret + Sistem + İçerik (`modules/commerce`, `system`, `content`)

**Süre:** 2025-07-14 → 2025-09-01
**Amaç:**
Bu fazda TT Panel’in ilk çalışan sürümü geliştirilecektir.
Hedef; e-ticaret, içerik ve sistem modüllerinden oluşan MVP yapının,
panel ve müşteri arayüzleri üzerinden uçtan uca entegre biçimde,
tam işlevsel ve test edilebilir bir sistem olarak tamamlanmasıdır.

Tüm geliştirme; `apps/api` (NestJS), `apps/admin` (Nuxt 3) ve `apps/public` (Nuxt 3) uygulamaları üzerinden eşzamanlı yürütülecektir.
Bu fazın sonunda hem yönetim paneli (`admin`) hem de son kullanıcı arayüzü (`public`) üzerinden **tam bir e-ticaret deneyimi** sorunsuz çalışmalıdır.

Aşağıdaki modül grupları bu fazın kapsamındadır:

- `modules/commerce/` → ürün, sipariş, müşteri, kampanya, kupon, popup
- `modules/system/` → kimlik, kullanıcı, rol, ayarlar, tema, dil
- `modules/content/` → sayfa, blog, medya, form, slider, testimonial, video

> `automation/` ve `integration/` modülleri bu faza dahil değildir.

---

#### ✅ Tamamlanma Kriterleri

Bu faz sonunda sistemin aşağıdaki temel bileşenleri eksiksiz ve entegre şekilde çalışmalıdır:

| Katman        | Gereken Yapı                                                                   |
|---------------|--------------------------------------------------------------------------------|
| `apps/api`    | NestJS API → Auth, Product, Customer, Order, Payment, Content uçları           |
| `apps/admin`  | Yönetim paneli → CRUD arayüzleri, içerik yönetimi, sipariş ve müşteri takibi   |
| `apps/public` | Müşteri arayüzü → ürün listeleme, sepet, kayıt/giriş, ödeme, sipariş takibi    |
| Ortak         | JWT akışı, MinIO ile dosya yükleme, `.env` yapılandırması, Traefik yönlendirme |
| Test          | `Vitest`, `Supertest`, `Cypress` ile temel test senaryoları uygulanmış olmalı  |

> Amaç yalnızca çalışan bir sistem değil; modüler, API-first, test edilebilir ve staging’e alınabilir bir altyapı kurmaktır.

---

#### 📦 Hedef Modül Grupları

- **`modules/commerce/`**
  - **catalog**: `product`, `category`, `brand`, `stock`, `supplier`, `file`, `variant`
  - **order**: `cart`, `order`, `payment`, `invoice`, `shipment`, `return`, `note`
  - **customer**: `customer`, `address`, `group`, `review`, `wishlist`
  - **marketing**: `campaign`, `coupon`, `popup`, `analytics`, `event`, `utm`, `conversion`, `merchant`

- **`modules/system/`**
  - **access**: `auth`, `user`, `role`, `token`
  - **config**: `settings`, `language`, `theme`
  - **notify**: `changelog`, `announcement`

- **`modules/content/`**
  - `page`, `blog`, `slider`, `testimonial`, `form`, `video`, `media`

---

#### ⚙️ Sistemsel Hedefler

- JWT tabanlı auth sistemi kurulacak (login, refresh, me)
- Yetkilendirme yapısı kurulacak: `user`, `role`, `permission`, `token`, `guard`, `strategy`
- Admin ve müşteri oturumları ayrılacak (`/admin`, `/public`)
- Nuxt layout sistemi kurulacak (`auth.vue`, `admin.vue`, `public.vue`)
- Çoklu dil (i18n) ve tema yapısı (`settings`, `theme`, `language`) başlatılacak
- MinIO ile dosya/görsel yükleme altyapısı kurulacak
- GA4 + Facebook Pixel script'leri entegre edilecek
- `useAnalytics` composable yazılacak → `view`, `add_to_cart`, `purchase`
- Facebook CAPI için backend endpoint'leri oluşturulacak
- `analytics_event` tablosu ile loglama yapılacak
- UTM parametreleri sipariş/müşteri ile ilişkilendirilecek
- Google Merchant feed için `GET /feed/merchant.json` endpoint’i hazırlanacak
- Ortam dosyaları: `.env`, `.env.api`, `.env.admin`, `.env.public` oluşturulacak
- Makefile komutları çalışır olacak: `make up`, `make seed`, `make reset`, vs.
- Docker ortamı eksiksiz çalışacak: `api`, `admin`, `public`, `postgres`, `redis`, `mailpit`, `minio`, `pgweb`
- Tüm modüller staging + test ortamında entegre edilebilir olacak

---

#### 🧪 Test ve Doğrulama

- Unit testler → `Vitest` ile `auth`, `product`, `customer`, `order` servisleri için temel senaryolar
- API testleri → `Supertest` ile login, product CRUD, cart, order işlemleri
- e2e testler → `Cypress` ile `login → ürün seç → sepete ekle → satın al` kullanıcı akışı
- Analytics tetikleyici testleri (`useAnalytics` composable → tetik geldi mi?)
- CAPI endpoint testleri (`/conversion/purchase`, log kayıtları kontrolü)
- UTM parametresi eşleşme testi (`utm_source` → `order` kaydına yazıldı mı?)
- Merchant feed endpoint çıktısı kontrolü (`GET /feed/merchant.json`)
- Test ortamı `.env.test` ile izole çalışacak şekilde tanımlanmalı
- Tüm testlerde mock veri kullanılmalı: min. 10 ürün, 3 kategori, 5 müşteri, 3 sipariş
- Panel–API–Public arayüzleri arasında JWT + veri akışı senkron test edilmeli

---

#### 🚀 Yayın ve Kapanış Kriterleri

- Yerel ortam eksiksiz çalışmalı: `make up`, `admin/public/api` servisleri, Traefik yönlendirmeleri
- `ttpanel.local` staging ortamı çalışır ve subdomain’ler yönlendirilmiş olmalı (`admin`, `api`, `public`)
- Tüm modüller dosya sisteminde oluşturulmuş ve test edilebilir olmalı
- Panel üzerinden: ürün ekle → müşteri kaydı → sepete ekle → satın al işlemi sorunsuz çalışmalı
- GA4 ve Facebook Pixel tetikleyicileri izlenebilir olmalı (Network/Console üzerinden kontrol)
- CAPI endpoint’lerine POST istekleri başarılı ve log kayıtları alınabilir olmalı
- Merchant Feed endpoint (`/feed/merchant.json`) doğru veriyle yayınlanmış olmalı
- UTM verisi siparişe işlenmiş olmalı (`utm_source`, `utm_campaign`)
- SMTP entegrasyonu yapılmalı (Mailpit üzerinden test edilen)
- KVKK, Gizlilik, Kullanım Şartları gibi içerik sayfaları oluşturulmalı
- Admin panelde temel analytics listesi gösterilebilmeli
- `docs/intro.md` dosyası hazırlanmalı: giriş, kullanım, oturum yapısı
- `memory.yaml > milestones` içinde Faz 1 tamamlandı olarak işaretlenmeli

---

#### 📆 Sprint Takvimi – Faz 1

| Sprint No | Tarihler          | Başlık                                 | Hedef Modül/Bileşen                                                                                 |
|-----------|-------------------|----------------------------------------|------------------------------------------------------------------------------------------------------|
| Sprint 1  | 07/14 – 07/21     | Teknik Kurulum + Auth Sistemi + Layout | `auth`, `user`, `role`, `token`<br>Nuxt layout, Makefile, Traefik, .env, Docker setup               |
| Sprint 2  | 07/22 – 07/28     | Ürün Kataloğu                          | `product`, `category`, `brand`, `stock`, `supplier`, `file`, `variant`                              |
| Sprint 3  | 07/29 – 08/04     | Müşteri Modülleri                      | `customer`, `address`, `group`, `review`, `wishlist`                                                |
| Sprint 4  | 08/05 – 08/11     | Sipariş Yönetimi                       | `cart`, `order`, `payment`, `invoice`, `shipment`, `return`, `note`                                 |
| Sprint 5  | 08/12 – 08/18     | İçerik + Sistem Ayarları               | `page`, `blog`, `slider`, `testimonial`, `form`, `video`, `media`<br>`settings`, `language`, `theme`|
| Sprint 6  | 08/19 – 08/25     | Pazarlama + Dönüşüm Sistemleri         | `campaign`, `coupon`, `popup`, `utm`, `analytics`, `event`, `conversion`, `merchant`                |
| Sprint 7  | 08/26 – 09/01     | Test + Yayın Hazırlığı                 | `Vitest`, `Supertest`, `Cypress`, `.env.test`, staging, domain, SMTP, analytics log kontrolü        |

> Her sprint sonunda test, veri kontrolü ve panel arayüzü senkronizasyonu yapılacaktır.

---

### 🧭 Sprint 1 – Teknik Kurulum + Auth Sistemi (`2025-07-14 → 2025-07-21`)

---

#### 🎯 Sprint Amacı

Bu sprint, TT Panel için yerel geliştirme ortamının kurulmasını ve temel kimlik sistemi olan `auth` modülünün uçtan uca çalışır hâle getirilmesini hedefler.
Amaç; geliştiricinin terminal-first bir yapı üzerinden panel ve API ile çalışabileceği izole, güvenli ve test edilebilir bir sistem oluşturmaktır.

---

#### ✅ Yapılacaklar Listesi

---

##### 📁 Geliştirme Ortamı ve Klasör Yapısı

- [x] `devroot/` altında `projects/`, `sandbox/`, `services/` klasörleri oluşturulacak
- [x] `projects/ttpanel/` dizininde şu klasör yapısı oluşturulacak:
  - `apps/`, `modules/`, `services/`, `config/`, `tests/`, `scripts/`, `packages/`
- [x] Her klasör için `README.md` veya `.gitkeep` dosyaları eklenecek (opsiyonel)

---

##### 🐳 Docker ve Ortam Servisleri

- [x] `docker-compose.yml` dosyası yazılacak (etiketli servis yönlendirmeleri dahil)
- [x] Ortak servis olarak `services/traefik/` altında Traefik kurulacak
- [x] Traefik reverse proxy yapılandırılacak (label, network, subdomain yönlendirme)
- [x] PostgreSQL, Redis, MinIO, Mailpit, Pgweb servisleri entegre edilecek
- [x] Her servis için `.env` dosyaları hazırlanacak: `.env`, `.env.api`, `.env.admin`, `.env.public`
- [x] Gerekli servislere özel `Dockerfile` dosyaları oluşturulacak (`config/docker/` altında)
- [x] Subdomain yönlendirmeleri yapılacak ve yerel `hosts` dosyasına şu satırlar eklenecek:
  - `admin.ttpanel.local`, `api.ttpanel.local`, `public.ttpanel.local`, `mail.ttpanel.local`, `db.ttpanel.local`

---

##### ⚙️ Makefile Komutları

- [x] `Makefile` dosyası yazılacak ve aşağıdaki komutlar tanımlanacak:
  - `make up` → Docker ortamını başlat
  - `make reset` → Veritabanı ve servisleri sıfırla
  - `make logs` → Servis loglarını takip et
  - `make psql` → PostgreSQL CLI bağlantısı
  - `make seed` → Test verisi yükleme (planlı)

---

##### 🗃️ Git Yapılandırması ve Repo Kurulumu

- [x] Git versiyonlama mantığı belirlenecek (`main`, `feature/`, `hotfix/`, `sandbox/`)
- [x] `.gitignore`, `README.md`, `CHANGELOG.md` dosyaları eklenecek
- [x] Git repo başlatılacak (`git init`) ve `main` branch oluşturulacak
- [x] GitHub reposu oluşturulacak ve SSH bağlantısı yapılacak
- [x] İlk commit ve push işlemleri gerçekleştirilecek

---

##### 🔐 NestJS – Auth Sistemi Geliştirme

- [ ] `apps/api/` içinde NestJS projesi başlatılacak
- [ ] `prisma` klasörü oluşturulacak, `schema.prisma` tanımlanacak
- [ ] `User`, `Role`, `Token` gibi temel modeller yazılacak
- [ ] `prisma migrate`, `prisma db seed` komutları hazırlanacak
- [ ] Makefile üzerinden `migrate`, `seed`, `psql` işlemleri yapılabilir olacak
- [ ] `modules/system/access/` altında şu modüller geliştirilecek:
  - `auth`, `user`, `role`, `token`
- [ ] Her modül için `entity`, `dto`, `service`, `controller`, `guard`, `strategy` yapıları tanımlanacak
- [ ] JWT access + refresh sistemi kurulacak (`@nestjs/jwt`)
- [ ] `bcrypt` ile parola şifreleme entegre edilecek
- [ ] `LocalStrategy`, `JwtStrategy` ve `AuthGuard` yapılandırılacak
- [ ] `.env.api` içinde şu ortam değişkenleri tanımlanacak:
  - `JWT_SECRET`, `JWT_EXPIRES_IN`, `REFRESH_TOKEN_EXPIRES_IN`
  - `GA4_ID`, `FB_PIXEL_ID`, `FB_ACCESS_TOKEN`
- [ ] Aşağıdaki endpoint’ler oluşturulacak:
  - `POST /auth/login`, `POST /auth/register`, `POST /auth/logout`, `GET /auth/me`, `POST /auth/refresh`

---

##### 🎨 Nuxt 3 Admin Panel – Layout ve Auth Arayüzü

- [ ] `apps/admin/` içinde Nuxt 3 projesi başlatılacak
- [ ] TailwindCSS, Pinia ve Nuxt i18n kurulacak
- [ ] Layout yapısı oluşturulacak:
  - `auth.vue` → Giriş / kayıt ekranı
  - `admin.vue` → Panel genel görünüm (sidebar, header, content)
- [ ] Login formu hazırlanacak, validasyon yapılacak
- [ ] Giriş sonrası `localStorage`’a JWT token yazılacak
- [ ] `useAuth` composable tanımlanacak: login, logout, fetchMe
- [ ] Middleware ile rota koruması yapılacak (`auth`, `guest`)
- [ ] Kullanıcı bilgisi `/me` endpoint’i ile frontend’e getirilecek
- [ ] Başarılı login sonrası admin paneline yönlendirme yapılacak (`/admin/dashboard`)

---

##### 🔌 Bağlantı Testleri ve Sağlık Kontrolleri

- [ ] Docker ortamı `make up` komutuyla ayağa kaldırılacak
- [ ] Subdomainler doğru çalışıyor mu (`admin`, `api`, `public`) test edilecek
- [ ] API ve panel arasında token ile iletişim kurulacak
- [ ] Auth akışı uçtan uca test edilecek (login → me → logout)
- [ ] MinIO, PostgreSQL, Redis servislerinin log ve bağlantıları kontrol edilecek
- [ ] Traefik dashboard erişimi ve yönlendirme doğruluğu test edilecek

#### 📌 Tamamlanma Kriterleri

- [ ] Geliştirme klasör yapısı (`apps/`, `modules/`, `services/`, vs.) eksiksiz oluşturulmuş olmalı
- [ ] Tüm servisler (`api`, `admin`, `postgres`, `redis`, `mailpit`, `minio`, `pgweb`) docker ile çalışır durumda
- [ ] `.env`, `.env.api`, `.env.admin`, `.env.public` dosyaları doğru tanımlanmış ve servislerle senkronize
- [ ] Subdomain yönlendirmeleri çalışır (örnek: `admin.ttpanel.local` açılabiliyor olmalı)
- [ ] `Makefile` üzerinden tüm komutlar (`make up`, `make reset`, `make logs`, `make psql`, vs.) başarıyla çalışıyor
- [ ] Git versiyonlama yapısı oluşturulmuş (`main`, SSH bağlantısı, GitHub repo, ilk commit/push)
- [ ] NestJS API (`apps/api`) ayağa kalkıyor ve aşağıdaki endpoint’ler tam olarak çalışıyor:
  - `POST /auth/login`, `POST /auth/register`, `POST /auth/logout`, `GET /auth/me`, `POST /auth/refresh`
- [ ] Auth modülleri (`auth`, `user`, `role`, `token`) full yapılandırılmış: `entity`, `dto`, `service`, `controller`, `guard`, `strategy`
- [ ] JWT sistemi access + refresh token üretimi ve doğrulamasıyla birlikte sorunsuz çalışıyor
- [ ] Nuxt 3 admin panel (`apps/admin`) ayağa kalkıyor, layout sistemi (`auth.vue`, `admin.vue`) aktif
- [ ] Giriş formu üzerinden login işlemi başarılı, token localStorage’a kaydediliyor
- [ ] `useAuth` sistemiyle kullanıcı bilgisi `/me` endpoint’inden çekilebiliyor
- [ ] Başarılı giriş sonrası admin layout’a yönlendirme çalışıyor
- [ ] Panel–API iletişimi JWT ile güvenli şekilde kurulmuş
- [ ] Traefik dashboard çalışıyor, tüm servisler doğru yönleniyor
- [ ] `apps/public` Nuxt 3 projesi başlatılmış ve `public.vue` layout tanımlanmış olmalı
- [ ] `.env.public` içinde `GA4_ID`, `FB_PIXEL_ID`, `FB_ACCESS_TOKEN` gibi değişkenler yer almalı
- [ ] `apps/admin` ve `apps/public` aynı JWT auth altyapısını kullanarak oturum açabiliyor olmalı
- [ ] `memory.yaml > timeline` ve `milestones` alanı sprint tamamlandı olarak güncellenmiş

---

### 🧭 Sprint 2 – Ürün Kataloğu (`2025-07-22 → 2025-07-28`)

---

#### 🎯 Sprint Amacı

Bu sprintte TT Panel’in e-ticaret altyapısında en temel işlev olan ürün katalog sistemi geliştirilecektir.
Hedef; ürün, kategori, marka, stok ve varyant işlemlerinin veri modeli, panel arayüzü ve API üzerinden uçtan uca çalışır hâle getirilmesidir.

---

#### ✅ Yapılacaklar Listesi

---

##### 📁 Modül ve Klasör Yapısı

- [ ] `modules/commerce/catalog/` dizini altında aşağıdaki modüller oluşturulacak:
  - `product/`, `category/`, `brand/`, `stock/`, `supplier/`, `file/`, `variant/`
- [ ] Her modül için NestJS tarafında: `entity`, `dto`, `service`, `controller`, `route`, `guard` yapıları hazırlanacak
- [ ] Nuxt tarafında `composables/`, `pages/`, `components/` yapısı ile modül UI'ları oluşturulacak

---

##### 📦 Ürün Veri Modeli ve API Geliştirme

- [ ] `product` modülü için ilişkisel veri modeli tanımlanacak (prisma + relation)
- [ ] Aşağıdaki özellikler modelde yer alacak:
  - `name`, `slug`, `sku`, `brandId`, `categoryIds[]`, `price`, `description`, `status`, `stock`, `images[]`, `variants[]`
- [ ] CRUD endpoint’leri geliştirilecek:
  - `GET /products`, `GET /products/:id`, `POST /products`, `PUT /products/:id`, `DELETE /products/:id`
- [ ] Listeleme, filtreleme, sıralama parametreleri desteklenecek
- [ ] JWT ile korunan rota yapısı korunacak
- [ ] `sku` benzersiz olacak şekilde kontrol edilmeli (`@unique`)
- [ ] `slug` alanı `name`’den otomatik türetilmeli (`@beforeCreate` mantığı ile)
- [ ] `status` alanı `enum: draft | active | archived` olacak şekilde tanımlanmalı

---

##### 🧩 İlişkili Modüllerin Geliştirilmesi

- [ ] `category`: çok seviyeli kategori yapısı, parent-child ilişki
- [ ] `brand`: ürün markaları, logo, açıklama alanı
- [ ] `supplier`: ürün tedarikçileri
- [ ] `file`: görsel / doküman yükleme → MinIO bağlantısı
- [ ] `stock`: stok adedi, rezervasyon durumu, uyarı eşikleri
- [ ] `variant`: renk, beden, etiket gibi varyant yapıları (opsiyonel alanlar)

---

##### 🎨 Admin Panel Arayüzleri

- [ ] `pages/products/index.vue`: ürün listeleme
- [ ] `pages/products/create.vue`: ürün ekleme
- [ ] `pages/products/[id].vue`: ürün detay ve güncelleme
- [ ] Kategori ve marka seçim bileşenleri (`select`, `tree select`, `tag select`)
- [ ] Stok ve varyant alanları için dinamik form yapısı
- [ ] Ürün görselleri için dosya yükleme alanı (MinIO entegrasyonu)

---

##### 🧪 Test ve Doğrulama

- [ ] API testleri (`Supertest`) ile CRUD işlemleri doğrulanacak
- [ ] Panel üzerinden form validasyonu yapılacak
- [ ] Ürün oluştur → panelde görüntüle → veriyi API’den çek → görsel yükle → sil senaryosu test edilecek
- [ ] Mock data ile minimum 10 ürün, 3 marka, 5 kategori, 2 tedarikçi girilecek
- [ ] `.env.test` ile test ortamında izole deneme yapılacak

---

##### 🔌 Bağlantı Kontrolleri

- [ ] `admin.ttpanel.local` üzerinden ürün paneli erişilebilir olacak
- [ ] `api.ttpanel.local/products` endpoint’i aktif ve erişilebilir olacak
- [ ] Panel–API iletişimi JWT ile devam edecek

---

#### 📌 Tamamlanma Kriterleri

- [ ] `modules/commerce/catalog/` içindeki tüm modüller tanımlanmış ve yapılandırılmış olmalı
- [ ] `apps/api` içinde tüm CRUD endpoint’leri aktif şekilde çalışmalı
- [ ] `apps/admin` panelinde ürün oluşturma, listeleme, düzenleme ve silme arayüzleri tamamlanmalı
- [ ] Ürün formu üzerinden marka + kategori + varyant seçimi yapılabilmeli
- [ ] Görsel yükleme MinIO üzerinden sorunsuz çalışmalı
- [ ] Auth koruması tüm rota ve işlem akışlarında geçerli olmalı
- [ ] Test ortamında e2e CRUD senaryoları başarıyla çalıştırılmış olmalı
- [ ] Ürün `slug` alanı `name`’den otomatik türetiliyor olmalı
- [ ] `sku` alanı benzersizlik kontrolüyle sistemde kayıtlı olmalı
- [ ] Aktif–pasif ürün statüsü arayüzde yönetilebilir olmalı
- [ ] Görsel yükleme süreci `file-upload.vue` bileşeni ile MinIO’ya bağlı çalışmalı
- [ ] `category`, `brand`, `file` gibi bileşenler ortak bileşen olarak tasarlanmalı (`packages/ui`)
- [ ] `memory.yaml > timeline` içinde Sprint 2 tamamlandı olarak işaretlenmiş olmalı

---

### 🧭 Sprint 3 – Müşteri Modülleri (`2025-07-29 → 2025-08-04`)

---

#### 🎯 Sprint Amacı

Bu sprintte TT Panel’in müşteri yönetimi altyapısı geliştirilecektir.
Amaç; müşteri kayıt sistemi, adres yönetimi, müşteri grupları, yorumlar ve istek listesi gibi işlemlerin uçtan uca kurulmasıdır.

---

#### ✅ Yapılacaklar Listesi

---

##### 📁 Modül ve Klasör Yapısı

- [ ] `modules/commerce/customer/` altında aşağıdaki modüller oluşturulacak:
  - `customer/`, `address/`, `group/`, `review/`, `wishlist/`
- [ ] NestJS tarafında her modül için: `entity`, `dto`, `service`, `controller`, `guard`, `validation` yapıları hazırlanacak
- [ ] Panel tarafında modül klasörleri açılacak: `pages/customers/`, `pages/reviews/`, `pages/groups/`

---

##### 👤 Müşteri Veri Modeli ve API

- [ ] `customer` modeli: `name`, `email`, `phone`, `password`, `status`, `createdAt`, `groupId`
- [ ] CRUD endpoint’leri yazılacak: `GET`, `POST`, `PUT`, `DELETE`
- [ ] `customer` için `POST /login`, `GET /me`, `POST /refresh` endpoint’leri oluşturulmalı
- [ ] Müşteri şifreleri `bcrypt` ile hash’lenmeli
- [ ] `review.status` alanı (`pending`, `approved`, `rejected`) olarak tanımlanmalı
- [ ] `wishlist` işlemleri için `POST`, `DELETE` endpoint’leri oluşturulmalı
- [ ] `address` modeli: müşteri-ilişkili çoklu adres (fatura / teslimat)
- [ ] `group`: müşteri segmentasyonu için temel yapı
- [ ] `review`: ürünlere yorum yapma ve moderasyon sistemi
- [ ] `wishlist`: müşterinin istek listesi


---

##### 🔐 Yetkilendirme ve Güvenlik

- [ ] Müşteri API endpoint’leri koruma altına alınacak (`JWT + Guard`)
- [ ] Sadece yetkili kullanıcılar müşteri bilgilerine erişebilecek
- [ ] Admin dışında hiçbir endpoint'e `token` olmadan erişilemeyecek
- [ ] Review yazma yalnızca login olan kullanıcıyla mümkün olacak

---

##### 🎨 Admin Panel Arayüzleri

- [ ] `pages/customers/index.vue`: müşteri listesi
- [ ] `pages/customers/[id].vue`: detay – siparişler – adresler
- [ ] `pages/customers/create.vue`: manuel müşteri ekleme
- [ ] `pages/groups/index.vue`: grup listesi
- [ ] `pages/reviews/index.vue`: ürün yorumları (onay / reddet)
- [ ] `pages/wishlist/index.vue`: sadece görüntüleme amaçlı basit arayüz

---

##### 🧪 Test ve Doğrulama

- [ ] Her modül için Supertest ile CRUD testleri yazılacak
- [ ] Müşteri login–me akışı tekrar test edilecek
- [ ] Wishlist ve yorumlar ürünlerle ilişkili çalışıyor mu kontrol edilecek
- [ ] Admin panelinden eklenen müşteri → API’den okunabiliyor mu test edilecek
- [ ] En az 5 test müşterisi, 2 grup, 3 yorum, 1 wishlist girişi yapılacak
- [ ] E2E senaryosu: müşteri oluştur → giriş yap → ürün yorumu yaz → wishlist’e ekle

---

##### 🔌 Bağlantı ve API Kontrolleri

- [ ] `GET /customers`, `POST /customers`, `PUT /customers/:id` endpoint’leri çalışır olacak
- [ ] `admin.ttpanel.local/customers` arayüzü tam çalışacak
- [ ] Yorum–ürün, müşteri–grup, müşteri–adres ilişkileri başarıyla işlenecek

---

#### 📌 Tamamlanma Kriterleri

- [ ] `modules/commerce/customer/` içindeki tüm modüller eksiksiz oluşturulmuş
- [ ] Tüm müşteri endpoint’leri (API tarafı) JWT korumalı şekilde çalışır
- [ ] Admin paneli üzerinden müşteri ekleme, düzenleme ve listeleme çalışıyor
- [ ] Müşteri yorumları ürünle ilişkilendirilebiliyor, admin tarafından yönetilebiliyor
- [ ] Wishlist fonksiyonu test edilmiş, en az bir ürün istek listesine eklenmiş
- [ ] Panel–API iletişimi bu sprint boyunca kesintisiz doğrulanmış
- [ ] `customer` login işlemi ve JWT üretimi çalışıyor olmalı
- [ ] `GET /me` endpoint’i müşteri oturumu içinde bilgi döndürmeli
- [ ] `review.status` alanı filtrelenebilir olmalı (admin onayı üzerinden)
- [ ] Wishlist işlemleri API + panel üzerinden test edilmiş olmalı (ekle–çıkar)
- [ ] `memory.yaml > timeline` içinde Sprint 3 tamamlandı olarak işaretlenmiş

---

### 🧭 Sprint 4 – Sipariş Yönetimi (`2025-08-05 → 2025-08-11`)

---

#### 🎯 Sprint Amacı

Bu sprintte TT Panel’in e-ticaret sürecinin merkezinde yer alan sipariş sistemi geliştirilecektir.
Hedef; sepet, sipariş, ödeme, fatura, kargo, iade ve sipariş notu gibi yapıların uçtan uca veri modeli, servis ve panel düzeyinde çalışır hâle gelmesidir.

---

#### ✅ Yapılacaklar Listesi

---

##### 📁 Modül ve Klasör Yapısı

- [ ] `modules/commerce/order/` altında aşağıdaki modüller oluşturulacak:
  - `cart/`, `order/`, `payment/`, `invoice/`, `shipment/`, `return/`, `note/`
- [ ] NestJS tarafında her modül için: `entity`, `dto`, `service`, `controller`, `guard`, `event` yapıları hazırlanacak
- [ ] Panel tarafında modül klasörleri açılacak: `pages/orders/`, `pages/returns/`, `pages/shipments/`

---

##### 📦 Sipariş Süreci ve API Geliştirme

- [ ] `cart`: oturum bazlı geçici sepet modeli (`cookie` ya da `token` üzerinden)
- [ ] `order`: sabitlenen sipariş modeli – ödeme sonrası oluşur
- [ ] `payment`: ödeme tipi, durumu, tahsilat tarihi (mock yapı)
- [ ] `invoice`: fatura bilgileri, vergi hesaplaması (PDF mock)
- [ ] `shipment`: kargo firması, takip kodu, teslimat durumu
- [ ] `return`: iade talebi, neden, onay durumu
- [ ] `note`: siparişe özel manuel notlar (admin paneli üzerinden girilir)
- [ ] `POST /checkout`: sepet → sipariş dönüşümü işlemi (mock ödeme dahil)
- [ ] `GET /invoice/:orderId/preview`: mock fatura HTML çıktısı
- [ ] Sipariş durum değişiklikleri `order_event` yapısıyla loglanmalı
- [ ] `order_status` adında dinamik statü yönetim tablosu oluşturulacak
- [ ] Admin panelde sipariş durumları listesi, ekleme, güncelleme yapılabilecek
- [ ] Sipariş `statusId` alanıyla `order_status` tablosuna bağlanacak
- [ ] Sipariş durumları renk, ikon ve açıklama içerebilecek (`name`, `color`, `icon`, `is_default`)

---

##### 🔐 İşlem Güvenliği ve Sipariş Rolleri

- [ ] Sepet yalnızca login kullanıcıda çalışacak
- [ ] Sipariş işlemleri sadece JWT + Guard korumalı şekilde erişilebilir olacak
- [ ] Her sipariş `userId` ile ilişkilendirilmiş olacak
- [ ] Admin dışı kullanıcılar yalnızca kendi siparişini görebilecek

---

##### 🎨 Admin Panel Arayüzleri

- [ ] `pages/orders/index.vue`: sipariş listesi
- [ ] `pages/orders/[id].vue`: sipariş detay ve işlem paneli
- [ ] `pages/returns/index.vue`: iade talepleri
- [ ] `pages/shipments/index.vue`: kargo bilgileri listesi
- [ ] Fatura bilgisi, ödeme özeti, müşteri bilgisi gösterimi
- [ ] Kargo takip kodu ekleme formu
- [ ] Siparişe not ekleme alanı (textarea)

---

##### 🧪 Test ve Doğrulama

- [ ] Sipariş oluşturma → ödeme simülasyonu → detay görüntüleme senaryosu
- [ ] Sepet akışı: ürün ekle → düzenle → sil → siparişe dönüştür
- [ ] İade başvurusu panel üzerinden açılabilecek ve durum güncellenebilecek
- [ ] Panelden sipariş notu eklendiğinde API’de görülebilecek
- [ ] Mock ödeme işlemi ile tahsilat tamamlanmış gibi işaretlenebilecek
- [ ] 3 örnek sipariş verisi üzerinden E2E test döngüsü çalıştırılacak

---

##### 🔌 Bağlantı ve Servis Kontrolleri

- [ ] `POST /cart`, `POST /order`, `GET /order/:id` endpoint’leri çalışmalı
- [ ] Panel arayüzleri veriyle senkronize şekilde çalışmalı
- [ ] Sipariş adımları log veya event sistemine kaydedilmeli (opsiyonel kayıt)

---

#### 📌 Tamamlanma Kriterleri

- [ ] `modules/commerce/order/` altındaki tüm modüller aktif ve ilişkili çalışıyor
- [ ] Sepet → sipariş → kargo → iade akışı test edilip API ve panelde doğrulanmış
- [ ] Admin panelinden sipariş takip, not girişi ve durum güncellemeleri yapılabiliyor
- [ ] Mock ödeme işlemi üzerinden siparişin durumu değiştirilebiliyor
- [ ] Siparişlerin ilişki yapısı (`user`, `product`, `shipment`, `invoice`) bozulmadan çalışıyor
- [ ] Panel–API senkronizasyonu sprint boyunca sorunsuz işlemekte
- [ ] `POST /checkout` endpoint’i ile sepet → sipariş dönüşümü çalışıyor
- [ ] `invoice` modülü en azından mock JSON/HTML çıktısı üretiyor
- [ ] `order_event` veya benzeri yapı ile sipariş işlemleri loglanabiliyor
- [ ] E2E senaryo: müşteri → ürün ekle → sipariş oluştur → admin kargo ekle → müşteri iade talep et
- [ ] `order_status` adında dinamik statü yönetim tablosu oluşturulacak
- [ ] Admin panelde sipariş durumları listesi, ekleme, güncelleme yapılabilecek
- [ ] Sipariş `statusId` alanıyla `order_status` tablosuna bağlanacak
- [ ] Sipariş durumları renk, ikon ve açıklama içerebilecek (`name`, `color`, `icon`, `is_default`)
- [ ] `memory.yaml > timeline` içinde Sprint 4 tamamlandı olarak işaretlenmiş

---

### 🧭 Sprint 5 – İçerik Modülleri (`2025-08-12 → 2025-08-18`)

---

#### 🎯 Sprint Amacı

Bu sprintte TT Panel’in içerik yönetim sistemi (CMS) kurulacaktır.
Amaç; sayfa, blog, form, medya ve etkileşim bileşenlerinin panel üzerinden yönetilebilir hâle getirilmesidir.
Bu yapı sayesinde e-ticaret dışı sayfalar (kurumsal, KVKK, duyuru, haber) kolayca üretilebilecektir.

---

#### ✅ Yapılacaklar Listesi

---

##### 📁 Modül ve Klasör Yapısı

- [ ] `modules/content/` altında aşağıdaki modüller oluşturulacak:
  - `page/`, `blog/`, `slider/`, `testimonial/`, `form/`, `video/`, `media/`
- [ ] Her modül için `entity`, `dto`, `service`, `controller`, `guard` yapıları oluşturulacak
- [ ] Panel tarafında `pages/content/` altında modül sayfaları açılacak

---

##### 📄 İçerik Modelleri ve Özellikleri

- [ ] `page`: özel sayfa (slug + HTML içeriği), yayın durumu, başlık, açıklama
- [ ] `blog`: başlık, içerik, kategori, kapak görseli, yazar adı, SEO alanları
- [ ] `slider`: görsel, başlık, açıklama, buton, sıralama
- [ ] `testimonial`: müşteri yorumu, ad-soyad, pozisyon, firma, görsel
- [ ] `form`: iletişim formu şeması + gönderi kayıtları
- [ ] `video`: embed URL + başlık
- [ ] `media`: yüklenen tüm dosyaların arşivi (MinIO bağlantılı)
- [ ] `page` ve `blog` içerikleri için `status` alanı tanımlanacak (draft, published, archived)
- [ ] `slug` alanı başlıktan otomatik üretilecek ama değiştirilebilir olacak
- [ ] `form` modülü `form_definition` + `form_submission` olarak iki ayrı modelle çalışacak

---

##### 🎨 Admin Panel Arayüzleri

- [ ] `pages/content/page/`: sayfa liste + düzenleme
- [ ] `pages/content/blog/`: blog yazı yönetimi
- [ ] `pages/content/slider/`: slider bileşeni düzenleyici
- [ ] `pages/content/form/`: form tanımı ve yanıt görüntüleyici
- [ ] `pages/content/media/`: dosya yöneticisi (görsel, PDF, video)
- [ ] Rich text editör (örn: Tiptap) tüm içerik modüllerinde kullanılacak
- [ ] SEO alanları için ortak `SeoFields.vue` bileşeni geliştirilecek

---

##### 🔌 MinIO ve Ortam Bağlantıları

- [ ] `media` modülü MinIO servisine bağlanacak
- [ ] Panelde dosya yükleme bileşeni hazırlanacak (`dropzone`, `input[type=file]`, vs.)
- [ ] Yüklenen medya için URL üretilecek ve preview gösterilecek
- [ ] Form gönderimleri admin panelde listelenebilir olacak

---

##### 🧪 Test ve Doğrulama

- [ ] Her içerik modülü için CRUD endpoint’leri test edilecek
- [ ] Medya yükleme, form gönderme ve sayfa oluşturma senaryoları çalıştırılacak
- [ ] MinIO üzerindeki dosya erişimi test edilecek
- [ ] SEO alanları (meta title, description) `page` ve `blog` için kontrol edilecek
- [ ] En az 3 sayfa, 2 blog, 2 slider, 1 form içeriği test verisi olarak eklenecek

---

#### 📌 Tamamlanma Kriterleri

- [ ] `modules/content/` altındaki tüm modüller aktif ve CRUD işlemleri tamamlanmış
- [ ] Panelden tüm içerik türleri eklenip yönetilebiliyor
- [ ] Dosya yükleme MinIO üzerinden çalışıyor, link üretimi başarılı
- [ ] Form bileşeni gönderim yapabiliyor ve kayıt panelde listeleniyor
- [ ] Medya klasörü tüm içerik türleriyle entegre şekilde çalışıyor
- [ ] Tüm içerik modülleri panelde editör dostu ve kullanıcıya açık yönetilebiliyor
- [ ] Sayfa ve blog içerikleri statü (yayın durumu) ile yönetilebiliyor
- [ ] Slug alanı otomatik oluşuyor, panelde düzenlenebilir
- [ ] Form modülü gönderim + şablon ilişkisiyle çalışıyor (`definition` + `submission`)
- [ ] Rich text editor entegre edilmiş ve içerik biçimlendirmesi yapılabiliyor
- [ ] SEO alanları ayrı bileşen olarak düzenlenmiş ve içeriklerle entegre
- [ ] `memory.yaml > timeline` içinde Sprint 5 tamamlandı olarak işaretlenmiş

---

### 🧭 Sprint 6 – Pazarlama + Sistem Ayarları (`2025-08-19 → 2025-08-25`)

---

#### 🎯 Sprint Amacı

Bu sprintte TT Panel’in kampanya yönetimi, kupon sistemi, analiz ve temel sistem ayarları geliştirilecektir.
Amaç; satış artırıcı pazarlama araçları ile çokdilli yapı, tema ve genel ayarların panele entegre edilmesidir.

---

#### ✅ Yapılacaklar Listesi

---

##### 📁 Modül ve Klasör Yapısı

- [ ] `modules/commerce/marketing/` altında:
  `campaign/`, `coupon/`, `popup/`, `utm/`, `analytics/`, `event/`, `conversion/`, `merchant/`
- [ ] `modules/system/config/` altında: `settings/`, `language/`, `theme/`
- [ ] Her modül için NestJS tarafında: `entity`, `dto`, `service`, `controller`, `guard`
- [ ] Panel tarafında `pages/marketing/`, `pages/system/` altında sayfalar açılacak

---

##### 💡 Pazarlama Modülleri

- [ ] `campaign`: zaman bazlı indirim tanımı (başlangıç – bitiş – oran – hedef ürünler)
- [ ] `coupon`: indirim kodu oluşturma ve kullanımı (`code`, `amount`, `usageLimit`, `expiration`)
- [ ] `popup`: site içi duyuru ve kampanya kutusu
- [ ] `utm`: kaynak – kampanya – medium takibi için parametre yönetimi
- [ ] `analytics`: ziyaretçi, trafik ve işlem kaydı mock yapısıyla izleme (dev-friendly mock servis)

---

##### 📊 Dönüşüm & Entegrasyon Modülleri

- [ ] `event`: frontend’deki tetikleyicilerin (add_to_cart, purchase) backend log kaydı
- [ ] `conversion`: Facebook CAPI için backend endpoint ve access token bağlantısı
- [ ] `merchant`: Google Merchant Feed JSON çıktısı (kategori – fiyat – stok alanları)
- [ ] GA4 + Pixel script’leri `apps/public` layout’a eklenecek
- [ ] `useAnalytics.ts` composable yazılacak → tetikleme + payload gönderimi
- [ ] `.env.public` ortam değişkenleri hazırlanacak: `GA4_ID`, `FB_PIXEL_ID`, `FB_ACCESS_TOKEN`

---

##### ⚙️ Sistem Ayarları Modülleri

- [ ] `settings`: sistem adı, logo, e-posta, varsayılan dil gibi temel ayarlar
- [ ] `language`: dil yönetimi (panel için çokdillilik desteği)
- [ ] `theme`: panel ve frontend için tema / renk / font yapılandırması (JSON tabanlı config)

---

##### 🎨 Admin Panel Arayüzleri

- [ ] `pages/marketing/campaign/`, `coupon/`, `popup/`, `utm/`, `analytics/`, `event/`, `conversion/`, `merchant/`
- [ ] `pages/system/settings/`: form tabanlı site ayarları
- [ ] `pages/system/language/`: dil listesi ve yeni dil ekleme
- [ ] `pages/system/theme/`: tema varyasyonları seçimi ve önizleme

---

##### 🧪 Test ve Doğrulama

- [ ] Kampanya başlat → ürün fiyatına etki → süre bitince etkisizleşme
- [ ] Kupon oluştur → frontend'de kullan → tekil / çoklu kullanım senaryoları
- [ ] UTM parametresi ile sipariş takibi log’a yazılıyor mu kontrol
- [ ] Tema ayarları `.json` formatında kaydediliyor ve doğru yükleniyor
- [ ] Minimum 2 kampanya, 3 kupon, 2 popup, 2 dil, 1 tema varyantı test verisi girilecek
- [ ] Ayarlar API’si ile frontend yapılandırma bilgisi alınabilecek mi test edilecek
- [ ] `useAnalytics` → tetikleyici → GA4 + Pixel script’lerine veri gönderimi test edilecek
- [ ] Facebook CAPI için `/conversion/purchase` endpoint çağrılacak ve log yazılacak
- [ ] UTM parametreleri sipariş kaydına işlendi mi kontrol edilecek
- [ ] Merchant feed çıktısı (`/feed/merchant.json`) elle test edilecek
- [ ] `analytics_event` tablosuna kayıt düşüyor mu test edilecek

---

#### 📌 Tamamlanma Kriterleri

- [ ] `marketing/` ve `system/config/` altındaki tüm modüller oluşturulmuş ve çalışır
- [ ] Kampanya ve kupon işlemleri admin panel üzerinden eksiksiz yürütülebiliyor
- [ ] Sistem ayarları kaydedilebiliyor, frontend’e aktarılabiliyor
- [ ] Tema ve dil yönetimi yapılandırılabiliyor, `.json` olarak kaydediliyor
- [ ] Pazarlama araçları frontend’e entegre edilmeye hazır biçimde çalışıyor
- [ ] `event`, `conversion`, `merchant` modülleri backend + panelde çalışır hâlde
- [ ] `useAnalytics` composable tetikleyici fonksiyonları GA4 + FB Pixel’e veri gönderiyor
- [ ] Facebook CAPI istekleri access token ile backend üzerinden gönderiliyor
- [ ] Merchant Feed endpoint çıktısı doğrulanabiliyor
- [ ] `.env.public` dosyası içinde GA4/Pixel bilgileri tanımlı
- [ ] Analytics logları panelde görüntülenebiliyor
- [ ] `memory.yaml > timeline` içinde Sprint 6 tamamlandı olarak işaretlenmiş

---

### 🧭 Sprint 7 – Test + Yayın Hazırlığı (`2025-08-26 → 2025-09-01`)

---

#### 🎯 Sprint Amacı

Bu sprintte TT Panel’in ilk fazı test edilecek ve lokalden staging ortama taşınacaktır.
Amaç; tüm modüllerin uçtan uca entegrasyonu, test senaryolarının tamamlanması ve dışa açık yayına hazır hâle getirilmesidir.

---

#### ✅ Yapılacaklar Listesi

---

##### 🧪 Test Ortamı Kurulumu

- [ ] `.env.test` dosyaları hazırlanacak (`api`, `admin`, `public`)
- [ ] Test ortamı için özel Docker servisleri tanımlanacak
- [ ] `make test` komutu tanımlanacak
- [ ] Mock veri seti oluşturulacak (minimum 100+ satır)
- [ ] Seed script dosyası (`scripts/seed.ts`) ile test verisi yüklenecek

---

##### 🔍 Test Senaryoları ve Araçlar

- [ ] Unit testler: `Vitest` ile modül bazlı servis testleri
- [ ] API testleri: `Supertest` ile auth, product, order, customer senaryoları
- [ ] e2e testler: `Cypress` ile giriş, form gönderimi, işlem akışı kontrolleri
- [ ] Admin–API–DB arasında senkron kontrol
- [ ] Eksik validasyon, boş veri, hatalı girişler için hata mesajları test edilecek
- [ ] Tüm modüller için min. 1 başarılı – 1 başarısız test yazılacak
- [ ] `useAnalytics` fonksiyonları tetikleme ve GA4 / fbq gözlemi test edilecek
- [ ] `POST /conversion/...` endpoint’leri manuel ve otomatik tetiklenme ile kontrol edilecek
- [ ] UTM parametresi sipariş kaydına işlendi mi test edilecek
- [ ] Merchant feed çıktısı (`/feed/merchant.json`) manuel kontrol edilecek
- [ ] `apps/public` üzerinden müşteri akışı (ürün → sepet → sipariş) uçtan uca test edilecek

---

##### 🛠️ Yayın Hazırlığı

- [ ] `ttpanel.local` staging ortamı Traefik ile ayağa kaldırılacak
- [ ] Domain yönlendirme + SSL (lokal test için self-signed)
- [ ] SMTP bağlantısı yapılacak (Mailpit → gerçek SMTP)
- [ ] KVKK / Gizlilik / Kullanım Şartları sayfaları eklenecek
- [ ] Panel üzerinde “geri bildirim” veya “hata bildir” modülü yerleştirilecek
- [ ] İlk kullanım dokümantasyonu başlatılacak (`docs/intro.md`)

---

##### 🔐 Güvenlik ve Stabilite

- [ ] Token süresi, şifre politikası, açık endpoint kontrolü
- [ ] Dosya erişim URL’lerinin süresi ve görünürlüğü
- [ ] Veritabanı ilişkileri ve veri bütünlüğü manuel gözle kontrol edilecek
- [ ] Admin dışı erişim noktaları 403 ile sonlandırılacak

---

#### 📌 Tamamlanma Kriterleri

- [ ] `.env.test` ortamı tanımlanmış ve test ortamı sorunsuz çalışıyor
- [ ] Unit / API / e2e test senaryoları tüm ana modüller için uygulanmış
- [ ] Admin + API + veri servisleri arasında entegre testler çalışıyor
- [ ] Staging ortam yayına hazır ve alt alan adları yönlendirilmiş
- [ ] SMTP üzerinden gerçek e-posta gönderimi test edilmiş
- [ ] İlk kurulum ve kullanım dokümantasyonu başlatılmış
- [ ] Tüm sistem bileşenleri test, log ve dışa açık endpoint açısından kontrol edilmiş
- [ ] GA4 ve Facebook Pixel tetikleyicileri frontend tarafında test edilmiş
- [ ] Facebook CAPI çağrıları log’a düşüyor ve access token ile çalışıyor
- [ ] Merchant Feed JSON çıktısı doğru biçimde üretilmiş
- [ ] `apps/public` arayüzü üzerinden alışveriş akışı e2e testlerle doğrulanmış
- [ ] `useAnalytics.ts` fonksiyonları doğru trigger çalıştırıyor
- [ ] UTM verileri sipariş kayıtlarında görülebiliyor
- [ ] `memory.yaml > timeline` içinde Sprint 7 tamamlandı olarak işaretlenmiş

---

### 🔹 Faz 2 – Operasyon ve Otomasyon

**Süre:** planlı (2025-09 → tahmini 4–6 hafta)
**Amaç:**
İş akışlarının dijitalleştirilmesi ve görev, üretim, faturalama gibi süreçlerin panel üzerinden yönetilebilir hâle getirilmesi hedeflenir.
Otomatik eylemler, bildirimler ve iç süreç yönetimi bu fazın temelidir.

---

#### 📦 Hedef Modül Grupları

- **`modules/automation/`**
  - `production/`: üretim aşamaları, ürün işleme
  - `task/`: görev atama, durum takibi
  - `billing/`: faturalama ve ödeme kayıtları
  - `crm/`: müşteri etkileşim geçmişi, etiketleme
  - `schedule/`: takvim, toplantı, aktivite planlama

### 🔹 Faz 3 – Entegrasyon Modülleri

**Süre:** planlı
**Amaç:**
Dış sistemlerle veri alışverişi sağlamak, e-ticaret operasyonlarını büyütmek için entegrasyon altyapısı kurulacaktır.
Harici servislerle çalışan API bağlantıları bu fazın odak noktasıdır.

---

#### 📦 Hedef Modül Grupları

- **`modules/integration/`**
  - `mikro/`: ön muhasebe ve stok entegrasyonu
  - `trendyol/`: ürün, sipariş, stok, fiyat API bağlantısı
  - `yurtici/`: kargo API bağlantısı
  - `smtp/`: e-posta gönderim altyapısı
  - `webhook/`: dış sistem tetikleyici

### 🔹 Faz 4 – Ürünleşme ve SaaS Hazırlığı

**Süre:** planlı
**Amaç:**
TT Panel’in çok kiracılı yapıya (multi-tenant) dönüştürülmesi ve özelleştirilebilir tema, lisanslama, erişim kontrol sistemlerinin devreye alınmasıdır.
Bu faz ürünleşmenin teknik temelini oluşturur.

---

#### 📦 Hedef Modül Grupları

- **`modules/system/`**
  - `tenant/`: kiracı yapısı, izole veri yönetimi
  - `license/`: kullanım lisansı, sürüm kısıtları
  - `theme/`: tema, layout, stil varyasyonları
  - `language/`: çokdillilik ve çeviri kontrolü
  - `access/`: izin, rol, yetki matrisi

### 🔹 Faz 5 – İlk Yayın ve Müşteri Süreci

**Süre:** planlı
**Amaç:**
Canlı ortamda ilk müşteri kurulumu yapılacak, domain yönlendirmeleri, KVKK ve SMTP yapılandırmaları tamamlanacaktır.
Dış dünyaya açılan ilk TT Panel kurulumu bu fazda gerçekleşir.

---

#### 📦 Hedef Modül Grupları

- **`modules/deployment/`**
  - `staging-setup/`: ön hazırlık ortamı
  - `prod-config/`: canlı ortam yapılandırması
  - `kvkk/`: yasal sayfalar, metin içerikleri
  - `feedback/`: kullanıcı geri bildirimi ve hata yakalama
---

## 🧠 Geliştirme ve Takip Notları

- Her sprintin sonunda `memory.yaml > timeline` güncellenecek
- Faz geçişleri ve aktif görev `working_state` alanı ile yönetilecektir
- GPT üretim sistemi yalnızca bu yol haritası ve `memory.yaml` bağlamında çalışacaktır

---

## ✍️ Kapanış Notu

> Bu belge TT Panel projesinin tüm üretim sürecini aşamalı, takip edilebilir ve ölçülebilir hâle getirir.
> Her faz kendi içinde tamamlanabilir birimler sunar. GPT ve geliştirici bu plana göre adım adım üretim yapar.
