# WCR-Doctor Geliştirme Promptu

Sen deneyimli bir Linux, Bash, Docker ve DevOps mühendisisin.

Amacımız **WCR-Doctor** isimli, açık kaynak, profesyonel ve tamamen terminal üzerinden çalışan bir sunucu bakım (maintenance), analiz (diagnostics) ve optimizasyon (health check) aracı geliştirmek.

Bu proje kesinlikle tek dosyalık basit bir Bash scripti olmayacak.

Amacımız GitHub'da yayınlanabilecek kalitede, modüler, okunabilir, geliştirilebilir ve profesyonel bir CLI uygulaması oluşturmaktır.

---

## Genel Amaç

WCR-Doctor;

* Sunucunun sağlık durumunu analiz eder.
* Güvenli bakım işlemleri gerçekleştirir.
* Önce/Sonra istatistiklerini gösterir.
* Kazanılan disk alanını hesaplar.
* Sunucu puanı oluşturur.
* Renkli terminal arayüzü sunar.
* Tamamen Türkçe çalışır.
* Üretim sunucularında güvenle kullanılabilir.

---

# Desteklenecek Sistemler

* Ubuntu 22+
* Ubuntu 24+
* Debian 12+
* Docker
* Docker Compose
* Coolify
* Nginx
* Apache
* Node.js
* Next.js
* Strapi
* PostgreSQL
* MariaDB
* MySQL
* Redis

---

# Kullanılacak Teknoloji

İlk sürüm tamamen Bash ile geliştirilecek.

Kod POSIX uyumlu olmaya çalışacak ancak Bash özelliklerinden yararlanılabilir.

Her özellik ayrı dosyada olacak.

Tek dosya yaklaşımı kullanılmayacak.

---

# Klasör Yapısı

wcr-doctor/

bin/

install.sh

uninstall.sh

README.md

LICENSE

config.conf

lib/

assets/

logs/

tests/

---

# Çalıştırma

Program şu komut ile çalışacak:

wcr-doctor

Desteklenecek parametreler:

wcr-doctor

wcr-doctor --bakim

wcr-doctor --analiz

wcr-doctor --docker

wcr-doctor --disk

wcr-doctor --ram

wcr-doctor --rapor

wcr-doctor --guncelle

wcr-doctor --yardim

---

# Arayüz

Program açıldığında büyük bir ASCII logo gösterilecek.

Altında

WCR-Doctor

ve

https://wcr.one

yazacak.

Renkli terminal kullanılacak.

Yeşil

Sarı

Kırmızı

Mavi

Gri

renkleri kullanılacak.

Unicode karakterlerden yararlanılacak.

Progress bar kullanılacak.

Kutulu görünüm kullanılacak.

---

# Menü

Ana menü:

1 Sunucu Analizi

2 Güvenli Bakım

3 Docker Analizi

4 Disk Analizi

5 RAM Analizi

6 Ağ Analizi

7 Log Analizi

8 Rapor Oluştur

9 Ayarlar

0 Çıkış

---

# Analiz

Sunucu hakkında detaylı bilgiler gösterilecek.

Hostname

İşletim Sistemi

Kernel

CPU

CPU yükü

RAM

Swap

Disk

Docker

Docker sürümü

Çalışan container sayısı

Çalışmayan container sayısı

IP adresi

Uptime

Load Average

Sıcaklık (destekleniyorsa)

---

# Güvenli Bakım

Bakım modu kesinlikle çalışan containerları durdurmayacak.

Yapılacak işlemler:

docker image prune -a

docker builder prune

docker volume prune

journalctl vacuum

apt autoremove

apt autoclean

Eski geçici dosyaların temizliği

Eski logların temizliği

İşlem öncesi disk kullanımı kaydedilecek.

İşlem sonrası tekrar ölçülecek.

Ne kadar alan kazanıldığı hesaplanacak.

---

# Docker Analizi

En büyük image

En büyük volume

En büyük container

Kullanılmayan image

Kullanılmayan volume

Docker sürümü

Docker disk kullanımı

Toplam image boyutu

Toplam volume boyutu

---

# Disk Analizi

En büyük klasörler

Disk doluluk oranı

inode kullanımı

SSD bilgisi

Disk tipi

---

# RAM Analizi

RAM kullanımı

Swap kullanımı

Cache

Buffer

Top 10 RAM kullanan process

---

# Ağ Analizi

IP adresi

Gateway

DNS

Ping testi

İnternet bağlantısı

Docker network

---

# Log Analizi

En büyük log dosyaları

Docker logları

Journal boyutu

Apache logları

Nginx logları

---

# Rapor

Bakım sonunda rapor üretilecek.

Örneğin:

BAŞLAMADAN ÖNCE

RAM

Swap

Disk

Docker

İŞLEM SONRASI

RAM

Swap

Disk

Docker

TOPLAM KAZANILAN ALAN

Docker Images

Docker Volumes

Journal

APT

Toplam

---

# Sunucu Puanı

Program sonunda 100 üzerinden puan hesaplayacak.

Örneğin

RAM

Disk

Swap

Docker

CPU

Loglar

Genel Sağlık

98 / 100

Mükemmel

---

# Güvenlik

Program;

Asla

rm -rf /

çalıştırmayacak.

Çalışan containerları silmeyecek.

Aktif volume silmeyecek.

Veritabanı dosyalarına dokunmayacak.

Kullanıcıdan onay almadan kritik işlem yapmayacak.

---

# Kod Kalitesi

Her fonksiyon açıklamalı olacak.

Her dosya yorum satırları içerecek.

Fonksiyonlar küçük tutulacak.

Tekrar eden kod olmayacak.

ShellCheck uyumlu olacak.

Kod okunabilir olacak.

---

# README

Kurulum

Kullanım

Komutlar

Ekran görüntüleri

Katkı sağlama rehberi

Lisans

tam olarak hazırlanacak.

---

# Hedef

Amacımız internetteki en profesyonel Türkçe sunucu bakım CLI aracını geliştirmektir.

Kod üretirken kısa çözümler yerine profesyonel yazılım mimarisi kullanılmalı, ileride yeni modüller kolayca eklenebilmelidir.

Her yeni özellik modüler olacak ve mevcut yapıyı bozmadan genişletilebilecektir.
