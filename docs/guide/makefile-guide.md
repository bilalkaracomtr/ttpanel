# 🛠️ Makefile Komut Rehberi – TT Panel

Bu dosya, TT Panel projesi içinde kullanılan `make` komutlarının açıklamasını ve kullanım biçimlerini içerir.
Her komut, terminal üzerinden çağrılabilir ve üretim sürecini otomatikleştirir.

---

## 📦 SERVİS YÖNETİMİ

| Komut             | Açıklama                                 |
|-------------------|------------------------------------------|
| `make up`         | Docker servislerini başlatır             |
| `make down`       | Tüm konteynerleri durdurur               |
| `make restart`    | Projeyi yeniden başlatır                 |
| `make logs`       | Canlı servis loglarını gösterir          |
| `make clean`      | Volume + network + cache temizliği yapar |
| `make docker:build` | Docker image’lerini yeniden oluşturur  |

---

## 🧱 VERİTABANI / PRISMA

| Komut               | Açıklama                                      |
|---------------------|-----------------------------------------------|
| `make migrate`      | Prisma migrate çalıştırır (`dev` ortamı için) |
| `make generate`     | Prisma client’ı yeniden üretir                |
| `make seed`         | Seed dosyasını çalıştırır (`prisma/seed.ts`)  |
| `make psql`         | PostgreSQL konsoluna bağlanır (`psql`)        |
| `make prisma:studio`| Prisma Studio GUI arayüzünü başlatır         |

---

## 🧪 TEST / LINT / FORMAT

| Komut               | Açıklama                                |
|---------------------|-----------------------------------------|
| `make test`         | Tüm testleri çalıştırır (Vitest)        |
| `make test:unit`    | Yalnızca unit test klasörünü çalıştırır |
| `make test:e2e`     | Supertest veya API testi yapar          |
| `make lint`         | ESLint ile kodu analiz eder             |
| `make format`       | Prettier ile kod biçimlendirir          |

---

## ✨ MODÜL / CRUD / ŞEMA ÜRETİMİ

| Komut                      | Açıklama                                                       |
|----------------------------|----------------------------------------------------------------|
| `make gmod name=x path=y`  | Yeni bir modül üretir (dto, test, module, controller, service) |
| `make gcrud name=x`        | CRUD yapısını tek seferde üretir                               |
| `make gschema`             | schema.prisma + migrate + generate zinciri çalıştırır          |

---

## 🧳 YEDEKLEME & VERİ TRANSFERİ

| Komut             | Açıklama                                 |
|-------------------|------------------------------------------|
| `make backup`     | PostgreSQL dump dosyası üretir           |
| `make restore`    | Dump dosyasını geri yükler               |
| `make db:reset`   | DB’yi siler → yeniden kurar → seed atar  |

---

## 📚 BELGESEL / DESTEK KOMUTLAR

| Komut             | Açıklama                          |
|-------------------|-----------------------------------|
| `make help`       | Tüm make komutlarını listeler     |
| `make version`    | Proje versiyonunu gösterir        |
| `make changelog`  | `CHANGELOG.md` içeriğini listeler |

---

## 📁 YAPI

```
Makefile
scripts/
├── generate-module.sh
├── seed-dev.sh
├── backup-db.sh
└── restore-db.sh
```

---

## 🧠 NOT

Tüm make komutları terminal uyumludur.
Dosya yolları, prisma yapısı ve test klasörleri sistemine uygun biçimde yapılandırılmalıdır.
