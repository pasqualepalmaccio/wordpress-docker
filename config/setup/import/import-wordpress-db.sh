#!/bin/sh

WP_DB="/data/import/wp-database.sql"
MYSQL_DATABASE=$(printenv MYSQL_DATABASE)
MYSQL_USER=$(printenv MYSQL_USER)
WORDPRESS_DB_PASSWORD=$(printenv WORDPRESS_DB_PASSWORD)

echo "🚀 Importazione del database di WordPress..."

# 🔍 Controllo che il file esista
if [ ! -f "$WP_DB" ]; then
    echo "❌ ERRORE: Il file wp-database.sql non è stato trovato in /data/import/"
    exit 1
fi

# 🗑 Eliminazione di tutti i database esistenti
echo "🗑 Eliminazione del database $MYSQL_DATABASE..."
mysql -u"${MYSQL_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e "DROP DATABASE IF EXISTS \`$MYSQL_DATABASE\`;"
echo "✅ Database eliminato!"

# 📦 Creazione del database
echo "🛢 Creazione del nuovo database: $MYSQL_DATABASE..."
mysql -u"${MYSQL_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e "CREATE DATABASE \`$MYSQL_DATABASE\` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
echo "✅ Database creato!"

# 🔄 Importazione del database
echo "🔄 Importazione del database in $MYSQL_DATABASE..."
mysql -u"${MYSQL_USER}" -p"${WORDPRESS_DB_PASSWORD}" "$MYSQL_DATABASE" < "$WP_DB" 2>&1 | tee /data/import/db-import.log
echo "✅ Database importato con successo!"

echo "🎉 Importazione del database completata!"