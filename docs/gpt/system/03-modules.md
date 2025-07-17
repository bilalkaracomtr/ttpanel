---
title: "Modül Planlaması – TT Panel"
description: "Tüm modüllerin sistematik yapısı, kullanım amacı ve teknik bağı"
category: "Mimari"
tags: ["modül", "gruplama", "sistem mimarisi", "API-first", "test"]
icon: "🧩"
status: "active"
---

# 🧩 Modüler Yapı Planlaması

TT Panel’in tüm sistem mimarisi, bu belgede tanımlanan modül yapısı üzerine kuruludur.  
Her modül; kendi veri modeli, API servisi, arayüz bileşeni, test yapısı ve erişim kontrolü ile birlikte tanımlanır.  
Modüller işlevsel gruplar hâlinde gruplanır (`commerce`, `system`, `automation`, `content`, `integration`)  
ve gerektiğinde mikroservislere ayrılabilecek biçimde izole kurgulanır.  
Bu belge, tüm teknik üretim, erişim mimarisi ve test sisteminin temelini oluşturur.

---

## 🔧 Temel Modül Kavramı

TT Panel, hem e-ticaret hem de iç operasyon süreçlerini yöneten **tamamen modüler bir sistem** olarak kurgulanmıştır.  
Her modül bağımsız çalışabilen, ihtiyaç hâlinde mikroservise dönüşebilecek şekilde yapılandırılmıştır.

Her modül:

- Kendi veri modeline sahiptir  
- API-first yaklaşımıyla servis edilir  
- Yetki bazlı erişim kontrolü içerir  
- Frontend ile entegre olacak şekilde, her modül kendi DTO (veri aktarım nesneleri), i18n (çok dilli içerik) ve UI (form, liste, bileşen) yapılarını içerir
- Mock veri + test desteklidir (unit, integration, e2e)  
- Gerektiğinde Docker ortamına özel olarak izole edilebilir

---

## 🛒 E-Ticaret Modülleri (`modules/commerce`)

TT Panel'in e-ticaret altyapısı dört ana modül grubundan oluşur:

### 1. 📦 Katalog Modülleri (`catalog/`)
Ürünlerin, kategorilerin, varyantların ve stokların yönetildiği alandır.

- `product` – Ürün tanımı, açıklama, fiyat, ilişki
- `category` – Hiyerarşik kategori yapısı, SEO, kampanya ilişkisi
- `brand` – Marka bilgisi, açıklama, logo
- `supplier` – Tedarikçi tanımları
- `variant` – Renk, beden gibi varyasyonlar
- `stock` – Stok sayısı, lokasyon, rezervasyon
- `attribute` – Özellik tanımları (örnek: materyal, ebat)
- `unit` – Ölçü birimi tanımları
- `tag` – Etiketleme sistemi
- `collection` – Koleksiyon yapıları
- `price` – Çoklu fiyat tanımları
- `file` – Ürün görselleri ve dosyaları
- `barcode` – Barkod eşlemeleri

📌 **Grup Özeti:**
> Katalog modülleri, ürünlerin sınıflandırılması, stok takibi, görsel ve fiyatlandırma gibi temel katalog yönetimi süreçlerini kapsar.  
> Tüm ticaret yapısının çekirdeğini oluşturur ve diğer gruplarla doğrudan ilişkilidir.

---

### 2. 📬 Sipariş Modülleri (`order/`)
Sepet, ödeme, fatura ve kargo süreçlerini kapsar.

- `cart` – Sepet sistemi (misafir + kayıtlı kullanıcı)
- `order` – Sipariş yönetimi
- `payment` – Ödeme yöntemleri ve adımları
- `transaction` – Ödeme sağlayıcı dönüşleri (örnek: iyzico)
- `shipment` – Kargo bilgileri
- `invoice` – Fatura oluşturma
- `return` – Ürün iade süreci
- `note` – Siparişe özel notlar
- `status` – Sipariş durumları
- `history` – Durum geçmişi ve işlem kayıtları

📌 **Grup Özeti:**
> Sipariş yönetimi, faturalama, kargo ve iade gibi ticari işlemleri içerir.  
> E-ticaretin satış sonrası sürecini teknik olarak temsil eder.

---

### 3. 👤 Müşteri Modülleri (`customer/`)
Üyelik, adres, yorum, puanlama gibi müşteri ile ilişkili modüllerdir.

- `customer` – Üyelik ve profil bilgisi
- `address` – Teslimat ve fatura adresleri
- `group` – Müşteri grupları (B2B, bayi, kurumsal vs.)
- `wishlist` – Favori listeleri
- `review` – Yorumlar
- `point` – Puan/ödül sistemi
- `consent` – KVKK onay yönetimi
- `contact` – İletişim bilgileri
- `login-history` – Giriş logları
- `notification` – Müşteriye özel bildirimler
- `return-request` – İade talepleri
- `activity` – Davranışsal veri logları (isteğe bağlı)

📌 **Grup Özeti:**
> Müşteriyle ilgili tüm veri ve işlemler bu grupta toplanır.  
> Kayıt, adres, geri bildirim, davranış analizi gibi kullanıcı ilişkileri bu modüller üzerinden yürütülür.

---

### 4. 📣 Pazarlama Modülleri (`marketing/`)
Dönüşüm, kampanya, kupon, analiz, SEO ve banner sistemlerini kapsar.

- `campaign` – Zamanlı kampanyalar
- `coupon` – Kupon kodları
- `promotion` – Anasayfa ve kategori promosyonları
- `referral` – Tavsiye sistemi
- `seo` – Sayfa bazlı SEO ayarları
- `analytics` – Görüntülenme, tıklama, dönüşüm takibi (GA4, Pixel vb.)
- `event` – Eylem tetikleyicileri (örn: sepete ekle, ödeme tamamla)
- `utm` – UTM parametre takibi (kaynak – medium – kampanya)
- `conversion` – Facebook CAPI ile dönüşüm verisi gönderimi
- `merchant` – Google Merchant Center ürün feed entegrasyonu
- `banner` – Kampanya görselleri
- `popup` – Ziyaretçi popup yönetimi

📌 **Grup Özeti:**
> Kampanya, analiz, dönüşüm ve pazarlama sistemlerini kapsar.  
> GA4, Pixel, CAPI, UTM gibi ölçüm sistemleri ile satış takibi yapılmasını sağlar.  
> Merchant entegrasyonu ile ürün yayınları otomatikleştirilebilir.

---

Bu yapı, tüm e-ticaret sisteminin çekirdeğini oluşturur.  
Her grup kendi içinde modülerdir ve mikroservisleştirilebilir.

---

## 📚 İçerik Modülleri (`modules/content`)

TT Panel'deki tüm bilgi sunumu, sayfa içeriği ve görsel düzen modülleri bu grupta yer alır.  
Panelde "İçerik Yönetimi" sekmesi altında gösterilir.

- `page` – Statik sayfalar (Hakkımızda, KVKK, İade Politikası)
- `blog` – Blog yazıları, arşiv, yazar
- `faq` – Sık sorulan sorular (kategori destekli)
- `testimonial` – Müşteri yorumları, referanslar
- `portfolio` – Proje örnekleri, galeri sunumu
- `media` – Ortak medya dosyaları (resim, belge, video)
- `slider` – Ana sayfa slayt alanları (görsel + başlık + buton)
- `section` – Sayfa düzeni blokları (özelleştirilebilir içerik)
- `form` – İletişim ve teklif formları
- `video` – YouTube, Vimeo gibi embed video alanları

📌 **Grup Özeti:**
> Sayfa, blog, slider, galeri ve içerik blokları gibi tüm görsel/kelimesel sunum modüllerini barındırır.  
> Frontend katmanının içerik tarafını yönetir.

Her modül:

- Admin panelden düzenlenebilir  
- Çok dilli içerik yönetimini destekler  
- SSR/SPA frontend arayüzleriyle uyumludur  
- Dosya yönetimi `media/` modülü ile ortaklaşa çalışır

---

## ⚙️ Sistem Modülleri (`modules/system`)

TT Panel’in kullanıcı, yetki, ayar ve sistem davranışlarını yöneten çekirdek modül grubudur.  
Bu grup 4 ana kategoriye ayrılır:

---

### 1. 🔐 Erişim ve Kimlik (`access/`)

- `auth` – Giriş, çıkış, şifre yenileme
- `user` – Kullanıcı profili ve ayarları
- `role` – Yetki rolleri
- `permission` – Rol bazlı izinler
- `token` – API ve session token yönetimi
- `profile` – Kullanıcının kendi ayar alanı

---

### 2. ⚙️ Yapılandırma Ayarları (`config/`)

- `settings` – Site ayarları (isim, logo, para birimi vs.)
- `theme` – Tema seçenekleri (renk, dark/light)
- `language` – Dil seçenekleri
- `config` – Geliştiriciye özel sistem konfigürasyonları
- `maintenance` – Bakım modu, bakım ekranı

---

### 3. 🔔 Bildirim ve Bilgilendirme (`notify/`)

- `notification` – Sistem bildirimleri
- `announcement` – Duyurular
- `changelog` – Sürüm geçmişi, yeni özellikler

---

### 4. 📜 Kayıt ve İzleme (`log/`)

- `log` – Sistemsel olay kayıtları

---

Her modül:

- Admin panelin altyapı ayarlarını ve erişim kontrolünü sağlar  
- Geliştiriciler için özelleştirilebilir davranışlar içerir  
- UI, erişim, ayar ve bildirim yapılarının temelini oluşturur

Bu grup olmadan TT Panel çalışmaz.  
**Tüm sistemin kontrol merkezi burasıdır.**

📌 **Grup Özeti:**
> Erişim, ayar, bildirim ve sistem davranışlarını yöneten çekirdek modüllerdir.  
> Bu grup olmadan panel ve API çalışamaz. Her modül sistemsel bütünlüğe hizmet eder.

---

## 🛠️ Otomasyon Modülleri (`modules/automation`)

TT Panel’in iç operasyonlarını yöneten otomasyon modülleridir.  
Üretimden muhasebeye, görevden takvime kadar her süreç bu grupta tanımlanır.

---

### 🔨 Üretim & Görev Yönetimi

- `production` – Siparişe bağlı üretim ve üretim adımları
- `task` – Personel görevleri (öncelik, durum, atama)
- `checklist` – Göreve bağlı yapılacaklar listesi
- `workflow` – İş akışları, kural tabanlı süreçler

---

### 💰 Finans & Faturalama

- `billing` – Fatura üretimi ve sipariş eşlemesi
- `expense` – Gider girişleri ve kategorileri
- `cash` – Nakit giriş-çıkış yönetimi
- `bank` – Banka hareketleri ve bakiye eşleşmeleri
- `accounting` – Genel muhasebe ve entegrasyonlar (örn: Mikro)

---

### 🤝 CRM & İletişim

- `crm` – Müşteri ilişkileri, notlar, etkileşim geçmişi
- `message` – Mesajlaşma altyapısı (e-posta, whatsapp, DM)
- `ticket` – Destek talepleri, durum takibi
- `follow-up` – Takip planı, müşteri dönüş sistemleri

---

### 📆 Zamanlama & Hatırlatma

- `schedule` – Üretim/görev bazlı zamanlama
- `calendar` – Takvim tabanlı görev ve randevu görünümü
- `reminder` – Zamanlanmış hatırlatma sistemleri

---

### 📊 Süreç ve Verimlilik

- `insight` – İç verimlilik, süreç takibi ve raporlama

---

Bu grup sayesinde sipariş sonrası tüm operasyonlar sistematik hâle gelir.  
Gelecekte `automation/` yapısı kendi mikroservisine kolaylıkla ayrılabilir.

📌 **Grup Özeti:**
> Üretimden finansa, görevden takvime kadar iç operasyonların tümü bu grupta tanımlanır.  
> Gelecekte mikroservisleşmeye en uygun gruptur.

---

## 🔌 Entegrasyon Modülleri (`modules/integration`)

TT Panel'in dış servislerle haberleşmesini sağlayan modüllerdir.  
Veri gönderimi/alımı, fatura paylaşımı, sipariş senkronizasyonu, mesaj gönderimi gibi entegrasyonları yönetir.

---

### 🧾 Muhasebe & Finans

- `mikro` – Mikro Yazılım entegrasyonu (stok, cari, fatura)
- `parasüt` – Online ön muhasebe bağlantısı
- `logo` – Logo Tiger/Go sistemleri ile eşleşme
- `e-invoice` – E-fatura API (GIB, özel entegratörler)

---

### 🛍️ Pazaryeri & E-Ticaret

- `trendyol` – Ürün ve sipariş senkronizasyonu
- `n11` – N11 pazaryeri API entegrasyonu
- `hepsiburada` – Hepsiburada bağlantısı (planlı)
- `etsy` – Uluslararası satış senkronizasyonu
- `amazon` – Amazon global API bağlantısı

---

### 🚚 Kargo & Teslimat

- `yurtici` – Gönderi ve takip entegrasyonu
- `aras` – Aras Kargo API
- `ship-integrator` – Çoklu kargo yönetimi (MNG, Sürat, UPS, vs.)

---

### 💬 Bildirim Sistemleri

- `smtp` – E-posta gönderimi
- `sms` – SMS API sağlayıcıları (Netgsm, Twilio, vs.)
- `whatsapp` – WhatsApp Business veya Gateway bağlantısı
- `slack` – Slack kanal bildirimleri

---

### 🌐 Webhook ve API Tüketimi

- `webhook` – Gelen/giden webhook yönetimi
- `api-client` – Dış sistemlere veri gönderimi
- `api-provider` – Dış sistemlerden veri alımı (TT Panel'e)

---

Her modül:
- Adapter mantığıyla izole yazılır  
- Log, retry, timeout gibi wrapper sistemlerine sahiptir  
- Her biri bağımsız servis veya gateway ile haberleşebilir  
- Ortak konfigürasyonlar `system/config` veya `.env` üzerinden sağlanır

Bu grup, TT Panel’in dış dünya ile senkron ve otomatik çalışmasını sağlar.

📌 **Grup Özeti:**
> TT Panel’in dış dünyayla bağlantı kurduğu tüm entegrasyonlar burada yer alır.  
> Pazaryeri, muhasebe, bildirim ve veri servisleri bu yapının içindedir.  
> Adapter mantığı ile çalışır, log + retry sistemlerine entegredir.

---

## 🧩 Modüler Yapı Özeti

TT Panel, e-ticaret ve otomasyon ihtiyaçlarını karşılayan **5 ana modül grubuna** sahiptir:

1. **commerce/** → Ürün, sipariş, müşteri ve pazarlama sistemleri  
2. **content/** → Sayfa içerikleri, blog, medya ve içerik blokları  
3. **system/** → Erişim, kullanıcı, ayar, bildirim ve log altyapısı  
4. **automation/** → Görev, üretim, crm, takvim, finansal süreçler  
5. **integration/** → Harici API bağlantıları, pazaryeri, muhasebe, kargo sistemleri

---

## 🧠 Geliştirme Notları

- Her modül `modules/<grup>/<modül>/` altında konumlanır  
- Her modül bağımsız `controller`, `service`, `dto`, `entity`, `repository` yapısına sahiptir  
- `test/`, `policy/`, `guard/`, `i18n/`, `config.ts` gibi yapılar modül içinde yer alabilir  
- Panel menüsü bu gruplara göre yapılandırılır  
- Her grup ileride ayrı mikroservis olarak ayrıştırılabilir  
- Ortak yapılar `packages/` içinde toplanır  
- Ortam konfigürasyonları `config/env/` ve `services/` ile desteklenir

## 🧭 Geliştiriciye Not

> Bu dosyada tanımlanan tüm modüller, kendi içinde izole çalışacak şekilde yapılandırılır.  
> Her modül, standart dizin yapısına (controller, service, dto, entity, test, config) sahip olmalıdır.  
> Panel arayüzü, i18n destekli frontend bileşenleri ile entegre şekilde çalışır.  
> `modules/` altındaki her grup gerektiğinde bağımsız mikroservise dönüştürülebilir.

---

## ✍️ Kapanış Notu

Bu belge, TT Panel’in modül mimarisini sabitler ve tüm teknik üretimin zeminini oluşturur.  
Her modül bu plana uygun şekilde açılır, test edilir, versiyonlanır ve dökümante edilir.

TT Panel'de:

> **Her modül birimdir. Her birim bağımsızdır. Ama hepsi birlikte sistemdir.**