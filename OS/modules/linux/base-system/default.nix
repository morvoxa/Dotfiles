{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  boot.kernelParams = [
    "quiet"
    "video=1366x768"
  ];
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  networking.hostName = "rustlinux"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  time.timeZone = "Asia/Jakarta";

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  users.users.mor= {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "libvirtd"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ tree ];
    shell = pkgs.zsh;
  };
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
    gnumake

  ];
  system.stateVersion = "25.05"; # Did you read the comment?

}
