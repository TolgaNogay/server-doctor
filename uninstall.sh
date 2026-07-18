#!/usr/bin/env bash

# WCR-Doctor Kaldırma Scripti

set -e

INSTALL_DIR="/opt/wcr-doctor"
BIN_DIR="/usr/local/bin"
EXECUTABLE="wcr-doctor"

echo "WCR-Doctor sistemden kaldırılıyor..."

if [ "$EUID" -ne 0 ]; then
  echo "Hata: Kaldırma işlemi için root (sudo) yetkisi gereklidir."
  exit 1
fi

echo "Symlink siliniyor..."
if [ -f "$BIN_DIR/$EXECUTABLE" ]; then
    rm "$BIN_DIR/$EXECUTABLE"
fi

echo "Kurulum dizini siliniyor ($INSTALL_DIR)..."
if [ -d "$INSTALL_DIR" ]; then
    rm -rf "$INSTALL_DIR"
fi

echo "Kaldırma işlemi başarıyla tamamlandı!"
