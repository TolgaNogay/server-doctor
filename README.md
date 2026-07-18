<div align="center">

# 🩺 WCR-Doctor

**Profesyonel Sunucu Bakım, Analiz ve Optimizasyon Aracı**

[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://opensource.org/licenses/MIT)

*WCR-Doctor*, Linux sunucularınızın sağlık durumunu detaylıca analiz eden, kullanılmayan kaynakları sisteminize zarar vermeden temizleyip yer açan ve son olarak sunucunuzu puanlayan tam teşekküllü, açık kaynak kodlu bir CLI (Komut Satırı) aracıdır.

</div>

---

## 🌟 Neden WCR-Doctor?

Sunucu yönetimi karmaşık komutlar ve riskli temizlik operasyonlarıyla doludur. WCR-Doctor bu işlemleri tek bir merkezde toplar ve **üretim (production) ortamı güvenliğini** en üst düzeyde tutarak çalışır. 

* 🚫 **Tehlikesiz:** Aktif verilerinizi silmez, çalışan Docker container'larını durdurmaz, `rm -rf /` gibi riskli kodlar barındırmaz.
* 📊 **Detaylı Raporlama:** Yapılan bakım sonrası sunucunuzda *ne kadar alan açıldığını* anında hesaplar ve genel durumu **100 üzerinden puanlar**.
* 🇹🇷 **Türkçe ve Renkli Arayüz:** Kullanıcı dostu kutulu görünümleri, progress barları ve tamamen Türkçe menüsü ile çok rahattır.
* 🧩 **Modüler Mimari:** İleride geliştirilmeye açık, her işlemi kendi özel `lib/` modülünde barındıran profesyonel bir yapıya sahiptir.

---

## 🛠 Desteklenen Ortamlar

Aşağıdaki sistemler ve araçlar WCR-Doctor tarafından başarıyla analiz edilir:
* **İşletim Sistemleri:** Ubuntu 22.04+, Ubuntu 24.04+, Debian 12+
* **Altyapı:** Docker, Docker Compose, Coolify
* **Yazılımlar & Web Sunucuları:** Nginx, Apache, Node.js, Next.js, Strapi
* **Veritabanları:** PostgreSQL, MariaDB, MySQL, Redis

---

## 🚀 Özellikler

- **🔍 Sunucu Analizi:** Hostname, İşletim Sistemi, CPU Yükü (Load Average), RAM, Swap ve Genel Disk Doluluğu.
- **🐳 Docker Analizi:** İmaj sayıları, çalışan/duran container'lar, volume detayları ve kullanılmayan alan analizi.
- **🧹 Güvenli Bakım:** APT paket temizliği, eski Systemd Journal loglarının silinmesi ve sadece *kullanılmayan (dangling)* Docker verilerinin yok edilmesi.
- **🌐 Ağ Analizi:** Yerel IP, Dış IP, Ağ Geçidi, DNS sunucuları ve Cloudflare üzerinden ping bağlantı testi.
- **📄 Log Analizi:** Sunucunuzda (özellikle `/var/log` altında) en çok yer kaplayan log dosyalarının listesi ve Journal log boyutu.
- **📈 Puanlama:** RAM, Disk ve CPU metriklerini kullanarak genel bir sunucu sağlığı skoru çıkarma (Örn: `98/100 Mükemmel`).

---

## 📦 Kurulum

Kurulum son derece basittir. Doğrudan tek satırlık komutla (one-liner) sisteminize kurabilirsiniz:

```bash
curl -fsSL https://raw.githubusercontent.com/TolgaNogay/server-doctor/main/install.sh | sudo bash
```

**Manuel Kurulum (Alternatif):**
```bash
# Projeyi indirin
git clone https://github.com/TolgaNogay/server-doctor.git
cd server-doctor

# Kurulumu başlatın (root yetkisi gerektirir)
sudo ./install.sh
```

*(Not: Kurulum yapıldığında `wcr-doctor` komutu doğrudan `/usr/local/bin` dizinine kopyalanarak sistemin her yerinden çalıştırılabilir hale gelir.)*

---

## 💻 Kullanım

WCR-Doctor'u başlatmak için terminale adını yazmanız yeterlidir. Program size görsel bir menü sunacaktır:

```bash
wcr-doctor
```

### Kısayol Parametreleri

Menüye girmeden doğrudan belirli bir komutu tetikleyebilirsiniz:

| Parametre | Açıklama |
| :--- | :--- |
| `wcr-doctor --analiz` | Hızlı sunucu analizini (CPU, RAM, Disk, OS) başlatır. |
| `wcr-doctor --bakim` | Güvenli bakım işlemlerini başlatır (Öncesinde onay ister). |
| `wcr-doctor --docker` | Docker yapılandırması ve imaj/volume kullanımını analiz eder. |
| `wcr-doctor --ag` | IP bilgileri ve internet bağlantı testini çalıştırır. |
| `wcr-doctor --log` | En büyük log dosyalarını tespit eder. |
| `wcr-doctor --rapor` | Sunucunun anlık durumunu değerlendirip 100 üzerinden puanlar. |
| `wcr-doctor --yardim` | Kullanılabilecek tüm komutları listeler. |

---

## 📂 Klasör Yapısı

```text
server-doctor/
├── bin/
│   └── wcr-doctor        # Ana Çalıştırılabilir Giriş (Entrypoint) Dosyası
├── lib/
│   ├── ui.sh             # Renkler, ASCII logo ve kutu çizim fonksiyonları
│   ├── core.sh           # Genel yetki ve byte dönüştürücü çekirdek kodları
│   ├── analysis.sh       # Sistem okuma ve analiz modülü
│   ├── docker.sh         # Docker metrikleri modülü
│   ├── network.sh        # Ağ testi modülü
│   ├── logs.sh           # Log boyutu analiz modülü
│   ├── maintenance.sh    # Güvenli bakım ve temizlik modülü
│   └── report.sh         # Puanlama ve özet modülü
├── config.conf           # Konfigürasyon ve uyarı eşikleri dosyası
├── install.sh            # Sisteme Kurulum betiği
├── uninstall.sh          # Sistemden Kaldırma betiği
├── README.md             # Dokümantasyon
└── LICENSE               # Lisans Bilgileri
```

---

## 🛡️ Güvenlik Uyarıları

* `wcr-doctor` bakım modülünü kullanırken sunucunuzda aktif olan ve çalışan veritabanlarına veya verilerine asla dokunmaz. 
* Ancak, kullanılmayan (dangling) Docker imajları, atıl duruma düşmüş paketler (apt autoremove) ve eski loglar silinir. Bu yüzden *üretim sunucusunda çalıştırmadan önce projelerinizin durumundan emin olmanız önerilir.*

---

## 🤝 Katkıda Bulunma (Contributing)

Bu projeyi geliştirmek isterseniz katkılarınızı büyük bir memnuniyetle kabul ediyoruz!
1. Bu depoyu `fork` edin.
2. Yeni bir özellik dalı (branch) oluşturun: `git checkout -b ozellik/YeniGelistirme`
3. Değişikliklerinizi yapıp `commit` edin: `git commit -m "Yeni özellik eklendi"`
4. Dalınıza `push` yapın: `git push origin ozellik/YeniGelistirme`
5. Bir `Pull Request` (PR) açın.

Yeni geliştirmelerde `lib/` altındaki modüler yapıyı ve POSIX/Bash uyumluluğunu (ShellCheck) dikkate almanızı rica ederiz.

---

## 📄 Lisans

Bu proje **MIT Lisansı** altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına göz atabilirsiniz.
