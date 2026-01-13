{ pkgs, ... }:

{
  home.username = "mor";
  home.homeDirectory = "/home/mor";

  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.packages = [
    pkgs.fastfetch
    pkgs.stylua
    pkgs.nixd
    pkgs.nixfmt
    pkgs.rustup
    pkgs.clang
  ];

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
