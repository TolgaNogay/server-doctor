#!/usr/bin/env bash

# WCR-Doctor Kurulum Scripti

set -e

INSTALL_DIR="/opt/wcr-doctor"
BIN_DIR="/usr/local/bin"
EXECUTABLE="wcr-doctor"

echo "WCR-Doctor kuruluyor..."

# Root yetkisi kontrolü
if [ "$EUID" -ne 0 ]; then
  echo "Hata: Kurulum için root (sudo) yetkisi gereklidir."
  exit 1
fi

# Önceki kurulumu temizle (varsa)
if [ -d "$INSTALL_DIR" ]; then
    echo "Önceki kurulum bulundu, güncelleniyor..."
    rm -rf "$INSTALL_DIR"
fi

echo "Dosyalar $INSTALL_DIR dizinine kopyalanıyor..."
mkdir -p "$INSTALL_DIR"

# Bulunduğumuz dizini kopyala (kurulumun projenin kökünden yapıldığı varsayılıyor)
cp -r ./* "$INSTALL_DIR/"

echo "Çalıştırılabilir dosya için symlink oluşturuluyor..."
if [ -f "$BIN_DIR/$EXECUTABLE" ]; then
    rm "$BIN_DIR/$EXECUTABLE"
fi

# Bin içindeki ana executable için link
ln -s "$INSTALL_DIR/bin/$EXECUTABLE" "$BIN_DIR/$EXECUTABLE"
chmod +x "$INSTALL_DIR/bin/$EXECUTABLE"

# Tüm kütüphane dosyalarına çalışma izni verelim (önlem olarak)
find "$INSTALL_DIR/lib" -name "*.sh" -exec chmod +x {} \;

echo ""
echo "Kurulum başarıyla tamamlandı!"
echo "Sistemi analiz etmek ve bakıma başlamak için terminale 'wcr-doctor' yazabilirsiniz."
