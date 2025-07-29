# 🧱 Modül Üretim Rehberi – TT Panel

Bu rehber, TT Panel içerisinde yeni bir modül oluşturma, seed çalıştırma ve test etme süreçlerini terminal tabanlı olarak nasıl yöneteceğinizi açıklar.

---

## 🚀 Komutlar

### 📁 1. Yeni Modül Oluştur

```bash
make mc system/access/role
```

Açıklama:
Verilen yola göre bir NestJS modül iskeleti oluşturur.
Aşağıdaki klasör yapısını üretir:

```
modules/system/access/role/
├── controller/
├── service/
├── dto/
├── entity/
├── test/
├── seed/
├── config/
├── guard/
├── policy/
├── pipe/
├── middleware/
├── helper/
├── factory/
├── validator/
├── interceptor/
├── role.module.ts
└── role.routes.ts
```

Boş klasörlere `.gitkeep` eklenir. Temel dosyalar otomatik içerikle doldurulur:

- `service`, `controller`, `dto`, `spec`, `seed` dosyaları örnek kodlarla gelir.

---

### 🌱 2. Modül Seed Çalıştır

```bash
make ms system/access/role
```

Açıklama:
Verilen modül yolundaki şu dosyayı çalıştırır:

```
modules/system/access/role/seed/role.seed.ts
```

Bu dosya içinde `PrismaClient` kullanılarak örnek veriler veritabanına yazılır.
Script, `docker compose exec api` üzerinden güvenli şekilde çalışır.

---

### 🧪 3. Modül Test Çalıştır

```bash
make mt system/access/role
```

Açıklama:
Verilen modül yolundaki test klasörünü çalıştırır:

```
modules/system/access/role/test/
```

Tüm `.spec.ts` dosyaları `Vitest` ile çalıştırılır.

---

## 🧠 Üretim Prensipleri

- Tüm modüller `modules/{group}/{subgroup}/{modül}` şeklinde isimlendirilmelidir.
- Her modül `controller`, `service`, `dto`, `entity`, `test`, `seed` dizinlerini içermelidir.
- Tüm testler `Vitest`, tüm seed'ler `Prisma` ile yazılmalıdır.
- Ortak komutlar Makefile üzerinden çağrılır, parametre `path` olarak verilmez, doğrudan `make mc group/path/module` şeklinde yazılır.

---

## 🧰 Makefile Kısayolları

| Komut                        | Açıklama                        |
| ---------------------------- | ------------------------------- |
| `make mc system/access/role` | Yeni modül oluşturur            |
| `make ms system/access/role` | Seed dosyasını çalıştırır       |
| `make mt system/access/role` | Test klasörünü çalıştırır       |
| `make seed`                  | Tüm global Prisma seed          |
| `make test`                  | API genel testlerini çalıştırır |
| `make migrate`               | Prisma migrate işlemi           |

---

## ✨ Genişletme Vizyonu (isteğe bağlı)

- `schema.prisma` içine model tanımı eklemek
- `policy`, `guard`, `routes` gibi dosyaları örnekle başlatmak
- `make lint`, `make build`, `make dev` gibi üretim komutları tanımlamak
- `make module:all path=...` gibi zincirleme işlemler başlatmak

---

## 📌 Not

Bu rehber terminal-first ve GPT destekli modül üretim yapısını anlatır.
Tüm işlemler `scripts/` klasöründeki Bash script’ler ile yürütülür.
Canvas **kullanılmaz**, tüm çıktılar markdown `code block` olarak yazılır.
