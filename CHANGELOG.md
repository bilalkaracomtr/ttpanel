# 📦 TT Panel – Değişiklik Günlüğü

## [v0.0.0] – 2025-08-06

### 🗃️ Proje Yapısı

- Ana klasör yapısı oluşturuldu:
  `apps/`, `services/`, `config/`, `tests/`, `docs/`, `scripts/`, `packages/`
- Tüm klasörler `.gitkeep` dosyaları ile version kontrolüne alındı
  (örnek: `modules/commerce/catalog/product/`, `modules/system/access/auth/`)
- Ortam yapılandırma dosyaları oluşturuldu:
  `.env`, `.env.example`, `.env.api.example`, `.env.[service]`, `.env.staging`, `.env.test`

### 🐳 Docker & Ortam Sistemleri

- Docker servisleri tanımlandı:
  `traefik`, `postgres`, `redis`, `minio`, `mailpit`, `pgweb`, `api`, `admin`, `shop`
- Traefik yönlendirme, subdomain ve network yapılandırmaları yapıldı
- Ortam komut sistemleri oluşturuldu:
  `docker-compose.yml`, `Makefile`, `Dockerfile`, servis klasörleri (`services/*`)

### 🔧 Versiyon Kontrolü

- Git deposu başlatıldı, `main` branch oluşturuldu
- `.gitignore`, `README.md`, `CHANGELOG.md`, `LICENSE` dosyaları eklendi
- GitHub bağlantısı kuruldu (SSH anahtarı ile)
- Versiyonlama modeli tanımlandı:
  `main`, `feature/sprint_x-*`, `hotfix/*`, `sandbox/*`
- İlk commit atıldı, `v0.0.0` etiketi oluşturuldu
  [`github.com/bilalkaracomtr/ttpanel`](https://github.com/bilalkaracomtr/ttpanel)

### 📝 Notlar

- Bu sürüm temel sistem kurulumunun tamamlandığı noktayı temsil eder.
- Henüz uygulama (API/panel) kodu yazılmamıştır.
- Bir sonraki sprint adımı: `auth` sistemi ile ilk backend modülü geliştirilecektir.
