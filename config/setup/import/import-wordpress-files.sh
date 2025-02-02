#!/bin/sh

WP_FILES_ZIP="/data/import/wp-files.zip"
WP_FILES_TAR="/data/import/wp-files.tar.gz"
WP_CONFIG_SOURCE="/config/wp-files/wp-config.php"
WP_CONFIG_DEST="/var/www/html/wp-config.php"

echo "🚀 Importazione dei file di WordPress..."

# 🗑 Eliminazione dei vecchi file
echo "🗑 Rimozione dei file esistenti..."
rm -rf /var/www/html/*
echo "✅ File esistenti rimossi!"

# 📦 Estrazione dei nuovi file
if [ -f "$WP_FILES_ZIP" ]; then
    echo "📦 Estrazione da ZIP..."
    unzip -o "$WP_FILES_ZIP" -d /var/www/html
    echo "✅ File estratti da ZIP!"
elif [ -f "$WP_FILES_TAR" ]; then
    echo "📦 Estrazione da TAR.GZ..."
    tar -xzf "$WP_FILES_TAR" -C /var/www/html
    echo "✅ File estratti da TAR.GZ!"
else
    echo "❌ ERRORE: Nessun file di WordPress trovato in /data/import/ (zip o tar.gz)"
    exit 1
fi

# 🔄 Sostituzione di wp-config.php con la versione personalizzata
if [ -f "$WP_CONFIG_SOURCE" ]; then
    echo "🔄 Sostituzione di wp-config.php con la versione personalizzata..."
    cp -f "$WP_CONFIG_SOURCE" "$WP_CONFIG_DEST"
    chmod 644 "$WP_CONFIG_DEST"
    echo "✅ wp-config.php aggiornato!"
else
    echo "⚠️ ATTENZIONE: Il file wp-config.php personalizzato non è stato trovato in /config/wp-files/"
fi

echo "🎉 Importazione dei file completata!"