include .env

start:
	docker-compose up -d
stop:
	docker-compose down --remove-orphans
build: stop 
	docker-compose build

deploy:
	docker-compose exec wordpress bash -c "zip -r /deploy/wp.zip /var/www/html"
	docker-compose exec db bash -c "mysqldump -u ${MYSQL_USER} -p${WORDPRESS_DB_PASSWORD}  ${MYSQL_DATABASE} > /deploy/wpdb.sql"

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