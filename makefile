include .env

start:
	@echo "🚀 Avvio del progetto WordPress con Docker..."
	@docker compose up --build -d
	@echo ""
	@echo "📌 Vuoi importare un sito esistente o creare un nuovo WordPress?"
	@echo "   1) Importare un sito esistente"
	@echo "   2) Creare un nuovo sito da zero"
	@echo ""
	@read -p "📥 Inserisci 1 per importare, 2 per nuovo sito: " choice; \
	if [ "$$choice" = "1" ]; then \
		echo ""; \
		echo "🛠 Per importare un sito esistente, posiziona i file in: "; \
		echo "   - /data/import/wp-files.zip  (o wp-files.tar.gz) per i file di WordPress"; \
		echo "   - /data/import/wp-database.sql per il dump del database"; \
		echo ""; \
		echo "📌 Una volta posizionati i file, esegui: make import-wordpress"; \
	else \
		echo "✅ Installazione completata. WordPress è pronto su ${SITE_URL}"; \
	fi

stop:
	docker-compose down --remove-orphans

# 📦 Backup completo (files + database)
backup: backup-files backup-db
	@echo "✅ Backup completato!"

# 📂 Backup dei file WordPress
backup-files:
	@echo "📦 Backup dei file di WordPress..."
	@docker-compose exec wordpress bash -c "cd /var/www/html && zip -r /backup/wp-backup-$$(date +"%Y%m%d_%H%M%S").zip ."
	@echo "✅ Backup dei file completato!"

# 🛢 Backup del database MySQL
backup-db:
	@echo "📦 Backup del database MySQL..."
	@docker-compose exec db bash -c "mysqldump --default-character-set=utf8mb4 -u ${MYSQL_USER} -p${WORDPRESS_DB_PASSWORD} ${MYSQL_DATABASE} > /backup/wpdb-backup-$$(date +"%Y%m%d_%H%M%S").sql"
	@echo "✅ Backup del database completato!"

# 🔄 Ripristino completo (files + database)
restore: restore-files restore-db
	@echo "✅ Ripristino completato!"

# 🔄 Ripristino dei file WordPress
restore-files:
	@echo "♻️  Cercando l'ultimo backup dei file..."
	@docker-compose exec wordpress bash -c 'LATEST_FILE=$$(ls -t /backup/wp-backup-*.zip | head -n 1); unzip -o $$LATEST_FILE -d /var/www/html'
	@echo "✅ File ripristinati!"

# 🔄 Ripristino del database
restore-db:
	@echo "♻️  Cercando l'ultimo backup del database..."
	@docker-compose exec db bash -c 'LATEST_DB=$$(ls -t /backup/wpdb-backup-*.sql | head -n 1); mysql -u ${MYSQL_USER} -p${WORDPRESS_DB_PASSWORD} ${MYSQL_DATABASE} < $$LATEST_DB'
	@echo "✅ Database ripristinato!"

install-redis-cache:
	docker-compose exec wordpress wp plugin install redis-cache --activate
install-list-plugins:
	@echo "🔧 Installazione plugin WordPress..."
	@docker-compose exec -T wordpress sh -c 'cat /config/setup/plugins/plugins.txt | xargs -n1 wp plugin install --activate --allow-root'
install-custom-plugins:
	@echo "📦 Installazione plugin custom..."
	@docker-compose exec -T wordpress sh -c 'mkdir -p /var/www/html/wp-content/plugins'
	@docker-compose exec -T wordpress sh -c 'for file in /config/setup/plugins/custom-plugins/*.zip; do wp plugin install $$file --activate --allow-root; done'

install-plugins: install-list-plugins install-custom-plugins
	@echo "✅ Tutti i plugin sono stati installati!"

install-themes:
	@echo "🎨 Installazione tema WordPress..."
	@docker-compose exec -T wordpress sh -c 'mkdir -p /var/www/html/wp-content/themes'
	@docker-compose exec -T wordpress sh -c 'for file in /config/setup/themes/*.zip; do wp theme install $$file --activate --allow-root; done'
	@echo "✅ Tema installato e attivato!"


import-wordpress:
	@echo "🔑 Modifica dei permessi sugli script di importazione..."
	@docker-compose exec wordpress chmod +x /config/setup/import/import-wordpress-files.sh
	@docker-compose exec db chmod +x /config/setup/import/import-wordpress-db.sh
	@echo "✅ Permessi aggiornati!"

	@echo "📥 Importazione di WordPress in corso..."
	@docker-compose exec wordpress sh /config/setup/import/import-wordpress-files.sh
	@docker-compose exec db sh /config/setup/import/import-wordpress-db.sh
	@echo "✅ WordPress importato con successo!"