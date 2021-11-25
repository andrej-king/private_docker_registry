init: docker-down-clear docker-build docker-up vagrant-up
up: docker-up vagrant-up
down: docker-down vagrant-shutdown
restart: vagrant-restart

# create and run VM
vagrant-up:
	cd ./vagrant && sh -c "vagrant up"

# Pause VM
vagrant-pause:
	cd ./vagrant && sh -c "vagrant suspend"

# down VM
vagrant-shutdown:
	cd ./vagrant && sh -c "vagrant halt"

# restart VM
vagrant-restart:
	cd ./vagrant && sh -c "vagrant restart"

docker-up:
	docker-compose up -d # --scale frontend=3

docker-down:
	docker-compose down --remove-orphans

docker-down-clear:
	docker-compose down -v --remove-orphans

docker-pull:
	docker-compose pull

docker-build:
	docker-compose build #--pull

# generate htpasswd file to lock the registry with login and password (login: "registry", password: "password")
password:
	docker run --rm --entrypoint htpasswd registry:2.6 -Bbn registry password > ./docker/development/nginx/auth/htpasswd
	# docker run --entrypoint htpasswd httpd:2 -Bbn registry password > ./docker/development/nginx/auth/htpasswd

deploy:
	ssh deploy@${HOST} -p ${PORT} 'rm -rf registry && mkdir registry'
	scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:registry/docker-compose.yml
	scp -P ${PORT} -r docker deploy@${HOST}:registry/docker
	scp -P ${PORT} ${HTPASSWD_FILE} deploy@${HOST}:registry/htpasswd
	ssh deploy@${HOST} -p ${PORT} 'cd registry && echo "COMPOSE_PROJECT_NAME=registry" >> .env'
	ssh deploy@${HOST} -p ${PORT} 'cd registry && docker-compose down --remove-orphans'
	ssh deploy@${HOST} -p ${PORT} 'cd registry && docker-compose pull'
	ssh deploy@${HOST} -p ${PORT} 'cd registry && docker-compose up -d'
