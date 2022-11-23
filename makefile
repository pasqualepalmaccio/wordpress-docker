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
	docker-compose exec db bash -c "mysqldump -u ${MYSQL_USER} -p${WORDPRESS_DB_PASSWORD}  ${MYSQL_DATABASE} > /backup/wpdb-$$(date +"%Y_%m_%d_%I_%M_%p").sql"