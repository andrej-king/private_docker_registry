server:
	ansible-playbook -i hosts.yml server.yml # -vvvv show log level details

upgrade:
	ansible-playbook -i hosts.yml upgrade.yml

renew-certificates:
	ansible-playbook -i hosts.yml renew-certificates.yml

authorize:
	ansible-playbook -i hosts.yml authorize.yml

check-alive-hosts:
	ansible all -m ping -i hosts.yml
