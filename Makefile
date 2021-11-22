init: vagrant-up
down: vagrant-shutdown
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
