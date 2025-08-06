---
title: "TT Panel – Git Sistemi ve Sprint Akışı"
description: "TT Panel için Git, GitHub kullanımı, branch yönetimi, commit kuralları ve SSH bağlantı rehberi"
category: "Versiyon Kontrolü"
tags: ["git", "github", "feature branch", "commit", "ssh"]
icon: "🌿"
status: "active"
---

# 🌿 TT Panel – Git Sistemi ve Sprint Akışı

---

## 📸 Snapshot Nedir?

- `Snapshot`: İngilizce’de “anı yakalama”, “fotoğrafını çekme”.
- Git’te her `commit`, projenin o anki halinin bir **fotoğrafını (snapshot)** alır.
- Geçmişe dönmek (`checkout`, `revert`) bu sayede mümkündür.
- Git verimli çalışmak için değişmeyen dosyaları delta (fark) olarak işler.

---

## 🌿 main → feature → main Yapısı

### 🎯 Neden sadece `main` kullanmıyoruz?

- `main`, daima yayınlanabilir, **stabil** kodları tutar.
- Sprint boyunca kod geliştirme süreci izole edilmelidir.
- Böylece:
  - `main` bozulmaz
  - Hatalı bir sprint geri alınabilir
  - GPT üretimi branch bazında izlenebilir

### 🧱 Git Branch Mantığı:

```bash
# main'den üretim branch'i oluştur
git checkout main
git checkout -b feature/sprint_1-auth-system

# geliştirme burada yapılır

# sonra merge edilir
git checkout main
git merge feature/sprint_1-auth-system
git branch -d feature/sprint_1-auth-system
```

### 🧩 Sprint Odaklı Branch Örnekleri:

| Sprint No | Branch Adı                        | Açıklama                     |
|-----------|-----------------------------------|------------------------------|
| 1         | feature/sprint_1-auth-system      | Auth sistemi kurulumu        |
| 2         | feature/sprint_2-product-catalog  | Ürün katalog modülleri       |
| 3         | feature/sprint_3-customer-core    | Müşteri işlemleri            |

---

## ✅ Conventional Commit Kuralları

### 🧠 Ezber: **FİÇ TAD**  
(Fİx – Chore – Test – Auth – Docs)

| Prefix      | Anlamı                                      |
|-------------|----------------------------------------------|
| `feat:`     | Yeni bir özellik (feature)                  |
| `fix:`      | Hata düzeltmesi                            |
| `chore:`    | Linter, env, script, log gibi altyapı işleri |
| `test:`     | Test dosyası veya test düzeltmesi          |
| `docs:`     | README, dökümantasyon düzenlemesi           |
| `refactor:` | Davranışı değiştirmeyen kod değişikliği    |
| `style:`    | Boşluk, format, yorum gibi stil düzeltmeleri|

### Örnekler:

```bash
feat: auth modülü eklendi
fix: login hatası düzeltildi
chore: .gitignore dosyası eklendi
docs: README güncellendi
test: user servisi için unit test eklendi
```

---

## 🧹 chore: Ne Demek?

- chore = “rutin iş”, “angarya”, “teknik altyapı”
- Özellik barındırmayan ama gerekli teknik işlemler için kullanılır.

### Örnek `chore` commit'leri:

```bash
chore: eslint yapılandırması yapıldı
chore: .env dosyası eklendi
chore: tailwind kurulumu yapıldı
```

---

## 🔐 SSH Key Oluşturma (GitHub Bağlantısı)

```bash
ssh-keygen -t ed25519 -C "bilalkaracomtr"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

- Son adımda çıkan public key → GitHub > Settings > SSH and GPG Keys > New SSH Key
- Başlık: `MacBook M2 Pro`

---

## 🚀 GitHub Kurulumu – Adım Adım

```bash
git init
git add .
git commit -m "feat: proje başlatıldı"
git branch -M main
git remote add origin git@github.com:bilalkaracomtr/ttpanel.git
git push -u origin main
```

---

## 🗃️ .gitignore Örneği

```gitignore
node_modules/
dist/
.env
.env.*
*.log
.DS_Store
.idea/
.vscode/
coverage/
```

---

## 🧠 Kapanış Notu

> TT Panel’de Git; sadece versiyon kontrolü değil, **sprint hafızası**dır.  
> `main → feature/sprint_x-... → main` akışı;  
> izlenebilir, test edilebilir ve geri alınabilir bir üretim süreci sağlar.  
> GPT üretimi, bu branch yapısıyla sprint-temelli sürdürülebilir hale gelir.