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
	docker run --entrypoint htpasswd httpd:2 -Bbn registry password > htpasswd
