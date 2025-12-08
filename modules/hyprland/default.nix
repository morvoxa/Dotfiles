{ pkgs, ... }:
{
  programs.hyprland.enable = true;
  services.displayManager.ly.enable = true;
  environment.systemPackages = with pkgs; [
    waybar
    wofi
    swaybg
    apple-cursor
    kitty
  ];
}
