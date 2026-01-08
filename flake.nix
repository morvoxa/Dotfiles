{
  description = "Nixos config for linux or wsl";
  nixConfig = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=10"
      "https://cache.nixos.org/"
    ];
  };
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
    };
  };

  outputs =

    {
      self,
      nixpkgs,
      apple-fonts,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {

        inherit system;
        modules = [
          ./modules/wsl
          #./modules/linux
          {
            nixpkgs.config = {
              allowUnfree = true;
            };
          }
        ];
        specialArgs = { inherit inputs apple-fonts; };
      };
    };
}
