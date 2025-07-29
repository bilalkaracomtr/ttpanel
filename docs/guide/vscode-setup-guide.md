---
title: "VSCode Kullanım Rehberi – TT Panel Geliştirici Ayarları"
description: "TT Panel projesinde verimli, tutarlı ve hızlı bir geliştirme deneyimi için özelleştirilmiş Visual Studio Code yapılandırma rehberi."
category: "Araç Rehberi"
tags: ["vscode", "editor", "ayarlar", "pratikler"]
icon: "🧰"
status: "active"
---

# 🧰 VSCode Kullanım Rehberi – TT Panel Geliştirici Ayarları

Bu rehber, TT Panel projesinde VSCode’u tam performansla kullanmak için hazırlanmıştır.
Hedef; kod kalitesini koruyan, üretim hızını artıran, takım uyumunu sağlayan bir kurulum yapısı sunmaktır.

---

## 🧭 1. VSCode Yapısı

| Bölüm              | Açıklama                                 |
|--------------------|------------------------------------------|
| **Explorer (sol)** | Dosya ağacı                              |
| **Editor (orta)**  | Kod yazma alanı                          |
| **Panel (alt)**    | Terminal, Çıktılar, Debug araçları       |

---

## ⚙️ 2. Ayarlar Paneli

- `Cmd + ,` → VSCode Ayarlarına eriş
- Ayarları hem görsel panelde hem de `.vscode/settings.json` içinde yapabilirsin

---

## 🧠 3. Temel Kısayollar

| Kısayol             | Açıklama                                 |
|---------------------|------------------------------------------|
| `Cmd + P`           | Dosya bul (hızlı geçiş)                  |
| `Cmd + Shift + F`   | Tüm projede metin arama                  |
| `Cmd + B`           | Sidebar aç/kapat                         |
| `Cmd + D`           | Aynı kelimeyi seç → çoklu düzenleme      |
| `Cmd + /`           | Satırı yorum satırı yap                  |
| `Option + Shift + ↓`| Satır çoğalt                             |
| `Cmd + \``          | Terminal panelini aç/kapat               |
| `Cmd + Shift + L`   | Aynı kelimeleri topluca seç              |
| `F2`                | Yeniden adlandır                         |

---

## 🚀 4. Komut Paleti

### `Cmd + Shift + P` ile erişilir. Bazı önerilen komutlar:

- `>Format Document`
- `>Git: Clone`
- `>Docker: Show`
- `>Preferences: Open Settings (JSON)`

---

## 🧰 5. .vscode/settings.json İçeriği

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "eslint.validate": ["javascript", "typescript", "vue"],
  "eslint.options": {
    "extensions": [".js", ".ts", ".vue"]
  },
  "tailwindCSS.includeLanguages": {
    "vue": "html"
  },
  "tailwindCSS.experimental.classRegex": [
    "class: '([^']*)",
    "class: \"([^\"]*)",
    "class=\\\"([^\\\"]*)\\\""
  ],
  "prettier.requireConfig": true,
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[yaml]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "files.insertFinalNewline": true,
  "files.trimTrailingWhitespace": true,
  "files.autoSave": "onFocusChange"
}
```

---

## 📦 6. .vscode/extensions.json Önerileri

```json
{
  "recommendations": [
    "prisma.prisma",
    "bradlc.vscode-tailwindcss",
    "vue.volar",
    "dbaeumer.vscode-eslint",
    "esbenp.prettier-vscode",
    "mikestead.dotenv",
    "eamodio.gitlens",
    "ms-azuretools.vscode-docker",
    "christian-kohler.path-intellisense",
    "wix.vscode-import-cost",
    "shd101wyy.markdown-preview-enhanced"
  ]
}
```

---

---

## 🐳 7. Terminal ve Makefile Komutları

TT Panel projesinde terminalden çok sık çalışacaksın. Aşağıdaki komutlar `Makefile` içinde tanımlıdır:

| Komut         | Açıklama                                                  |
|---------------|-----------------------------------------------------------|
| `make up`     | Docker ortamını başlatır (traefik, api, admin, db vs.)   |
| `make reset`  | Sistemi sıfırlar (volume siler, yeniden kurar)            |
| `make seed`   | Örnek verilerle veritabanını doldurur (`prisma db seed`) |
| `make logs`   | Tüm servislerin loglarını birlikte izler                  |
| `make db`     | PostgreSQL container’ına doğrudan bağlanır (`psql`)       |

> 🎯 **Tavsiye**: Terminal ekranını `Cmd + \`` ile aç, `Cmd + \` ile böl, logları bir ekranda, kodu diğerinde izle.

---

## 🔍 8. GitLens ile Git Geçmişi Takibi

`GitLens`, kod üzerinde kim ne zaman neyi değiştirdi, bunu kolayca görmeni sağlar.

- Dosya içinde bir satıra geldiğinde sağ tarafta son commit bilgisi görünür
- Sağ tık → `Show File History` → dosyanın geçmiş değişimlerini listeler
- `Cmd + Shift + G` → Git commit alanını açar (kendi commit’lerini yazmak için)

---

## 🧼 9. Markdown Önizleme

Markdown dökümanlarını `preview` modunda görselleştirmek için:

- Sağ üstte `Open Preview` ikonuna tıkla
- Alternatif olarak `Cmd + Shift + V`
- `shd101wyy.markdown-preview-enhanced` yüklüyse TOC (içindekiler), çizim ve not kutuları da desteklenir

---

## ✨ 10. Önerilen Kişisel Ayarlar (İsteğe bağlı)

```json
{
  "editor.cursorSmoothCaretAnimation": true,
  "editor.minimap.enabled": false,
  "workbench.startupEditor": "none",
  "workbench.colorTheme": "Default Dark Modern"
}
```

> Daha sade, hızlı ve karanlık bir geliştirme deneyimi için bu ayarlar önerilir.

---

## 🛠️ Geliştirme Notu
> Bu rehber ileride `terminal alias`, `zsh`, `oh-my-zsh`, `scripts/` klasörü gibi konularla genişletilebilir.

## ✍️ Kapanış Notu
> Bu dosya TT Panel projesinde geliştiricilerin VSCode'u ortak ayarlarla, tutarlı ve hızlı kullanabilmesi için oluşturulmuştur.
> Ayarlar, eklenti önerileri ve terminal komutları projenin teknik mimarisi ile birebir uyumludur.
>
>
