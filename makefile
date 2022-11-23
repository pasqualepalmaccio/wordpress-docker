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
	
