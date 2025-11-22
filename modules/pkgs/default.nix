{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clang
    stylua
    nixfmt-rfc-style
    lsd
    fzf
    tmux
    fastfetch
    nixd
    vscode-fhs
    cargo
    rustc
    waybar
    wofi
    swaybg
    apple-cursor
    rust-analyzer
    rustfmt
    btop
  ];
}
