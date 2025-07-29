# 🧱 TT Panel – Monorepo Dönüşüm Rehberi

Bu dosya, TT Panel projesinin `pnpm monorepo` yapısına geçişini belgeleyen kılavuzdur.  
Modüller, scriptler, frontend bileşenleri ve uygulamalar artık tek merkezden yönetilecek.

---

## 🎯 Temel Felsefe

- Her şey birimdir. Her birim bağımsızdır. Ama hepsi birlikte sistemdir.
- Tüm uygulamalar (api, admin, shop, worker) yalnızca ihtiyaç duyduğu modülleri import eder.
- Modüller ve scriptler bağımsız paket gibi yönetilir.
- Ortak bağımlılıklar root seviyede toplanır.

---

## 📁 Klasör Yapısı

```
ttpanel/
├── apps/
│   ├── api/           → NestJS API
│   ├── admin/         → Nuxt 3 Admin Arayüzü
│   ├── shop/          → Nuxt 3 Müşteri Arayüzü
│   └── worker/        → BullMQ Queue İşleyicisi
├── modules/           → NestJS modülleri (tek package.json)
├── packages/          → Ortak bileşenler: ui, composables, utils, i18n
├── scripts/           → CLI komutları: mc, ms, mt, mr
├── config/            → Ortam, docker, ssl, vs.
├── docs/              → Rehberler, el kitapları
├── makefile           → Terminal-first CLI komutları
├── pnpm-workspace.yaml
├── package.json       → Root bağımlılıklar
└── .npmrc             → pnpm ayarları
```

---

## 🛠️ Yapılacaklar Listesi (TODO)

### 🔸 1. pnpm kurulumu
- [ ] `npm install -g pnpm`
- [ ] `.npmrc` dosyasına şu satırı ekle:
  ```
  shamefully-hoist=false
  ```

---

### 🔸 2. `pnpm-workspace.yaml` oluştur

```yaml
packages:
  - "apps/*"
  - "modules/*/*"
  - "packages/*"
  - "scripts/*"
```

---

### 🔸 3. `modules/` içinde `package.json` oluştur

```json
{
  "name": "@ttpanel/modules",
  "version": "0.0.1",
  "private": true,
  "exports": {
    "./*": "./*"
  }
}
```

---

### 🔸 4. `apps/api/package.json` güncellemesi

```json
{
  "dependencies": {
    "@ttpanel/modules": "*"
  }
}
```

Ayrıca `tsconfig.json` içinde:

```json
"paths": {
  "@modules/*": ["../../modules/*"]
}
```

---

### 🔸 5. `scripts/` içine `package.json` ekle

Her script klasörü (örnek: `module-create`) aşağıdaki gibi yapılandırılabilir:

```json
{
  "name": "@ttpanel/module-create",
  "version": "0.0.1",
  "bin": {
    "module-create": "index.ts"
  }
}
```

---

### 🔸 6. `packages/ui`, `packages/composables` vs. için `package.json` ekle

```json
{
  "name": "@ttpanel/ui",
  "version": "0.0.1",
  "exports": {
    ".": "./index.ts"
  }
}
```

Admin & Shop içinden kullanım:
```ts
import { BaseInput } from '@ttpanel/ui'
```

---

### 🔸 7. Dockerfile güncellemesi (örn: `api`)

```dockerfile
RUN corepack enable
RUN corepack prepare pnpm@latest --activate
RUN pnpm install
```

---

### 🔸 8. Makefile güncellemesi (örn: `make mc`)

```makefile
mc:
  pnpm ts-node scripts/module-create.ts path=...
```

---

### 🔸 9. Test altyapısı pnpm ile uyumlu hale getirilecek
- [ ] `pnpm test` tüm modülleri çalıştırmalı
- [ ] CLI komutları `pnpm tsx` ile çağrılmalı

---

### 🔸 10. Dönüşüm Tamamlandığında
- [ ] `gpt-meta.yaml > workspace`, `tech.tooling`, `modules.notes` alanları güncellenecek
- [ ] `sessions.yaml` dosyasına dönüşümün kaydı eklenecek
- [ ] `v0.1.0` → `v0.2.0` sürüm etiketiyle versiyonlanacak

---

## 📎 Ek Notlar

- `modules/` yalnızca backend modüllerini içerir
- `apps/*` uygulamaları bu modülleri doğrudan import eder
- Ortak bileşenler (UI vs.) `packages/` altında paylaşılır
- `pnpm` root düzeyinden yönetilir, her paket izole test edilebilir

---

Bu rehber dönüşüm boyunca referans alınmalıdır.  
Her adım tamamlandığında `docs/guide/monorepo-donusum-rehberi.md` güncellenmelidir.