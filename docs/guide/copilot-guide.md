---
title: "GitHub Copilot Kullanım Rehberi – TT Panel"
description: "TT Panel geliştirme sürecinde GitHub Copilot’tan en yüksek verimi almak için kullanım örnekleri, kısayollar ve senaryo tabanlı yönlendirmeler."
category: "Araç Rehberi"
tags: ["copilot", "vscode", "ai", "yardımcı araçlar"]
icon: "🤖"
status: "active"
---

# 🤖 GitHub Copilot Kullanım Rehberi – TT Panel

Bu rehber, GitHub Copilot’u TT Panel geliştirme sürecinde verimli, akıllı ve kontrollü şekilde kullanabilmen için hazırlanmıştır.

---

## 🧠 Copilot Nedir?

- GitHub ve OpenAI tarafından geliştirilen yapay zekâ destekli kod asistanıdır.
- Senin yazdığın yorumlara, fonksiyonlara ve değişkenlere göre **canlı öneriler** üretir.
- VSCode, JetBrains, Neovim gibi editörlerde çalışır.

---

## 🎯 Copilot Ne İşe Yarar?

| Kullanım Alanı           | Açıklama |
|--------------------------|----------|
| Kod tamamlama            | Yazmaya başladığın kodu tahmin eder
| Yorumdan kod üretme      | Açıklamaya göre fonksiyon yazar
| Yinelenen yapılar        | DTO, Guard, Entity gibi şablonları hızlandırır
| Yapı dosyası üretimi     | Dockerfile, YAML, JSON, ENV gibi konfigürasyonlar
| Test yazımı              | Jest/Vitest ile otomatik test fonksiyonları

---

## 🧾 Nasıl Kullanılır?

- Yazarken gri renkte öneriler çıkar
- `Tab` → Öneriyi kabul et
- `Esc` → Reddet
- `Cmd + Enter` → Alternatif önerileri gör
- `Cmd + Shift + [` / `]` → Öneriler arasında geçiş yap

---

## 💬 En Etkili Kullanım Yolu: Yorumla Yönlendirme

### 🔥 Yorum yaz → Kod gelsin

```ts
// E-posta adresine göre kullanıcıyı getir
```
Copilot büyük ihtimalle şunu önerir:

```ts
return await this.prisma.user.findUnique({
  where: { email },
});
```

---

## 🧪 Test ve DTO Yazarken Altın Değerinde

```ts
// Ürün oluşturmak için kullanılan DTO
```

Copilot önerisi:

```ts
export class CreateProductDto {
  @IsString()
  name: string;

  @IsNumber()
  price: number;

  @IsOptional()
  description?: string;
}
```

---

## 🧱 TT Panel’de Copilot’un Parladığı Yerler

| Alan             | Açıklama |
|------------------|----------|
| `*.dto.ts`       | Veri sınıfları, dekoratörler
| `*.service.ts`   | CRUD işlemleri, metot yapıları
| `*.spec.ts`      | Jest/Vitest test fonksiyonları
| `seed.ts`        | Faker + Prisma mock veri üretimi
| `*.module.ts`    | Import, provider tanımı
| `env`, `yml`, `docker` | Konfigürasyon önerileri

---

## ⚠️ Dikkat Edilmesi Gerekenler

| Risk                   | Açıklama |
|------------------------|----------|
| Kod hatası             | Önerilen kod her zaman doğru değildir
| Proje mimarisini bilmez| Sadece açık dosya bağlamında çalışır
| Kod stili uyumsuzluğu  | ESLint ve Prettier ile uyumlu olmayabilir
| Öğrenme tembelliği     | Hazır kodlara fazla güvenmek uzun vadede zararlı olabilir

---

## 📌 İpucu: Kötü Prompt → Kötü Öneri

```ts
// Auth
```
❌ çok genel → işe yaramaz

```ts
// Şifre yanlışsa hata fırlat
```
✅ hedefe yönelik → iyi öneri alırsın

---

## ✨ Sonuç

GitHub Copilot, TT Panel gibi modüler yapılarda:
- Kod yazımını hızlandırır
- Tekrarlayan işlemleri otomatize eder
- Öğrenme sürecini hızlandırır
- Ancak daima kontrol edilmelidir.

---

## ✍️ Ek Not

> Copilot bir kod üretici değil, **asistan** olarak düşünülmelidir.
> Senin mimarini sen belirlersin; Copilot ise seni hızlandırır.
