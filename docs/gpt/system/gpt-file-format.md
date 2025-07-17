---
title: "Dosya Biçimi ve Yapı Kuralları – GPT Sistemi"
description: "Bu dosya, tüm GPT tabanlı projelerde kullanılan dosyaların yapısal biçimini ve önerilen alanlarını tanımlar."
category: "GPT"
tags: ["format", "dosya yapısı", "standart"]
icon: "📂"
status: "active"
---

# 📂 Dosya Biçimi ve Yapı Kuralları – GPT Sistemi

Bu dosya, GPT destekli tüm projelerde kullanılacak dosya biçimini ve içerik yapısını tanımlar.  
Amaç: GPT’nin içerikleri doğru okuyup işleyebilmesini ve üretim sürecinin tutarlı ilerlemesini sağlamaktır.

---

## 1️⃣ YAML Üst Bilgi (Zorunlu)

> **Not:** `session` dosyaları (`docs/gpt/sessions/YYYY.MM.DD.md`) bu kuralın istisnasıdır.  
> Bu tür dosyalarda YAML üst bilgisi yer almaz; içerik doğrudan `#` başlık ile başlar.

Tüm `.md` dosyalarının başında şu YAML yapısı yer almalıdır:

```yaml
---
title: "..."            # Dosya başlığı
description: "..."      # Kısa açıklama
category: "..."         # Tür (örn: Planlama, Bellek, Sistem)
tags: ["...", "..."]    # Anahtar kavramlar
icon: "..."             # Emoji / simge – isteğe bağlı
status: "..."           # active, developing, planned, delayed, archived
---
```

### `status` alanı için geçerli değerler:

| Değer        | Anlamı                                       |
|--------------|-----------------------------------------------|
| `planned`    | Henüz yazılmadı, fikir veya niyet aşamasında  |
| `developing` | Yazılıyor, geliştiriliyor                     |
| `active`     | Tamamlandı ve kullanılabilir                  |
| `delayed`    | Yazımı ertelendi, şimdilik beklemede          |
| `archived`   | Artık kullanılmayan ama saklanan içerik       |

---

## 2️⃣ Dosya İsimlendirme

- Dosyalar açık, düz okunabilir formatlarda olmalıdır  
- Kabul edilen uzantılar: `.md`, `.yaml`, `.json`, `.csv`  
- `.md` dosyaları için bu dosyadaki tüm kurallar geçerlidir  
- Diğer dosyalar (yaml/json/csv) yalnızca içerik yapısı bakımından uyumlu olmalıdır

### Dosya önekleri:

| İçerik Türü           | Önek      | Örnek                          |
|-----------------------|-----------|--------------------------------|
| Bellek Dosyası        | memory-   | memory-profile.md              |
| GPT Dosyası           | gpt-      | gpt-identity.md                |
| İçerik ve Fikirler    | content-  | content-topics.md              |
| Arşiv Dosyaları       | archive-  | archive-index.md               |

---

## 3️⃣ Klasör Standartları

Her proje en az şu iki dosyayı içermelidir:

- `gpt-identity.md` → GPT’nin davranış kuralları  
- `memory.md` → Proje belleği (GPT'nin bağlamsal hafızası)  

> `README.md` dosyası artık zorunlu değildir. İsteğe bağlı olarak yalnızca insan referansı için eklenir.

Proje yoğunluğuna göre alt klasör yapısı oluşturulabilir.

---

## 4️⃣ Emoji / Simge Kullanımı

`icon:` alanı, dosyanın bağlı olduğu klasöre göre sezgisel bir emoji içermelidir.

| Klasör   | Emoji |
|----------|--------|
| memory   | 🧠     |
| gpt      | 🤖     |
| content  | ✍️     |
| archive  | 🗃️     |

> Emoji zorunlu değildir, ancak sezgisel sınıflama ve arayüz farkındalığı için önerilir.

---

## 5️⃣ Başlık Yapısı

Tüm dosyalar hiyerarşik ve işlevsel başlıklarla yapılandırılmalıdır.

### `#` → 1. Seviye Başlık

- Dosyanın kimliğini ve işlevini belirtir  
- Sadece bir kez kullanılır

```markdown
# 🧠 Kişisel Hedef Haritası – Bilal Kara
```

### `##` → 2. Seviye Başlık

- Ana bölümleri tanımlar  
- GPT bu bölümleri içerik blokları olarak işler

```markdown
## 🎯 Yaşam Amacım
## 📚 Öğrenme Alanları
```

### `###` → 3. Seviye Başlık

- Alt kategoriler için kullanılır  
- `####` ve sonrası kullanılmaz

```markdown
### 🧠 Teknik Öğrenme
### 🔹 Devreden Görevler
```

> **Not:** Başlıklar kısa, açıklayıcı ve tekrar etmeyen şekilde yazılmalıdır.  
> Örn: Her dosyada “## Bugün” gibi tekrar eden başlıklar yerine  
> “## 🔍 Bugünkü İnceleme” gibi ayırt edici ifadeler tercih edilmelidir.

---

## 6️⃣ Biçim Kuralları

### ✅ Görev Listesi

```markdown
- [ ] Görev açıklaması  
- [x] Tamamlanmış görev  
```

### 📋 Tablo

```markdown
| Alan | Açıklama |
|------|----------|
| X    | Y        |
```

### ❓ Soru Listesi

```markdown
- Bugün neyi iyi yaptım?  
- Hangi alışkanlığı destekledim?
```

### 💬 GPT Satır İçi Notları

```html
<!-- GPT NOTU: Bu dosya haftalık olarak özetlenmeli. -->
```

> Bu yorumlar GPT için içsel bağlam sağlar, kullanıcıya gösterilmez.

---

## 7️⃣ Zorunlu Kapanış Bölümleri

> **Not:** `session` dosyaları (`docs/gpt/sessions/YYYY.MM.DD.md`) bu kuralın istisnasıdır.  
> Bu tür dosyalarda kapanış bölümleri zorunlu değildir; içerik doğrudan madde madde yazılır.

Her dosyanın en sonunda aşağıdaki iki bölüm yer almalıdır:

```markdown
## 🛠️ Geliştirme Notu
> Dosyanın eksik, geliştirilecek veya genişletilecek yönleri

## ✍️ Kapanış Notu
> Dosyanın amacı, bağlamı ve kullanıcı ile ilişkisi
```

> Bu bölümler GPT’ye içerik sürdürülebilirliği ve üretim zihniyeti hakkında bilgi verir.  
> Eyleme geçilmez ama bağlamsal olarak değerlendirilir.

---

## 8️⃣ Session Dosyaları (Oturum Formatı)

GPT destekli projelerde her üretim günü, `docs/gpt/sessions/YYYY.MM.DD.md` biçiminde bir dosya olarak kaydedilir.  
Bu dosyalar, günlük üretim çıktısını ve yapılan işlemleri kayıt altına alır.

### 📁 Konum ve İsimlendirme

- Konum: `docs/gpt/sessions/`  
- Format: `YYYY.MM.DD.md`  
- Her dosya `memory.yaml > timeline.session` ile eşleşmelidir  
- Dosya adı `timeline.session`, başlığı `timeline.title`, içeriği `timeline.logs` özetinden oluşur

### 📄 İçerik Yapısı

- Session dosyalarında **YAML üstbilgi yer almaz**  
- İçerik doğrudan `#` başlığı ile başlar  
- Her oturumda yapılan işler, kararlar, güncellemeler ve eklenen dosyalar net biçimde madde madde yazılır  
- Bu dosyalar geçmişe dönük takip için kullanılır; `todo` veya `planlı görev` içermez  
- Her dosya sonuna opsiyonel olarak "⏭️ Sonraki Adım" bölümü eklenebilir

### 🧩 Örnek Şablon

```markdown
# 📅 [Başlık] – [Günün Özeti]

---

## 🧠 [1. Blok Başlığı – Örneğin: Hafıza / Sistem / Planlama]

- Yapılan temel değişiklikler  
- Tartışılan teknik kararlar  
- Güncellenen dosya ya da alanlar

---

## 🛠️ [2. Blok Başlığı – Örneğin: Dosya / Yapı / Güncelleme]

- Düzenlenen teknik sistemler veya klasörler  
- Güncellenen içerik yapısı  
- Dosya sistemine bağlanan kayıtlar

---

## 📂 [3. Blok Başlığı – Eklenen / Taşınan Dosyalar]

| Dosya               | Açıklama / Amaç                              |
|---------------------|----------------------------------------------|
| `example.md`        | Açıklama                                     |
| `memory.yaml`       | `working_state` ve `timeline` güncellendi    |

```

## 🧭 Kullanım İlkeleri

- Desteklenen dosya türleri: `.md`, `.yaml`, `.json`, `.csv`  
- `.md` dosyaları bu belgeye tam uyumlu olmalıdır  
- Diğer dosyalar içeriksel olarak bu yapıya paralel geliştirilmelidir  
- Dosya dili Türkçe olmalı, içerik sade ve net yazılmalıdır  
- Her proje yalnızca kendi dosyalarını kullanmalı; ortak sistem dosyaları yalnızca `system/` içinde yer almalıdır

---

## 🛠️ Geliştirme Notu
> Bu dosya ileride örnek senaryo dosyaları ile desteklenebilir.  
> GPT için `yaml` ve `json` uyarlamaları hakkında not bölümleri eklenebilir.

## ✍️ Kapanış Notu

> Bu dosya yalnızca teknik bir rehber değil; **üretim ritmini tanımlayan bir dil kılavuzudur.**  
> GPT’nin seni anlayabilmesi, dosyanın seni temsil edebilmesi için bu biçim korunmalıdır.  
> Sadelik düzen getirir, düzen üretkenliği doğurur.
