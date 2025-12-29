[![Version](https://img.shields.io/badge/version-1.1.0-blue.svg)](https://github.com/XeldarAlz)
[![License](https://img.shields.io/badge/license-Non--Commercial-red.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/flutter-%3E%3D3.10.0-blue.svg)](https://flutter.dev/)
[![Platform](https://img.shields.io/badge/platform-cross--platform-lightgrey.svg)]()
[![Sponsor](https://img.shields.io/badge/sponsor-30363D?style=flat-square&logo=GitHub-Sponsors&logoColor=#EA4AAA)](https://github.com/sponsors/XeldarAlz)

> **Dil**: [English](README.md) | [Türkçe](README_TR.md)

# Ne Yapsak?

Bulunduğunuz konuma yakın yapılacak aktiviteleri hızlıca gösteren basit bir Flutter uygulaması. Konum izni verdikten sonra tek dokunuşla rastgele bir aktivite, motivasyon mesajı, görsel ve bu aktiviteyle ilgili yakın yer önerileri görürsünüz.

Uygulama, feature odaklı modüller halinde organize edilmiştir ve Google Maps / Places API ile çalışır.

<img src="docs/screenshots/app_ui_1.png" alt="Ne Yapsak arayüzü 1" width="250" /> <img src="docs/screenshots/app_ui_2.png" alt="Ne Yapsak arayüzü 2" width="250" /> <img src="docs/screenshots/app_ui_3.png" alt="Ne Yapsak arayüzü 3" width="250" />

## ✨ Özellikler

- **🎲 Rastgele Aktivite Üretme**  
  Konumunuza göre kişiselleştirilmiş aktivite önerileri, motivasyon mesajları ve güzel görsellerle.

- **📍 Yakın Yer Önerileri**  
  Seçtiğiniz aktiviteye uygun mekanları Google Places API ile keşfedin, gerçek zamanlı mesafe hesaplamalarıyla.

- **📊 Akıllı Sıralama ve Sayfalama**  
  Sonuçlar mesafeye göre akıllıca sıralanır ve sayfalama desteğiyle verimli bir şekilde gösterilir.

- **🎨 Zengin Görsel Deneyim**  
  Yumuşak animasyonlar, gradientler ve konfeti efektleriyle güzel aktivite kartları. Unsplash'ten yüksek kaliteli görseller.

- **🔔 İnteraktif Geri Bildirim**  
  Haptik geri bildirim, konfeti animasyonları ve ses efektleri kullanıcı deneyimini zenginleştirir.

## 🏗️ Mimari

Proje, net bir sorumluluk ayrımıyla **feature-first mimari** yaklaşımını takip eder:

### 🎯 Çekirdek Katman
Tüm uygulama genelinde kullanılan paylaşılan yardımcı programlar ve yapılandırmalar:
- **Sabitler**: Uygulama genelindeki yapılandırma değerleri ve boyutlar
- **Tema Sistemi**: Kapsamlı renk paleti, tipografi ve tam karanlık mod desteğiyle Material 3 temalama
- **Gradientler**: Görsel tutarlılık için yeniden kullanılabilir gradient tanımları

### 📦 Özellik Modülleri

#### **Aktiviteler**
Aktivite verilerini ve içerik üretimini yönetir:
- Aktivite modelleri ve kategoriler
- Motivasyon mesajı üretimi
- Unsplash API'den görsel çekme

#### **Konum**
Tüm konumla ilgili işlevselliği yönetir:
- İzin yönetimi
- Mevcut konum alma
- Özel istisnalarla hata yönetimi

#### **Yerler**
Google Places API ile entegrasyon:
- Yakındaki yer arama ve keşif
- Yer verisi dönüştürme ve modelleme
- Mesafeye dayalı sıralama algoritmaları

#### **Ses**
Ses geri bildirimi sağlar:
- Ses efekti çalma
- Ses kaynakları için varlık yönetimi

#### **Ana Sayfa**
Ana kullanıcı arayüzü ve etkileşimi:
- Aktivite üretim orkestrasyonu
- Konum izni akışı
- Sıralama ve sayfalama ile yer listesi görüntüleme
- Hata durumu yönetimi
- Yeniden kullanılabilir UI bileşenleri (kartlar, döşemeler)

### 🔄 Veri Akışı

```
Kullanıcı Aksiyonu → Konum Servisi → Aktivite Üretici → 
Yerler Deposu → UI Bileşenleri → Kullanıcı Geri Bildirimi
```

## 🚀 Başlangıç

### Gereksinimler

- Flutter SDK (>=3.10.0)
- Google Maps / Places API anahtarı
- Unsplash API anahtarı (opsiyonel, ancak önerilir)

### Kurulum

1. Depoyu klonlayın
2. Bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```

3. API anahtarlarıyla uygulamayı çalıştırın:
   ```bash
   flutter run \
     --dart-define=GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_KEY \
     --dart-define=UNSPLASH_API_KEY=YOUR_UNSPLASH_KEY
   ```

> **Not**: Unsplash API anahtarı opsiyoneldir ancak daha zengin bir görsel deneyim için önerilir. API anahtarlarını her zaman ortam değişkenleri veya CI/CD ayarlarıyla güvenli bir şekilde yönetin.

## 🛠️ Teknoloji Yığını

- **Framework**: Material 3 tasarımıyla Flutter
- **Konum**: Konum servisleri için Geolocator
- **Haritalar**: Google Maps / Places API entegrasyonu
- **Görseller**: Yüksek kaliteli görseller için Unsplash API
- **Animasyonlar**: Konfeti efektleri ve yumuşak geçişler
- **Ses**: Ses geri bildirimi için ses oynatıcılar

## 📄 Lisans

Bu proje, **Ticari Olmayan Lisans** altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

**Yalnızca Ticari Olmayan Kullanım**: Bu yazılım yalnızca kişisel, eğitimsel ve ticari olmayan kullanım için sağlanmıştır. Ticari kullanım için telif hakkı sahibinden açık yazılı izin gereklidir.

## 💝 Sponsors

Bu projeyi faydalı buluyorsanız, desteklemeyi düşünün:

[![Sponsor](https://img.shields.io/badge/Sponsor-EA4AAA?style=for-the-badge&logo=github-sponsors&logoColor=white)](https://github.com/sponsors/XeldarAlz)

Desteğiniz bu projenin sürdürülmesine ve geliştirilmesine yardımcı olur.

---

<div align="center">

⭐ Bu repo'yu ilginç buluyorsanız yıldızlayın!

</div>

