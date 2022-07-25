SOURCES = aur.sh ghclone.sh
TARGETS = $(basename $(SOURCES))

%.sh:
	sudo cp src/$@ /bin/$(basename $@)
	sudo chmod +x /bin/$(basename $@)

install: $(SOURCES)
	@echo "Installation complete!"

%:
	sudo rm /bin/$@

uninstall: $(TARGETS)
	@echo "Uninstallation complete!"
