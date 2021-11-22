init: vagrant-up
down: vagrant-shutdown
restart: vagrant-restart

# create and run VB
vagrant-up:
	cd ./vagrant && sh -c "vagrant up"

# Pause VB
vagrant-pause:
	cd ./vagrant && sh -c "vagrant suspend"

# down VB
vagrant-shutdown:
	cd ./vagrant && sh -c "vagrant halt"

vagrant-restart:
	cd ./vagrant && sh -c "vagrant restart"
