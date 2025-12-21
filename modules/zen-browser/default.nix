{
  inputs,
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}

#inputs.zen-browser.packages."${system}".default
#inputs.zen-browser.packages."${system}".twilig
