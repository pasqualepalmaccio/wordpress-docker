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

backup:
	docker-compose exec wordpress bash -c "zip -r /backup/wp-$$(date +"%Y_%m_%d_%I_%M_%p").zip /var/www/html"
	docker-compose exec db bash -c "mysqldump --default-character-set=utf8mb4 --collation-connection=utf8mb4_general_ci --column-statistics=0 -u ${MYSQL_USER} -p${WORDPRESS_DB_PASSWORD}  ${MYSQL_DATABASE} > /backup/wpdb-$$(date +"%Y_%m_%d_%I_%M_%p").sql"
backup-db:
	docker-compose exec db bash -c "mysqldump --default-character-set=utf8mb4 --column-statistics=0 -u ${MYSQL_USER} -p${WORDPRESS_DB_PASSWORD} ${MYSQL_DATABASE} > /backup/wpdb-\$(date +\"%Y_%m_%d_%I_%M_%p\").sql && sed -i 's/utf8mb3_uca1400_ai_ci/utf8mb4_general_ci/g' /backup/wpdb-\$(date +\"%Y_%m_%d_%I_%M_%p\").sql && sed -i 's/DEFAULT CHARSET=utf8mb3/DEFAULT CHARSET=utf8mb4/g' /backup/wpdb-\$(date +\"%Y_%m_%d_%I_%M_%p\").sql"
