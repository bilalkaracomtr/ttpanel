---
title: "Üretim Sürdürülebilirliği ve GPT Takip Kuralları"
description: "TT Panel projesinde GPT üretiminin oturumdan bağımsız yürütülebilmesi için gerekli sistematik tedbirler."
category: "Sistem"
tags: ["gpt", "hafıza", "süreklilik", "takip", "üretim"]
icon: "🔒"
status: "active"
---

# 🔒 GPT Üretim Sürdürülebilirliği – Takip ve Geri Çağırma Protokolü

Bu belge, TT Panel projesinde GPT ile yapılan üretimlerin oturum sınırlarından etkilenmeden sürdürülebilmesini sağlamak için uygulanması gereken 5 temel tedbiri tanımlar.  
Her sprintte bu kurallar gözetilirse, GPT kaldığı yerden üretime devam edebilir.

---

## ✅ 1. `memory.yaml` Güncellemeleri

Her sprintin sonunda `memory.yaml` içinde şu üç alan mutlaka güncellenmelidir:

- `timeline:` → Ne zaman ne üretildi?
- `working_state:` → Hangi sprint aktif? Hangi görevdeyiz?

**📝 Örnek:**

    - 2025-07-15:
        - Sprint 1 tamamlandı. Auth modülleri üretildi. Docker çalışıyor.
    working_state:
      status: building
      focus: "Sprint 2 – Ürün Kataloğu"
      sprint: sprint_2

---

## ✅ 2. Üretim Dosyalarını Git’e Push Et

Üretilen her dosya (kod, yapı, test) Git ile versiyonlanmalı ve gönderilmelidir.  
GPT Git kullanamaz ama senin commit geçmişin üzerinden hangi dosyalar üretildiğini anlayabilir.

**🛠️ Örnek Git komutu:**

    git add modules/system/access/auth/auth.entity.ts
    git commit -m "feat: auth entity oluşturuldu"
    git push origin main

Yeni bir oturumda şöyle diyebilirsin:  
**“GPT, auth.entity.ts dosyasını push ettim. Şimdi DTO'ya geçelim.”**

---

## ✅ 3. GPT’ye “Geri Çağırma Notu” Bırak

Uzun oturumlar arasında neyin tamamlandığını, neyin kaldığını hatırlamak için küçük notlar bırakılır.  
Bu notlar hem konuşma içinde hem de `memory.yaml > notes:` alanında yer alabilir.

**🧠 Örnek:**

    notes:
      - Sprint 2 yarıda kaldı. `variant` modülünün DTO'su eksik.

Bu not sayesinde yeni oturum başladığında GPT şu şekilde devam edebilir:  
**“Son notlara göre `variant.dto.ts` üretilecek.”**

---

## ✅ 4. Önemli Cevapları `.md` Olarak Kaydet

GPT'nin verdiği planlama, açıklama, rehber ya da uzun cevaplar `.md` dosyalarına kaydedilmelidir.  
Böylece konuşma kapanınca bu değerli içerikler kaybolmaz.

**📂 Önerilen klasör yapısı:**

    docs/
    └── gpt-output/
        ├── sprint1-auth-plan.md
        ├── docker-setup-notes.md

Kod dosyaları `.ts`, `.vue`, `.yaml` biçiminde uygun dizinlere (`modules/`, `apps/`, `config/` vb.) eklenmelidir.

---

## ✅ 5. Üretimi Parçalı Yap – *Atomic Units*

Modül üretimi küçük ve tamamlanabilir birimlere ayrılarak yapılmalıdır.  
Bu yöntem sayesinde oturum yarıda kalsa bile üretim kaybolmaz.

**🔹 Parçalama önerisi:**

    📦 auth/
    ├── auth.entity.ts
    ├── auth.dto.ts
    ├── auth.service.ts
    ├── auth.controller.ts

Her adımda sadece bir dosya üretilir, commit edilir, test edilir.

---

## ✍️ Kapanış Notu

> Bu belge, GPT ile yapılan teknik üretimin sürdürülebilirliğini sağlamak için oluşturulmuştur.  
> Her sprint sonunda bu kurallar uygulandığında üretim kaybolmaz, tekrar gerekmez, sistemli ilerler.

Bugün yaptıklarımız:
- TT Panel projesinde GPT üretiminin oturumdan bağımsız yürütülebilmesi için gerekli sistematik tedbirler konusu üzerinde seninle tartıştık ve production-guide.md dosyası oluşturduk. Dosyayı eke ekliyorum.

- Daha sonra seninle memory.yaml üzerine konuştuk. Çok yoğun bir timeline olduğunu, mode alanın gereksiz olduğunu