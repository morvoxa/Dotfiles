{ pkgs, apple-fonts, ... }:
{
  # Enable fontconfig
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    # Add Apple fonts from the module
    packages = [
      apple-fonts.packages.x86_64-linux.sf-pro
      pkgs.nerd-fonts.fira-code
      pkgs.nerd-fonts.droid-sans-mono
    ];

    # Optional: set default font preferences
    fontconfig.defaultFonts = {
      sansSerif = [ "SF Pro Display" ];
      serif = [ "New York" ];
      monospace = [ "SF Mono" ];
    };
  };
}
