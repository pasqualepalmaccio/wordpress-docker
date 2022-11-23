start:
	docker-compose up -d
stop:
	docker-compose down --remove-orphans
build: stop 
	docker-compose build

deploy:
	docker-compose exec wordpress bash -c "zip -r /deploy/wp.zip /var/www/html"
	docker-compose exec db bash -c "mysqldump -u wordpress -pwordpress  wordpress > /deploy/wpdb.sql"
	
