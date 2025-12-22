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
    vscodium-fhs
    cargo
    rustc
    rust-analyzer
    rustfmt
    btop
    prettierd
    ntfs3g
    p7zip
  ];
}
