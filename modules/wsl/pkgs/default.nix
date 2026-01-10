{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    git
    vim
    fastfetch
    gnumake
    tmux
    lsd
    appimage-run
    nixfmt
    nixd
    rust-analyzer
    rustfmt
    rustup
    tmux
    fzf
    clang
  ];
}
