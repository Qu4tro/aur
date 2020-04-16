new: check
	git clone ssh+git://aur@aur.archlinux.org/$(PKG).git
	curl https://git.archlinux.org/pacman.git/plain/proto/PKGBUILD.proto > $(PKG)/PKGBUILD
	cd $(PKG) && makepkg --printsrcinfo > .SRCINFO
	cd $(PKG) && git add .SRCINFO PKGBUILD && git commit -m "Initial commit"
	git submodule add ./$(PKG)


check:
ifndef PKG
	$(error PKG is undefined. Run with PKG=<pkg-name>)
endif
