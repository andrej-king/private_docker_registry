init: docker-down-clear docker-build docker-up
up: docker-up
down: docker-down

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
	 docker run --rm --entrypoint htpasswd httpd:2 -Bbn registry password > htpasswd
	#docker run --rm --entrypoint htpasswd registry:2.6 -Bbn registry password > htpasswd

# HOST=0.0.0.0 PORT=0 HTPASSWD_FILE=htpasswd BUILD_NUMBER=4 make deploy
deploy:
	- ssh deploy@${HOST} -p ${PORT} 'rm -rf registry_${BUILD_NUMBER} && mkdir registry_${BUILD_NUMBER}'
	scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:registry_${BUILD_NUMBER}/docker-compose.yml
	scp -P ${PORT} -r docker deploy@${HOST}:registry_${BUILD_NUMBER}/docker
	scp -P ${PORT} ${HTPASSWD_FILE} deploy@${HOST}:registry_${BUILD_NUMBER}/htpasswd
	ssh deploy@${HOST} -p ${PORT} 'cd registry_${BUILD_NUMBER} && echo "COMPOSE_PROJECT_NAME=registry" >> .env'
	ssh deploy@${HOST} -p ${PORT} 'cd registry_${BUILD_NUMBER} && docker-compose down --remove-orphans'
#	ssh deploy@${HOST} -p ${PORT} 'cd registry_${BUILD_NUMBER} && docker-compose pull'
	ssh deploy@${HOST} -p ${PORT} 'cd registry_${BUILD_NUMBER} && docker-compose up -d'
