{
  description = "My Home Manager config";
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
      nixosConfigurations.rustlinux = nixpkgs.lib.nixosSystem {

        inherit system;
        modules = [
          ./modules/base-system # nixos base
          ./modules/zen-browser # nixos base
          ./modules/Cosmic # wndow manager
          ./modules/fonts # fonts config
          ./modules/virt # virtual mechine manager config
          ./modules/pkgs # software or system package
          # specific module
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
