init: vagrant-up

# create and run VB
vagrant-up:
	cd ./vagrant && sh -c "vagrant up"

# Pause VB
vagrant-pause:
	cd ./vagrant && sh -c "vagrant suspend"

# down VB
vagrant-shutdown:
	cd ./vagrant && sh -c "vagrant halt"
