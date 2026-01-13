.PHONY: user host
all:
	echo "Hello world"
user:
	nix run .
	sh ./bin/updateConfig
host:
	sudo nixos-rebuild switch --impure --flake OS/
home: 
	home-manager switch --flake Userconfig/
