install:
	sudo cp aur.sh /bin/aur
	sudo chmod +x /bin/aur
	sudo cp ghclone.sh /bin/ghclone
	sudo chmod +x /bin/ghclone

uninstall:
	sudo rm /bin/aur
	sudo rm /bin/ghclone
