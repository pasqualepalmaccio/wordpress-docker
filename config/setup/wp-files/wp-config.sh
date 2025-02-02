#!/bin/sh

# File di configurazione di WordPress
WP_CONFIG="/var/www/html/wp-config.php"

# Controlla se il file esiste
if [ ! -f "$WP_CONFIG" ]; then
    echo "❌ Errore: wp-config.php non trovato!"
    exit 1
fi

# Sostituisci le linee di WP_HOME e WP_SITEURL con la variabile SITE_URL
sed -i "/define('WP_HOME'/d" $WP_CONFIG
sed -i "/define('WP_SITEURL'/d" $WP_CONFIG

echo "define('WP_HOME', getenv('SITE_URL'));" >> $WP_CONFIG
echo "define('WP_SITEURL', getenv('SITE_URL'));" >> $WP_CONFIG

echo "✅ wp-config.php aggiornato con SITE_URL: $SITE_URL"